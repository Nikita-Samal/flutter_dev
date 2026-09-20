import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../common/colors/app_colors.dart';
import '../../../../common/extensions/context_extensions.dart';
import '../../../../common/widgets/buttons/app_button.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_event.dart';
import '../bloc/onboarding_state.dart';
import '../widgets/step1_welcome.dart';
import '../widgets/step2_dob.dart';
import '../widgets/step3_conditions.dart';
import '../widgets/step4_medications.dart';
import '../widgets/step5_lifestyle.dart';
import '../widgets/step6_emergency_contact.dart';

/// Multi-Step Onboarding Wizard
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  void _showCompletionDialog(BuildContext context, OnboardingState state) {
    final stage = state.calculatedLifeStage;

    showModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.radiusXl)),
          ),
          child: SafeArea(
            top: false,
            child: SingleChildScrollView(
              padding: AppSpacing.screenPadding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
              Container(
                width: 68.0,
                height: 68.0,
                decoration: BoxDecoration(
                  color: AppColors.secondary50,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.secondary, width: 2.0),
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: AppColors.secondary,
                  size: 38.0,
                ),
              ),
              AppSpacing.verticalMd,
              Text(
                'Clinical Protocol Configured!',
                style: AppTextStyles.headlineLarge.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              AppSpacing.verticalXs,
              Text(
                'Your physiological baseline has been calibrated to your life stage.',
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.slate600),
                textAlign: TextAlign.center,
              ),
              AppSpacing.verticalLg,

              // Life Stage Badge Card
              Container(
                width: double.infinity,
                padding: AppSpacing.cardPadding,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: AppSpacing.roundedLg,
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                      decoration: const BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: AppSpacing.roundedFull,
                      ),
                      child: Text(
                        stage.label.toUpperCase(),
                        style: AppTextStyles.labelSmall.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                    AppSpacing.verticalSm,
                    Text(
                      'Target Focus (${stage.ageRange})',
                      style: AppTextStyles.titleMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    AppSpacing.verticalXs,
                    Text(
                      stage.clinicalFocus,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primary100,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              AppSpacing.verticalXl,

              // Action to Dashboard
              AppButton(
                text: 'Launch Vitality Dashboard',
                onPressed: () {
                  Navigator.of(bottomSheetContext).pop();
                  // Notify AuthBloc to refresh session
                  context.read<AuthBloc>().add(const AuthCheckRequested());
                  context.go(AppRoutes.home);
                },
              ),
              AppSpacing.verticalMd,
            ],
          ),
        ),
      ),
    );
  },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingBloc, OnboardingState>(
      listener: (context, state) {
        if (state.status == OnboardingStatus.success) {
          _showCompletionDialog(context, state);
        } else if (state.status == OnboardingStatus.failure && state.errorMessage != null) {
          context.showSnackBar(state.errorMessage!, isError: true);
        }
      },
      builder: (context, state) {
        final isSubmitting = state.status == OnboardingStatus.submitting;
        final isLastStep = state.currentStep == state.totalSteps;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0.0,
            leading: state.currentStep > 1
                ? IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20.0),
                    color: AppColors.primary,
                    onPressed: isSubmitting
                        ? null
                        : () => context.read<OnboardingBloc>().add(const PreviousStepPressed()),
                  )
                : null,
            title: Text(
              'Step ${state.currentStep} of ${state.totalSteps}',
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.slate500,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              if (state.currentStep == 6)
                TextButton(
                  onPressed: isSubmitting
                      ? null
                      : () => context.read<OnboardingBloc>().add(const OnboardingSubmitted()),
                  child: Text(
                    'Skip',
                    style: AppTextStyles.labelLarge.copyWith(
                      color: AppColors.slate500,
                    ),
                  ),
                ),
              AppSpacing.horizontalSm,
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(4.0),
              child: LinearProgressIndicator(
                value: state.progressPercentage,
                backgroundColor: AppColors.slate200,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.secondary),
                minHeight: 4.0,
              ),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: AppSpacing.screenPadding,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      switchInCurve: Curves.easeOut,
                      switchOutCurve: Curves.easeIn,
                      child: _buildCurrentStep(state.currentStep),
                    ),
                  ),
                ),

                // Bottom Action Bar
                Container(
                  padding: AppSpacing.insetAllMd,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(top: BorderSide(color: AppColors.border, width: 1.0)),
                  ),
                  child: SafeArea(
                    top: false,
                    child: AppButton(
                      text: isLastStep ? 'Complete Health Profile' : 'Continue',
                      isLoading: isSubmitting,
                      onPressed: isSubmitting
                          ? null
                          : () {
                              context.read<OnboardingBloc>().add(const NextStepPressed());
                            },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCurrentStep(int step) {
    switch (step) {
      case 1:
        return const Step1Welcome(key: ValueKey(1));
      case 2:
        return const Step2DateOfBirth(key: ValueKey(2));
      case 3:
        return const Step3Conditions(key: ValueKey(3));
      case 4:
        return const Step4Medications(key: ValueKey(4));
      case 5:
        return const Step5Lifestyle(key: ValueKey(5));
      case 6:
        return const Step6EmergencyContact(key: ValueKey(6));
      default:
        return const Step1Welcome(key: ValueKey(1));
    }
  }
}
