import 'package:equatable/equatable.dart';

/// Type of Physical Exercise or Training
enum WorkoutType {
  strengthTraining,
  hypertrophy,
  zone2Cardio,
  hiit,
  mobilityRecovery,
  sportsAthletics,
}

/// Workout Session Domain Entity
/// Represents an exercise session logged for muscular hypertrophy, cardiovascular health, or recovery.
/// Pure Dart (zero Flutter/Firebase dependencies).
class WorkoutSession extends Equatable {
  final String id;
  final String userId;
  final WorkoutType type;
  final String title;
  final int durationMinutes;
  final int? caloriesBurned;
  final int? averageHeartRate;
  final int? maxHeartRate;
  final int? perceivedExertionRpe; // Scale 1 (very light) to 10 (maximal effort)
  final List<String> targetMuscleGroups;
  final DateTime completedAt;
  final String? notes;

  const WorkoutSession({
    required this.id,
    required this.userId,
    required this.type,
    required this.title,
    required this.durationMinutes,
    this.caloriesBurned,
    this.averageHeartRate,
    this.maxHeartRate,
    this.perceivedExertionRpe,
    this.targetMuscleGroups = const [],
    required this.completedAt,
    this.notes,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        type,
        title,
        durationMinutes,
        caloriesBurned,
        averageHeartRate,
        maxHeartRate,
        perceivedExertionRpe,
        targetMuscleGroups,
        completedAt,
        notes,
      ];
}
