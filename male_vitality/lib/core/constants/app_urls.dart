/// MaleVitality API & Web Endpoint Definitions
abstract class AppUrls {
  // Base URLs
  static const String baseDevUrl = 'https://dev-api.malevitality.com/v1';
  static const String baseStagingUrl = 'https://staging-api.malevitality.com/v1';
  static const String baseProdUrl = 'https://api.malevitality.com/v1';

  // Active Base URL
  static const String currentBaseUrl = baseDevUrl;

  // Authentication & Identity
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String refreshToken = '/auth/refresh-token';
  static const String logout = '/auth/logout';
  static const String forgotPassword = '/auth/forgot-password';
  static const String verifyMfa = '/auth/mfa/verify';

  // Health Tracking & Biomarkers
  static const String vitals = '/tracking/vitals';
  static const String hormones = '/tracking/hormones';
  static const String sleep = '/tracking/sleep';
  static const String mood = '/tracking/mood';
  static const String workouts = '/tracking/workouts';
  static const String substances = '/tracking/substances';

  // Screenings & Clinical Orders
  static const String screenings = '/screenings';
  static const String labOrders = '/screenings/lab-orders';
  static const String diagnosticResults = '/screenings/results';

  // Medications & Prescriptions
  static const String medications = '/medications';
  static const String refills = '/medications/refills';

  // Caregiver Network
  static const String caregivers = '/caregivers';

  // Telehealth & Consultations
  static const String appointments = '/telehealth/appointments';
  static const String videoSignalingSocket = 'wss://telehealth.malevitality.com/ws';

  // Legal & Compliance
  static const String privacyPolicy = 'https://malevitality.com/legal/privacy';
  static const String hipaaCompliance = 'https://malevitality.com/legal/hipaa';
  static const String termsOfService = 'https://malevitality.com/legal/terms';
}
