import '../entities/user_profile.dart';

/// User Repository Contract
abstract class UserRepository {
  Future<UserProfile?> getCurrentUserProfile();
  Future<void> updateProfile(UserProfile profile);
}
