import 'package:equatable/equatable.dart';
import '../../../../core/constants/life_stage_constants.dart';
import '../../../../domain/entities/user_profile.dart';

enum OnboardingStatus { initial, inProgress, submitting, success, failure }

class OnboardingState extends Equatable {
  final int currentStep; // 1 to 6
  final int totalSteps;
  final DateTime dateOfBirth;
  final int calculatedAge;
  final LifeStage calculatedLifeStage;
  final List<String> healthConditions;
  final List<String> currentMedications;
  final String exerciseFrequency;
  final double typicalSleepHours;
  final String alcoholIntake;
  final String smokingStatus;
  final String emergencyContactName;
  final String emergencyContactPhone;
  final String emergencyContactRelationship;
  final OnboardingStatus status;
  final String? errorMessage;
  final UserProfile? completedProfile;

  const OnboardingState({
    this.currentStep = 1,
    this.totalSteps = 6,
    required this.dateOfBirth,
    required this.calculatedAge,
    required this.calculatedLifeStage,
    this.healthConditions = const [],
    this.currentMedications = const [],
    this.exerciseFrequency = '3-4 days/week',
    this.typicalSleepHours = 7.5,
    this.alcoholIntake = '1-2 drinks/week',
    this.smokingStatus = 'Non-smoker',
    this.emergencyContactName = '',
    this.emergencyContactPhone = '',
    this.emergencyContactRelationship = 'Spouse / Partner',
    this.status = OnboardingStatus.initial,
    this.errorMessage,
    this.completedProfile,
  });

  factory OnboardingState.initial() {
    final defaultDob = DateTime(1994, 5, 20); // 32 years old default
    final age = DateTime.now().year - defaultDob.year;
    return OnboardingState(
      dateOfBirth: defaultDob,
      calculatedAge: age,
      calculatedLifeStage: LifeStage.fromAge(age),
    );
  }

  double get progressPercentage => currentStep / totalSteps;

  OnboardingState copyWith({
    int? currentStep,
    DateTime? dateOfBirth,
    int? calculatedAge,
    LifeStage? calculatedLifeStage,
    List<String>? healthConditions,
    List<String>? currentMedications,
    String? exerciseFrequency,
    double? typicalSleepHours,
    String? alcoholIntake,
    String? smokingStatus,
    String? emergencyContactName,
    String? emergencyContactPhone,
    String? emergencyContactRelationship,
    OnboardingStatus? status,
    String? errorMessage,
    UserProfile? completedProfile,
  }) {
    return OnboardingState(
      currentStep: currentStep ?? this.currentStep,
      totalSteps: totalSteps,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      calculatedAge: calculatedAge ?? this.calculatedAge,
      calculatedLifeStage: calculatedLifeStage ?? this.calculatedLifeStage,
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
      status: status ?? this.status,
      errorMessage: errorMessage,
      completedProfile: completedProfile ?? this.completedProfile,
    );
  }

  @override
  List<Object?> get props => [
        currentStep,
        totalSteps,
        dateOfBirth,
        calculatedAge,
        calculatedLifeStage,
        healthConditions,
        currentMedications,
        exerciseFrequency,
        typicalSleepHours,
        alcoholIntake,
        smokingStatus,
        emergencyContactName,
        emergencyContactPhone,
        emergencyContactRelationship,
        status,
        errorMessage,
        completedProfile,
      ];
}
