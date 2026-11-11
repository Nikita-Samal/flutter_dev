/// Morrow Application Constants
class AppConstants {
  AppConstants._();

  // App info
  static const String appName = 'Morrow';
  static const String appTagline = 'Care for Her. Care for Every Beginning.';
  static const String appFooterTagline = 'A little care, every step of the way.';
  static const String appVersion = '1.0.0';

  // Privacy & Terms
  static const String privacyPolicyUrl = 'https://morrowapp.com/privacy';
  static const String termsOfServiceUrl = 'https://morrowapp.com/terms';

  // Animation durations
  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationMedium = Duration(milliseconds: 350);
  static const Duration animationSlow = Duration(milliseconds: 500);
  static const Duration animationVerySlow = Duration(milliseconds: 800);

  // Layout
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;
  static const double paddingXXL = 48.0;

  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 20.0;
  static const double radiusXXL = 28.0;
  static const double radiusFull = 100.0;

  static const double buttonHeight = 56.0;
  static const double inputHeight = 56.0;

  // Firestore collections
  static const String usersCollection = 'users';
  static const String profilesCollection = 'profiles';

  // SharedPreferences keys
  static const String keyOnboardingComplete = 'onboarding_complete';
  static const String keyThemeMode = 'theme_mode';
}
