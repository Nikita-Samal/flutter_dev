import 'package:intl/intl.dart';

/// Clinical and General Date/Time Utilities
abstract class AppDateUtils {
  static final DateFormat _standardDateFormat = DateFormat('MMM dd, yyyy');
  static final DateFormat _shortDateFormat = DateFormat('MMM d');
  static final DateFormat _timeFormat = DateFormat('hh:mm a');
  static final DateFormat _dateTimeFormat = DateFormat('MMM dd, yyyy · hh:mm a');
  static final DateFormat _apiDateFormat = DateFormat('yyyy-MM-dd');

  /// Formats: "Oct 14, 2026"
  static String formatStandard(DateTime date) => _standardDateFormat.format(date);

  /// Formats: "Oct 14"
  static String formatShort(DateTime date) => _shortDateFormat.format(date);

  /// Formats: "09:30 AM"
  static String formatTime(DateTime date) => _timeFormat.format(date);

  /// Formats: "Oct 14, 2026 · 09:30 AM"
  static String formatDateTime(DateTime date) => _dateTimeFormat.format(date);

  /// Formats for API queries: "2026-10-14"
  static String formatForApi(DateTime date) => _apiDateFormat.format(date);

  /// Calculates chronological age from Date of Birth
  static int calculateAge(DateTime dateOfBirth, [DateTime? referenceDate]) {
    final today = referenceDate ?? DateTime.now();
    int age = today.year - dateOfBirth.year;
    if (today.month < dateOfBirth.month ||
        (today.month == dateOfBirth.month && today.day < dateOfBirth.day)) {
      age--;
    }
    return age;
  }

  /// Returns friendly humanized time for clinical logs
  static String formatRelative(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes <= 1) return 'Just now';
        return '${difference.inMinutes} mins ago';
      }
      return '${difference.inHours} hrs ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return formatStandard(date);
    }
  }

  /// Days remaining until upcoming screening or lab order
  static int daysUntil(DateTime targetDate) {
    final today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final target = DateTime(targetDate.year, targetDate.month, targetDate.day);
    return target.difference(today).inDays;
  }
}
