import 'package:equatable/equatable.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object?> get props => [];
}

/// Advance to next onboarding step
class NextStepPressed extends OnboardingEvent {
  const NextStepPressed();
}

/// Navigate back to previous step
class PreviousStepPressed extends OnboardingEvent {
  const PreviousStepPressed();
}

/// Step 2: Update Date of Birth (recalculates age & LifeStage)
class DateOfBirthChanged extends OnboardingEvent {
  final DateTime dateOfBirth;

  const DateOfBirthChanged(this.dateOfBirth);

  @override
  List<Object?> get props => [dateOfBirth];
}

/// Step 3: Toggle a health condition in selection
class HealthConditionToggled extends OnboardingEvent {
  final String condition;

  const HealthConditionToggled(this.condition);

  @override
  List<Object?> get props => [condition];
}

/// Step 4: Toggle a medication or supplement
class MedicationToggled extends OnboardingEvent {
  final String medication;

  const MedicationToggled(this.medication);

  @override
  List<Object?> get props => [medication];
}

/// Step 5: Update lifestyle parameters
class LifestyleUpdated extends OnboardingEvent {
  final String? exerciseFrequency;
  final double? sleepHours;
  final String? alcoholIntake;
  final String? smokingStatus;

  const LifestyleUpdated({
    this.exerciseFrequency,
    this.sleepHours,
    this.alcoholIntake,
    this.smokingStatus,
  });

  @override
  List<Object?> get props => [exerciseFrequency, sleepHours, alcoholIntake, smokingStatus];
}

/// Step 6: Update emergency contact / caregiver details
class EmergencyContactUpdated extends OnboardingEvent {
  final String name;
  final String phone;
  final String relationship;

  const EmergencyContactUpdated({
    required this.name,
    required this.phone,
    required this.relationship,
  });

  @override
  List<Object?> get props => [name, phone, relationship];
}

/// Finish clinical intake and compute definitive profile
class OnboardingSubmitted extends OnboardingEvent {
  const OnboardingSubmitted();
}
