import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/constants/life_stage_constants.dart';
import '../../../../core/error/failures.dart';
import '../../../../data/datasources/remote/user_remote_datasource.dart';
import '../../../../data/models/user_profile_model.dart';
import '../../../../domain/entities/user_profile.dart';
import '../../domain/repositories/auth_repository.dart';

/// Concrete [AuthRepository] implementation using Firebase Authentication
/// and Cloud Firestore for User Profile persistence and real-time synchronization.
class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final UserRemoteDataSource _userRemoteDataSource;

  FirebaseAuthRepository({
    FirebaseAuth? firebaseAuth,
    UserRemoteDataSource? userRemoteDataSource,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _userRemoteDataSource = userRemoteDataSource ??
            FirebaseUserRemoteDataSource(
              firestore: FirebaseFirestore.instance,
              auth: firebaseAuth ?? FirebaseAuth.instance,
            );

  @override
  Future<Either<Failure, UserProfile?>> getCurrentUser() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        return const Right(null);
      }

      final profile = await _userRemoteDataSource.getUserProfile(user.uid);
      if (profile != null) {
        return Right(profile);
      }

      // If document does not exist yet in Firestore, derive baseline from Auth user
      final nameParts = (user.displayName ?? '').trim().split(' ');
      final firstName = nameParts.isNotEmpty ? nameParts.first : 'Vitality';
      final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : 'Member';

      final fallbackProfile = UserProfileModel(
        id: user.uid,
        email: user.email ?? '',
        firstName: firstName,
        lastName: lastName,
        dateOfBirth: DateTime(1995, 1, 1),
        lifeStage: LifeStage.primeVitality,
        isOnboardingCompleted: false,
        createdAt: user.metadata.creationTime ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _userRemoteDataSource.saveUserProfile(fallbackProfile);
      return Right(fallbackProfile);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to retrieve user session: $e'));
    }
  }

  @override
  Stream<UserProfile?> watchCurrentUserProfile() {
    late StreamController<UserProfile?> controller;
    StreamSubscription<User?>? authSub;
    StreamSubscription<UserProfileModel?>? profileSub;

    controller = StreamController<UserProfile?>.broadcast(
      onListen: () {
        authSub = _firebaseAuth.authStateChanges().listen(
          (user) {
            profileSub?.cancel();
            if (user == null) {
              controller.add(null);
            } else {
              profileSub = _userRemoteDataSource.watchUserProfile(user.uid).listen(
                (profile) {
                  controller.add(profile);
                },
                onError: (Object e) => controller.addError(e),
              );
            }
          },
          onError: (Object e) => controller.addError(e),
        );
      },
      onCancel: () {
        profileSub?.cancel();
        authSub?.cancel();
      },
    );

    return controller.stream;
  }

  @override
  Future<Either<Failure, UserProfile>> login({
    required String email,
    required String password,
  }) async {
    try {
      if (email.trim().isEmpty || password.isEmpty) {
        return const Left(ValidationFailure(message: 'Email and password are required.'));
      }

      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final user = credential.user;
      if (user == null) {
        return const Left(AuthFailure(message: 'Authentication failed. Please try again.'));
      }

      final profile = await _userRemoteDataSource.getUserProfile(user.uid);
      if (profile != null) {
        return Right(profile);
      }

      // If no Firestore profile exists yet, create one
      final nameParts = (user.displayName ?? '').trim().split(' ');
      final firstName = nameParts.isNotEmpty && nameParts.first.isNotEmpty ? nameParts.first : 'Member';
      final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

      final newProfile = UserProfileModel(
        id: user.uid,
        email: user.email ?? email.trim().toLowerCase(),
        firstName: firstName,
        lastName: lastName,
        dateOfBirth: DateTime(1995, 1, 1),
        lifeStage: LifeStage.primeVitality,
        isOnboardingCompleted: false,
        createdAt: user.metadata.creationTime ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _userRemoteDataSource.saveUserProfile(newProfile);
      return Right(newProfile);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(message: _mapFirebaseAuthErrorCode(e.code, e.message)));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected login error: $e'));
    }
  }

  @override
  Future<Either<Failure, UserProfile>> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      if (firstName.trim().isEmpty || lastName.trim().isEmpty) {
        return const Left(ValidationFailure(message: 'Please provide your full legal name.'));
      }
      if (email.trim().isEmpty || !email.contains('@')) {
        return const Left(ValidationFailure(message: 'Please enter a valid email address.'));
      }
      if (password.length < 8) {
        return const Left(ValidationFailure(message: 'Password must be at least 8 characters.'));
      }

      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final user = credential.user;
      if (user == null) {
        return const Left(AuthFailure(message: 'Account registration failed.'));
      }

      final fullName = '$firstName $lastName'.trim();
      await user.updateDisplayName(fullName);

      final initialProfile = UserProfileModel(
        id: user.uid,
        email: email.trim().toLowerCase(),
        firstName: firstName.trim(),
        lastName: lastName.trim(),
        dateOfBirth: DateTime(1995, 1, 1),
        lifeStage: LifeStage.primeVitality,
        isOnboardingCompleted: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _userRemoteDataSource.saveUserProfile(initialProfile);
      return Right(initialProfile);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(message: _mapFirebaseAuthErrorCode(e.code, e.message)));
    } catch (e) {
      return Left(ServerFailure(message: 'Account creation error: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _firebaseAuth.signOut();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Logout failed: $e'));
    }
  }

  @override
  Future<Either<Failure, UserProfile>> completeOnboarding(UserProfile updatedProfile) async {
    try {
      final profileToSave = UserProfileModel.fromEntity(
        updatedProfile.copyWith(
          isOnboardingCompleted: true,
          updatedAt: DateTime.now(),
        ),
      );

      await _userRemoteDataSource.saveUserProfile(profileToSave);
      return Right(profileToSave);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to persist clinical onboarding data: $e'));
    }
  }

  @override
  Future<Either<Failure, UserProfile>> updateUserProfile(UserProfile profile) async {
    try {
      final profileToSave = UserProfileModel.fromEntity(
        profile.copyWith(
          updatedAt: DateTime.now(),
        ),
      );

      await _userRemoteDataSource.saveUserProfile(profileToSave);
      return Right(profileToSave);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to update user profile: $e'));
    }
  }

  /// Maps Firebase Auth error codes to helpful, user-friendly clinical messages
  String _mapFirebaseAuthErrorCode(String code, String? defaultMessage) {
    switch (code) {
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Invalid email or password. Please verify your credentials.';
      case 'email-already-in-use':
        return 'An account already exists for this email address.';
      case 'weak-password':
        return 'The password provided is too weak. Must be at least 8 characters.';
      case 'invalid-email':
        return 'The email address is formatted incorrectly.';
      case 'user-disabled':
        return 'This account has been disabled. Please contact clinical support.';
      case 'too-many-requests':
        return 'Too many consecutive login attempts. Access temporarily restricted.';
      default:
        return defaultMessage ?? 'Authentication error encountered ($code).';
    }
  }
}
