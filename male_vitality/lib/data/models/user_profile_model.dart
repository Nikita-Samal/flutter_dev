import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/constants/life_stage_constants.dart';
import '../../domain/entities/user_profile.dart';

/// UserProfile Data Transfer Object (DTO)
/// Bridges Domain Entity with Firestore and JSON persistence.
class UserProfileModel extends UserProfile {
  const UserProfileModel({
    required super.id,
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.dateOfBirth,
    required super.lifeStage,
    super.heightCm,
    super.weightKg,
    super.bloodType,
    super.isCaregiverEnabled,
    super.healthConditions,
    super.currentMedications,
    super.exerciseFrequency,
    super.typicalSleepHours,
    super.alcoholIntake,
    super.smokingStatus,
    super.emergencyContactName,
    super.emergencyContactPhone,
    super.emergencyContactRelationship,
    super.isOnboardingCompleted,
    required super.createdAt,
    required super.updatedAt,
  });

  /// Factory converting from a pure domain [UserProfile] entity
  factory UserProfileModel.fromEntity(UserProfile entity) {
    return UserProfileModel(
      id: entity.id,
      email: entity.email,
      firstName: entity.firstName,
      lastName: entity.lastName,
      dateOfBirth: entity.dateOfBirth,
      lifeStage: entity.lifeStage,
      heightCm: entity.heightCm,
      weightKg: entity.weightKg,
      bloodType: entity.bloodType,
      isCaregiverEnabled: entity.isCaregiverEnabled,
      healthConditions: entity.healthConditions,
      currentMedications: entity.currentMedications,
      exerciseFrequency: entity.exerciseFrequency,
      typicalSleepHours: entity.typicalSleepHours,
      alcoholIntake: entity.alcoholIntake,
      smokingStatus: entity.smokingStatus,
      emergencyContactName: entity.emergencyContactName,
      emergencyContactPhone: entity.emergencyContactPhone,
      emergencyContactRelationship: entity.emergencyContactRelationship,
      isOnboardingCompleted: entity.isOnboardingCompleted,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  /// Parses date from dynamic value (handles Firestore [Timestamp] and [String])
  static DateTime _parseDateTime(dynamic value, [DateTime? fallback]) {
    if (value is Timestamp) {
      return value.toDate();
    } else if (value is String && value.isNotEmpty) {
      return DateTime.tryParse(value) ?? fallback ?? DateTime.now();
    }
    return fallback ?? DateTime.now();
  }

  /// Factory creating [UserProfileModel] from JSON map
  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    final rawDisplayName = (json['displayName'] ?? json['display_name'])?.toString();
    final nameTokens = rawDisplayName?.split(' ') ?? [];
    final fallbackFirst = nameTokens.isNotEmpty ? nameTokens.first : '';
    final fallbackLast = nameTokens.length > 1 ? nameTokens.sublist(1).join(' ') : '';

    return UserProfileModel(
      id: (json['id'] ?? json['uid']) as String? ?? '',
      email: (json['email'] as String? ?? '').trim(),
      firstName: (json['first_name'] as String? ?? fallbackFirst).trim(),
      lastName: (json['last_name'] as String? ?? fallbackLast).trim(),
      dateOfBirth: _parseDateTime(json['date_of_birth']),
      lifeStage: LifeStage.values.firstWhere(
        (s) => s.id == json['life_stage'],
        orElse: () => LifeStage.youngAdult,
      ),
      heightCm: (json['height_cm'] as num?)?.toDouble(),
      weightKg: (json['weight_kg'] as num?)?.toDouble(),
      bloodType: json['blood_type'] as String?,
      isCaregiverEnabled: json['is_caregiver_enabled'] as bool? ?? false,
      healthConditions: (json['health_conditions'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      currentMedications: (json['current_medications'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      exerciseFrequency: json['exercise_frequency'] as String?,
      typicalSleepHours: (json['typical_sleep_hours'] as num?)?.toDouble(),
      alcoholIntake: json['alcohol_intake'] as String?,
      smokingStatus: json['smoking_status'] as String?,
      emergencyContactName: json['emergency_contact_name'] as String?,
      emergencyContactPhone: json['emergency_contact_phone'] as String?,
      emergencyContactRelationship:
          json['emergency_contact_relationship'] as String?,
      isOnboardingCompleted:
          json['is_onboarding_completed'] as bool? ?? false,
      createdAt: _parseDateTime(json['created_at']),
      updatedAt: _parseDateTime(json['updated_at']),
    );
  }

  /// Factory creating [UserProfileModel] directly from a Cloud Firestore DocumentSnapshot
  factory UserProfileModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data() ?? {};
    final enrichedData = Map<String, dynamic>.from(data);
    enrichedData['id'] = snapshot.id;
    enrichedData['uid'] = snapshot.id;
    return UserProfileModel.fromJson(enrichedData);
  }

  /// Serializes to standard JSON Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': id,
      'email': email,
      'displayName': displayName,
      'display_name': displayName,
      'first_name': firstName,
      'last_name': lastName,
      'date_of_birth': dateOfBirth.toIso8601String(),
      'life_stage': lifeStage.id,
      'height_cm': heightCm,
      'weight_kg': weightKg,
      'blood_type': bloodType,
      'is_caregiver_enabled': isCaregiverEnabled,
      'health_conditions': healthConditions,
      'current_medications': currentMedications,
      'exercise_frequency': exerciseFrequency,
      'typical_sleep_hours': typicalSleepHours,
      'alcohol_intake': alcoholIntake,
      'smoking_status': smokingStatus,
      'emergency_contact_name': emergencyContactName,
      'emergency_contact_phone': emergencyContactPhone,
      'emergency_contact_relationship': emergencyContactRelationship,
      'is_onboarding_completed': isOnboardingCompleted,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// Serializes to Firestore Document representation with native Timestamps
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'uid': id,
      'email': email,
      'displayName': displayName,
      'display_name': displayName,
      'first_name': firstName,
      'last_name': lastName,
      'date_of_birth': Timestamp.fromDate(dateOfBirth),
      'life_stage': lifeStage.id,
      'height_cm': heightCm,
      'weight_kg': weightKg,
      'blood_type': bloodType,
      'is_caregiver_enabled': isCaregiverEnabled,
      'health_conditions': healthConditions,
      'current_medications': currentMedications,
      'exercise_frequency': exerciseFrequency,
      'typical_sleep_hours': typicalSleepHours,
      'alcohol_intake': alcoholIntake,
      'smoking_status': smokingStatus,
      'emergency_contact_name': emergencyContactName,
      'emergency_contact_phone': emergencyContactPhone,
      'emergency_contact_relationship': emergencyContactRelationship,
      'is_onboarding_completed': isOnboardingCompleted,
      'created_at': Timestamp.fromDate(createdAt),
      'updated_at': Timestamp.fromDate(updatedAt),
    };
  }
}
