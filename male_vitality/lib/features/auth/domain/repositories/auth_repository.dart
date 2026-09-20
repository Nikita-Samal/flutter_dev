import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../domain/entities/user_profile.dart';

/// Pure Dart Authentication Repository Contract
abstract class AuthRepository {
  /// Checks whether a valid session exists
  Future<Either<Failure, UserProfile?>> getCurrentUser();

  /// Real-time stream of the current authenticated user's profile
  Stream<UserProfile?> watchCurrentUserProfile();

  /// Authenticates user with email and password
  Future<Either<Failure, UserProfile>> login({
    required String email,
    required String password,
  });

  /// Registers a new user account
  Future<Either<Failure, UserProfile>> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  });

  /// Logs out the current user session
  Future<Either<Failure, void>> logout();

  /// Persists clinical intake & onboarding data
  Future<Either<Failure, UserProfile>> completeOnboarding(UserProfile updatedProfile);

  /// Updates user clinical demographics, biometrics, and intake details
  Future<Either<Failure, UserProfile>> updateUserProfile(UserProfile profile);
}
