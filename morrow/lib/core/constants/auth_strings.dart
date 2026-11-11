/// Auth-related string constants
class AuthStrings {
  AuthStrings._();

  // Generic
  static const String required = 'This field is required.';
  static const String networkError =
      'Please check your internet connection and try again.';
  static const String unexpectedError =
      'Something went wrong. Please try again.';

  // Email
  static const String emailRequired = 'Please enter your email address.';
  static const String emailInvalid = 'Please enter a valid email address.';

  // Password
  static const String passwordRequired = 'Please enter your password.';
  static const String passwordTooShort =
      'Password must be at least 8 characters.';
  static const String passwordsDoNotMatch = 'Passwords do not match.';

  // Sign-in errors (Firebase)
  static const String signInWrongPassword =
      'Incorrect password. Please try again.';
  static const String signInUserNotFound =
      'No account found with this email. Please create an account.';
  static const String signInUserDisabled =
      'This account has been disabled. Please contact support.';
  static const String signInTooManyRequests =
      'Too many sign-in attempts. Please try again later.';
  static const String signInInvalidCredential =
      'Invalid email or password. Please try again.';

  // Password reset
  static const String passwordResetSent =
      'A password reset link has been sent to your email.';
  static const String passwordResetUserNotFound =
      'No account found with this email address.';

  // Registration
  static const String emailAlreadyInUse =
      'An account already exists with this email.';
  static const String weakPassword =
      'Password is too weak. Please choose a stronger password.';

  // Google Sign-In
  static const String googleSignInCancelled = 'Google sign-in was cancelled.';
  static const String googleSignInFailed =
      'Google sign-in failed. Please try again.';

  // Apple Sign-In
  static const String appleSignInCancelled = 'Apple sign-in was cancelled.';
  static const String appleSignInFailed =
      'Apple sign-in failed. Please try again.';
}
