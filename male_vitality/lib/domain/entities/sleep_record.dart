import 'package:equatable/equatable.dart';

/// Sleep Record Domain Entity
/// Represents polysomnography or wearable sleep architecture data,
/// duration, efficiency, deep/REM staging, and autonomic recovery (HRV).
/// Pure Dart (zero Flutter/Firebase dependencies).
class SleepRecord extends Equatable {
  final String id;
  final String userId;
  final DateTime bedTime;
  final DateTime wakeTime;
  final int totalDurationMinutes;
  final int? deepSleepMinutes;
  final int? remSleepMinutes;
  final int? lightSleepMinutes;
  final int? awakeDurationMinutes;
  final int? sleepScore; // Scale 0 to 100
  final int? restingHeartRateBpm;
  final int? averageHrvMs;
  final String? notes;

  const SleepRecord({
    required this.id,
    required this.userId,
    required this.bedTime,
    required this.wakeTime,
    required this.totalDurationMinutes,
    this.deepSleepMinutes,
    this.remSleepMinutes,
    this.lightSleepMinutes,
    this.awakeDurationMinutes,
    this.sleepScore,
    this.restingHeartRateBpm,
    this.averageHrvMs,
    this.notes,
  });

  /// Computed duration in hours
  double get totalDurationHours => totalDurationMinutes / 60.0;

  /// Computed percentage of restorative sleep (Deep + REM)
  double? get restorativeSleepPercentage {
    if (deepSleepMinutes == null || remSleepMinutes == null || totalDurationMinutes <= 0) {
      return null;
    }
    return ((deepSleepMinutes! + remSleepMinutes!) / totalDurationMinutes) * 100.0;
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        bedTime,
        wakeTime,
        totalDurationMinutes,
        deepSleepMinutes,
        remSleepMinutes,
        lightSleepMinutes,
        awakeDurationMinutes,
        sleepScore,
        restingHeartRateBpm,
        averageHrvMs,
        notes,
      ];
}
