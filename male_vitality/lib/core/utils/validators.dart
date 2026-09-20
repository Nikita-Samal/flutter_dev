import '../constants/app_constants.dart';

/// Form and Clinical Input Validation Helpers
abstract class Validators {
  /// Validates non-empty field
  static String? required(String? value, [String message = 'This field is required']) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  /// Validates standard email address
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email address is required';
    }
    if (!AppConstants.emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  /// Validates secure password
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    }
    if (!RegExp(r'[!@#\$&*~_]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  /// Validates phone number
  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    final cleanPhone = value.replaceAll(RegExp(r'[\s()-]'), '');
    if (!AppConstants.phoneRegex.hasMatch(cleanPhone)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  /// Validates clinical age (adult health platform)
  static String? adultAge(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Age is required';
    }
    final age = int.tryParse(value.trim());
    if (age == null) {
      return 'Please enter a valid number';
    }
    if (age < 18) {
      return 'MaleVitality is intended for adults aged 18 and older';
    }
    if (age > 120) {
      return 'Please enter a valid age';
    }
    return null;
  }

  /// Validates Blood Pressure Systolic (mmHg)
  static String? systolicBp(String? value) {
    if (value == null || value.trim().isEmpty) return null; // Optional entry
    final num = int.tryParse(value.trim());
    if (num == null || num < 60 || num > 250) {
      return 'Enter valid systolic value (60-250 mmHg)';
    }
    return null;
  }

  /// Validates Blood Pressure Diastolic (mmHg)
  static String? diastolicBp(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    final num = int.tryParse(value.trim());
    if (num == null || num < 40 || num > 160) {
      return 'Enter valid diastolic value (40-160 mmHg)';
    }
    return null;
  }

  /// Validates Total Testosterone level (ng/dL)
  static String? testosteroneLevel(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    final num = double.tryParse(value.trim());
    if (num == null || num < 50 || num > 2500) {
      return 'Enter valid testosterone level (50-2500 ng/dL)';
    }
    return null;
  }
}
