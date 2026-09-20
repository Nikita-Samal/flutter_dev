import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/local/user_local_datasource.dart';
import '../datasources/remote/user_remote_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<UserProfile?> getCurrentUserProfile() async {
    try {
      final remoteProfile = await remoteDataSource.fetchUserProfile();
      await localDataSource.cacheUserProfile(remoteProfile);
      return remoteProfile;
    } catch (_) {
      return await localDataSource.getLastCachedProfile();
    }
  }

  @override
  Future<void> updateProfile(UserProfile profile) async {
    // Implementation for updating profile
  }
}
