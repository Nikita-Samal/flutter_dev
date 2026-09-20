import 'package:equatable/equatable.dart';
import '../../core/constants/life_stage_constants.dart';

/// User Profile Domain Entity
/// Represents an authenticated user's clinical demographics, biometric baseline,
/// intake from onboarding, and assigned men's health life stage.
/// Pure Dart (zero Flutter/Firebase dependencies).
class UserProfile extends Equatable {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  final LifeStage lifeStage;
  final double? heightCm;
  final double? weightKg;
  final String? bloodType;
  final bool isCaregiverEnabled;

  // Clinical Onboarding Intake
  final List<String> healthConditions;
  final List<String> currentMedications;
  final String? exerciseFrequency;
  final double? typicalSleepHours;
  final String? alcoholIntake;
  final String? smokingStatus;
  final String? emergencyContactName;
  final String? emergencyContactPhone;
  final String? emergencyContactRelationship;
  final bool isOnboardingCompleted;

  final DateTime createdAt;
  final DateTime updatedAt;

  const UserProfile({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.lifeStage,
    this.heightCm,
    this.weightKg,
    this.bloodType,
    this.isCaregiverEnabled = false,
    this.healthConditions = const [],
    this.currentMedications = const [],
    this.exerciseFrequency,
    this.typicalSleepHours,
    this.alcoholIntake,
    this.smokingStatus,
    this.emergencyContactName,
    this.emergencyContactPhone,
    this.emergencyContactRelationship,
    this.isOnboardingCompleted = false,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Firebase user identification alias
  String get uid => id;

  /// Computed full name
  String get fullName => '$firstName $lastName'.trim();

  /// Computed display name (falls back to email if name is unset)
  String get displayName => fullName.isNotEmpty ? fullName : (firstName.isNotEmpty ? firstName : email);

  /// Computed chronological age
  int get age {
    final today = DateTime.now();
    int computedAge = today.year - dateOfBirth.year;
    if (today.month < dateOfBirth.month ||
        (today.month == dateOfBirth.month && today.day < dateOfBirth.day)) {
      computedAge--;
    }
    return computedAge;
  }

  /// Computed Body Mass Index (BMI)
  double? get bmi {
    if (heightCm == null || weightKg == null || heightCm! <= 0) return null;
    final heightInMeters = heightCm! / 100.0;
    return weightKg! / (heightInMeters * heightInMeters);
  }

  /// Creates a copy of this profile with updated attributes
  UserProfile copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    DateTime? dateOfBirth,
    LifeStage? lifeStage,
    double? heightCm,
    double? weightKg,
    String? bloodType,
    bool? isCaregiverEnabled,
    List<String>? healthConditions,
    List<String>? currentMedications,
    String? exerciseFrequency,
    double? typicalSleepHours,
    String? alcoholIntake,
    String? smokingStatus,
    String? emergencyContactName,
    String? emergencyContactPhone,
    String? emergencyContactRelationship,
    bool? isOnboardingCompleted,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserProfile(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      lifeStage: lifeStage ?? this.lifeStage,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      bloodType: bloodType ?? this.bloodType,
      isCaregiverEnabled: isCaregiverEnabled ?? this.isCaregiverEnabled,
      healthConditions: healthConditions ?? this.healthConditions,
      currentMedications: currentMedications ?? this.currentMedications,
      exerciseFrequency: exerciseFrequency ?? this.exerciseFrequency,
      typicalSleepHours: typicalSleepHours ?? this.typicalSleepHours,
      alcoholIntake: alcoholIntake ?? this.alcoholIntake,
      smokingStatus: smokingStatus ?? this.smokingStatus,
      emergencyContactName: emergencyContactName ?? this.emergencyContactName,
      emergencyContactPhone: emergencyContactPhone ?? this.emergencyContactPhone,
      emergencyContactRelationship:
          emergencyContactRelationship ?? this.emergencyContactRelationship,
      isOnboardingCompleted:
          isOnboardingCompleted ?? this.isOnboardingCompleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        firstName,
        lastName,
        dateOfBirth,
        lifeStage,
        heightCm,
        weightKg,
        bloodType,
        isCaregiverEnabled,
        healthConditions,
        currentMedications,
        exerciseFrequency,
        typicalSleepHours,
        alcoholIntake,
        smokingStatus,
        emergencyContactName,
        emergencyContactPhone,
        emergencyContactRelationship,
        isOnboardingCompleted,
        createdAt,
        updatedAt,
      ];
}
