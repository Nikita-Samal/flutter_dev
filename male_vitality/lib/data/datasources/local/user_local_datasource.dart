import '../../models/user_profile_model.dart';

abstract class UserLocalDataSource {
  Future<UserProfileModel?> getLastCachedProfile();
  Future<void> cacheUserProfile(UserProfileModel profile);
  Future<void> clearCache();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  UserProfileModel? _cachedProfile;

  @override
  Future<UserProfileModel?> getLastCachedProfile() async {
    return _cachedProfile;
  }

  @override
  Future<void> cacheUserProfile(UserProfileModel profile) async {
    _cachedProfile = profile;
  }

  @override
  Future<void> clearCache() async {
    _cachedProfile = null;
  }
}
