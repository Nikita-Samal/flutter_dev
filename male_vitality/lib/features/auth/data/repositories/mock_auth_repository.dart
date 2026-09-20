import 'dart:async';
import 'package:dartz/dartz.dart';
import '../../../../core/constants/life_stage_constants.dart';
import '../../../../core/error/failures.dart';
import '../../../../domain/entities/user_profile.dart';
import '../../domain/repositories/auth_repository.dart';

/// In-Memory Mock Authentication Repository for development and testing
class MockAuthRepository implements AuthRepository {
  UserProfile? _currentUser;
  bool _isOnboardingCompleted = false;
  final StreamController<UserProfile?> _profileController =
      StreamController<UserProfile?>.broadcast();

  MockAuthRepository({UserProfile? initialUser, bool isOnboardingCompleted = false})
      : _currentUser = initialUser,
        _isOnboardingCompleted = isOnboardingCompleted;

  bool get isOnboardingCompleted => _isOnboardingCompleted;

  @override
  Future<Either<Failure, UserProfile?>> getCurrentUser() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return Right(_currentUser);
  }

  @override
  Stream<UserProfile?> watchCurrentUserProfile() async* {
    yield _currentUser;
    yield* _profileController.stream;
  }

  @override
  Future<Either<Failure, UserProfile>> login({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));

    if (email.trim().isEmpty || password.isEmpty) {
      return const Left(ValidationFailure(message: 'Email and password are required.'));
    }

    if (password.length < 6) {
      return const Left(AuthFailure(message: 'Invalid email or password credentials.'));
    }

    // Default mock user profile (Prime Vitality life stage)
    _currentUser = UserProfile(
      id: 'usr_mv_101',
      email: email.trim().toLowerCase(),
      firstName: 'Marcus',
      lastName: 'Vance',
      dateOfBirth: DateTime(1992, 6, 15),
      lifeStage: LifeStage.primeVitality,
      heightCm: 182.0,
      weightKg: 84.5,
      bloodType: 'O+',
      isCaregiverEnabled: false,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    );
    _isOnboardingCompleted = true;
    _profileController.add(_currentUser);

    return Right(_currentUser!);
  }

  @override
  Future<Either<Failure, UserProfile>> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 700));

    if (firstName.trim().isEmpty || lastName.trim().isEmpty) {
      return const Left(ValidationFailure(message: 'Please provide your full legal name.'));
    }

    if (email.trim().isEmpty || !email.contains('@')) {
      return const Left(ValidationFailure(message: 'Please enter a valid email address.'));
    }

    if (password.length < 8) {
      return const Left(ValidationFailure(message: 'Password must be at least 8 characters.'));
    }

    // New profile initialized before onboarding data collection
    _currentUser = UserProfile(
      id: 'usr_mv_${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      email: email.trim().toLowerCase(),
      firstName: firstName.trim(),
      lastName: lastName.trim(),
      dateOfBirth: DateTime(1995, 1, 1),
      lifeStage: LifeStage.primeVitality,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    _isOnboardingCompleted = false;
    _profileController.add(_currentUser);

    return Right(_currentUser!);
  }

  @override
  Future<Either<Failure, void>> logout() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    _currentUser = null;
    _isOnboardingCompleted = false;
    _profileController.add(null);
    return const Right(null);
  }

  @override
  Future<Either<Failure, UserProfile>> completeOnboarding(UserProfile updatedProfile) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    _currentUser = updatedProfile;
    _isOnboardingCompleted = true;
    _profileController.add(_currentUser);
    return Right(_currentUser!);
  }

  @override
  Future<Either<Failure, UserProfile>> updateUserProfile(UserProfile profile) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    _currentUser = profile.copyWith(updatedAt: DateTime.now());
    _profileController.add(_currentUser);
    return Right(_currentUser!);
  }

  void dispose() {
    _profileController.close();
  }
}
