import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/life_stage_constants.dart';
import '../../../../domain/entities/user_profile.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final AuthRepository _authRepository;

  OnboardingBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(OnboardingState.initial()) {
    on<NextStepPressed>(_onNextStepPressed);
    on<PreviousStepPressed>(_onPreviousStepPressed);
    on<DateOfBirthChanged>(_onDateOfBirthChanged);
    on<HealthConditionToggled>(_onHealthConditionToggled);
    on<MedicationToggled>(_onMedicationToggled);
    on<LifestyleUpdated>(_onLifestyleUpdated);
    on<EmergencyContactUpdated>(_onEmergencyContactUpdated);
    on<OnboardingSubmitted>(_onOnboardingSubmitted);
  }

  void _onNextStepPressed(
    NextStepPressed event,
    Emitter<OnboardingState> emit,
  ) {
    if (state.currentStep < state.totalSteps) {
      emit(state.copyWith(
        currentStep: state.currentStep + 1,
        status: OnboardingStatus.inProgress,
      ));
    } else {
      add(const OnboardingSubmitted());
    }
  }

  void _onPreviousStepPressed(
    PreviousStepPressed event,
    Emitter<OnboardingState> emit,
  ) {
    if (state.currentStep > 1) {
      emit(state.copyWith(
        currentStep: state.currentStep - 1,
        status: OnboardingStatus.inProgress,
      ));
    }
  }

  void _onDateOfBirthChanged(
    DateOfBirthChanged event,
    Emitter<OnboardingState> emit,
  ) {
    final today = DateTime.now();
    int age = today.year - event.dateOfBirth.year;
    if (today.month < event.dateOfBirth.month ||
        (today.month == event.dateOfBirth.month && today.day < event.dateOfBirth.day)) {
      age--;
    }

    final calculatedStage = LifeStage.fromAge(age);

    emit(state.copyWith(
      dateOfBirth: event.dateOfBirth,
      calculatedAge: age,
      calculatedLifeStage: calculatedStage,
      status: OnboardingStatus.inProgress,
    ));
  }

  void _onHealthConditionToggled(
    HealthConditionToggled event,
    Emitter<OnboardingState> emit,
  ) {
    final currentList = List<String>.from(state.healthConditions);
    if (event.condition == 'None') {
      currentList.clear();
      currentList.add('None');
    } else {
      currentList.remove('None');
      if (currentList.contains(event.condition)) {
        currentList.remove(event.condition);
      } else {
        currentList.add(event.condition);
      }
    }
    emit(state.copyWith(healthConditions: currentList, status: OnboardingStatus.inProgress));
  }

  void _onMedicationToggled(
    MedicationToggled event,
    Emitter<OnboardingState> emit,
  ) {
    final currentList = List<String>.from(state.currentMedications);
    if (event.medication == 'None') {
      currentList.clear();
      currentList.add('None');
    } else {
      currentList.remove('None');
      if (currentList.contains(event.medication)) {
        currentList.remove(event.medication);
      } else {
        currentList.add(event.medication);
      }
    }
    emit(state.copyWith(currentMedications: currentList, status: OnboardingStatus.inProgress));
  }

  void _onLifestyleUpdated(
    LifestyleUpdated event,
    Emitter<OnboardingState> emit,
  ) {
    emit(state.copyWith(
      exerciseFrequency: event.exerciseFrequency ?? state.exerciseFrequency,
      typicalSleepHours: event.sleepHours ?? state.typicalSleepHours,
      alcoholIntake: event.alcoholIntake ?? state.alcoholIntake,
      smokingStatus: event.smokingStatus ?? state.smokingStatus,
      status: OnboardingStatus.inProgress,
    ));
  }

  void _onEmergencyContactUpdated(
    EmergencyContactUpdated event,
    Emitter<OnboardingState> emit,
  ) {
    emit(state.copyWith(
      emergencyContactName: event.name,
      emergencyContactPhone: event.phone,
      emergencyContactRelationship: event.relationship,
      status: OnboardingStatus.inProgress,
    ));
  }

  Future<void> _onOnboardingSubmitted(
    OnboardingSubmitted event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(state.copyWith(status: OnboardingStatus.submitting));

    // Get current user or create fallback profile
    final currentUserResult = await _authRepository.getCurrentUser();
    final UserProfile user = currentUserResult.getOrElse(() => null) ??
        UserProfile(
          id: 'usr_${DateTime.now().millisecondsSinceEpoch}',
          email: 'member@malevitality.com',
          firstName: 'Vitality',
          lastName: 'Member',
          dateOfBirth: state.dateOfBirth,
          lifeStage: state.calculatedLifeStage,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

    // Update with collected clinical intake
    final updatedProfile = user.copyWith(
      dateOfBirth: state.dateOfBirth,
      lifeStage: state.calculatedLifeStage,
      heightCm: user.heightCm ?? 178.0,
      weightKg: user.weightKg ?? 80.0,
      bloodType: user.bloodType ?? 'O+',
      isCaregiverEnabled: state.emergencyContactName.isNotEmpty,
      healthConditions: state.healthConditions,
      currentMedications: state.currentMedications,
      exerciseFrequency: state.exerciseFrequency,
      typicalSleepHours: state.typicalSleepHours,
      alcoholIntake: state.alcoholIntake,
      smokingStatus: state.smokingStatus,
      emergencyContactName: state.emergencyContactName,
      emergencyContactPhone: state.emergencyContactPhone,
      emergencyContactRelationship: state.emergencyContactRelationship,
      isOnboardingCompleted: true,
      updatedAt: DateTime.now(),
    );

    final saveResult = await _authRepository.completeOnboarding(updatedProfile);

    saveResult.fold(
      (failure) => emit(state.copyWith(
        status: OnboardingStatus.failure,
        errorMessage: failure.message,
      )),
      (completed) => emit(state.copyWith(
        status: OnboardingStatus.success,
        completedProfile: completed,
      )),
    );
  }
}
