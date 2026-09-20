import 'package:equatable/equatable.dart';

/// Substance Classification
enum SubstanceCategory {
  alcohol,
  caffeine,
  nicotine,
  cannabis,
  other,
}

/// Substance Log Domain Entity
/// Represents tracking of stimulants, alcohol, nicotine, or other substances
/// to correlate with sleep architecture, heart rate variability, and testosterone levels.
/// Pure Dart (zero Flutter/Firebase dependencies).
class SubstanceLog extends Equatable {
  final String id;
  final String userId;
  final SubstanceCategory category;
  final String substanceName;
  final double quantity;
  final String unit; // e.g. 'mg', 'standard drinks', 'units'
  final DateTime recordedAt;
  final String? contextOrTrigger;
  final String? notes;

  const SubstanceLog({
    required this.id,
    required this.userId,
    required this.category,
    required this.substanceName,
    required this.quantity,
    required this.unit,
    required this.recordedAt,
    this.contextOrTrigger,
    this.notes,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        category,
        substanceName,
        quantity,
        unit,
        recordedAt,
        contextOrTrigger,
        notes,
      ];
}
