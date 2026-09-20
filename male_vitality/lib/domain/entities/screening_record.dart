import 'package:equatable/equatable.dart';

/// Clinical Screening Categories
enum ScreeningCategory {
  hormone,
  cardiovascular,
  oncology,
  metabolic,
  sexualHealth,
  general,
}

/// Status of Clinical Screening
enum ScreeningStatus {
  pending,
  scheduled,
  completed,
  overdue,
  waived,
}

/// Screening Record Domain Entity
/// Represents diagnostic screening protocols, lab orders, and preventative health checks.
/// Pure Dart (zero Flutter/Firebase dependencies).
class ScreeningRecord extends Equatable {
  final String id;
  final String userId;
  final String title;
  final ScreeningCategory category;
  final ScreeningStatus status;
  final DateTime dueDate;
  final DateTime? completedDate;
  final String? providerName;
  final String? labLocation;
  final String? resultSummary;
  final bool isAbnormal;
  final List<String> recommendations;

  const ScreeningRecord({
    required this.id,
    required this.userId,
    required this.title,
    required this.category,
    required this.status,
    required this.dueDate,
    this.completedDate,
    this.providerName,
    this.labLocation,
    this.resultSummary,
    this.isAbnormal = false,
    this.recommendations = const [],
  });

  /// Computed flag for whether screening is overdue
  bool get isOverdue {
    if (status == ScreeningStatus.completed || status == ScreeningStatus.waived) {
      return false;
    }
    return DateTime.now().isAfter(dueDate);
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        title,
        category,
        status,
        dueDate,
        completedDate,
        providerName,
        labLocation,
        resultSummary,
        isAbnormal,
        recommendations,
      ];
}
