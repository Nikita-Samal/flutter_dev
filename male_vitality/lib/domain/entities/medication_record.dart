import 'package:equatable/equatable.dart';

/// Clinical Classification of Medication
enum MedicationCategory {
  prescription,
  hormoneReplacement,
  supplement,
  overTheCounter,
}

/// Medication Record Domain Entity
/// Represents prescribed therapies (e.g., TRT protocols, peptides), longevity supplements,
/// dosages, schedules, and active refill tracking.
/// Pure Dart (zero Flutter/Firebase dependencies).
class MedicationRecord extends Equatable {
  final String id;
  final String userId;
  final String name;
  final String dosage;
  final String frequency;
  final MedicationCategory category;
  final DateTime startDate;
  final DateTime? endDate;
  final String? prescriber;
  final int? remainingDoses;
  final bool isActive;
  final List<String> reminderTimes;
  final String? instructions;

  const MedicationRecord({
    required this.id,
    required this.userId,
    required this.name,
    required this.dosage,
    required this.frequency,
    required this.category,
    required this.startDate,
    this.endDate,
    this.prescriber,
    this.remainingDoses,
    this.isActive = true,
    this.reminderTimes = const [],
    this.instructions,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        name,
        dosage,
        frequency,
        category,
        startDate,
        endDate,
        prescriber,
        remainingDoses,
        isActive,
        reminderTimes,
        instructions,
      ];
}
