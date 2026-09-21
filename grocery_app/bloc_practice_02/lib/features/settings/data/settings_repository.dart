/// Example repository for Settings feature.
/// In a real app this would persist preferences (SharedPreferences / Hive).
class SettingsRepository {
  Future<bool> getDarkModePreference() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return false; // default light
  }

  Future<void> saveDarkModePreference(bool isDark) async {
    await Future.delayed(const Duration(milliseconds: 100));
    // persist here
  }
}
