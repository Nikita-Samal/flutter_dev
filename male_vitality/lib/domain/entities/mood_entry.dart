import 'package:equatable/equatable.dart';

/// Mood Entry Domain Entity
/// Captures mental wellness check-ins, perceived stress, energy, and emotional state.
/// Pure Dart (zero Flutter/Firebase dependencies).
class MoodEntry extends Equatable {
  final String id;
  final String userId;
  final int overallScore; // Scale 1 (very low) to 10 (optimal vitality)
  final int stressLevel; // Scale 1 (none) to 5 (extreme)
  final int energyLevel; // Scale 1 (exhausted) to 5 (peak energy)
  final String primaryEmotion;
  final List<String> contributingFactors;
  final String? journalNotes;
  final DateTime recordedAt;

  const MoodEntry({
    required this.id,
    required this.userId,
    required this.overallScore,
    required this.stressLevel,
    required this.energyLevel,
    required this.primaryEmotion,
    this.contributingFactors = const [],
    this.journalNotes,
    required this.recordedAt,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        overallScore,
        stressLevel,
        energyLevel,
        primaryEmotion,
        contributingFactors,
        journalNotes,
        recordedAt,
      ];
}
