/// MaleVitality Application Constants
abstract class AppConstants {
  // Application Metadata
  static const String appName = 'MaleVitality';
  static const String appVersion = '1.0.0';
  static const String buildNumber = '1';
  static const String supportEmail = 'support@malevitality.com';

  // Network & Timeout Settings
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
  static const Duration sendTimeout = Duration(seconds: 15);
  static const Duration cacheMaxAge = Duration(hours: 1);

  // Pagination Settings
  static const int defaultPageSize = 20;
  static const int maxPageSize = 50;

  // Session & Security Settings
  static const Duration sessionInactivityTimeout = Duration(minutes: 15);
  static const int maxLoginAttempts = 5;

  // Local Storage Keys
  static const String keyAccessToken = 'mv_access_token';
  static const String keyRefreshToken = 'mv_refresh_token';
  static const String keyUserId = 'mv_user_id';
  static const String keyOnboardingCompleted = 'mv_onboarding_completed';
  static const String keyBiometricsEnabled = 'mv_biometrics_enabled';
  static const String keyThemeMode = 'mv_theme_mode';

  // Regular Expressions
  static final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp phoneRegex = RegExp(
    r'^\+?[1-9]\d{1,14}$',
  );
}
