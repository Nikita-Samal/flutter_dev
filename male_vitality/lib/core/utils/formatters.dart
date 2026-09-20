import 'package:intl/intl.dart';

/// Clinical Biomarker and Display Formatters
abstract class AppFormatters {
  static final NumberFormat _currencyFormat = NumberFormat.currency(
    symbol: '\$',
    decimalDigits: 2,
  );

  /// Formats Blood Pressure (e.g., "120/80 mmHg")
  static String formatBloodPressure(int systolic, int diastolic) {
    return '$systolic/$diastolic mmHg';
  }

  /// Formats Total Testosterone (e.g., "650 ng/dL")
  static String formatTestosterone(double level, {bool showUnit = true}) {
    final formatted = level.toStringAsFixed(0);
    return showUnit ? '$formatted ng/dL' : formatted;
  }

  /// Formats Free Testosterone (e.g., "18.5 pg/mL")
  static String formatFreeTestosterone(double level, {bool showUnit = true}) {
    final formatted = level.toStringAsFixed(1);
    return showUnit ? '$formatted pg/mL' : formatted;
  }

  /// Formats Fasting Glucose (e.g., "94 mg/dL")
  static String formatGlucose(double level, {bool showUnit = true}) {
    final formatted = level.toStringAsFixed(0);
    return showUnit ? '$formatted mg/dL' : formatted;
  }

  /// Formats Heart Rate (e.g., "68 bpm")
  static String formatHeartRate(int bpm) {
    return '$bpm bpm';
  }

  /// Formats Sleep duration from fractional hours (e.g., 7.5 -> "7h 30m")
  static String formatSleepHours(double hours) {
    final int h = hours.floor();
    final int m = ((hours - h) * 60).round();
    if (m == 0) return '${h}h';
    return '${h}h ${m}m';
  }

  /// Formats Weight (supports kg and lbs)
  static String formatWeight(double weight, {bool isLbs = true}) {
    return '${weight.toStringAsFixed(1)} ${isLbs ? "lbs" : "kg"}';
  }

  /// Formats Telehealth Consultation Fee (e.g., "$120.00")
  static String formatCurrency(double amount) {
    return _currencyFormat.format(amount);
  }

  /// Formats 10-digit phone number: (555) 123-4567
  static String formatPhoneNumber(String phone) {
    final digits = phone.replaceAll(RegExp(r'\D'), '');
    if (digits.length == 10) {
      return '(${digits.substring(0, 3)}) ${digits.substring(3, 6)}-${digits.substring(6)}';
    }
    return phone;
  }
}
