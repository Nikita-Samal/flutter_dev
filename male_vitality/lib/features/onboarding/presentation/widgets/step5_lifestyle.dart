import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/colors/app_colors.dart';
import '../../../../common/widgets/cards/app_card.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_event.dart';
import '../bloc/onboarding_state.dart';

/// Step 5: Lifestyle Biomarkers & Behavioral Baseline
class Step5Lifestyle extends StatelessWidget {
  const Step5Lifestyle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Daily Lifestyle Habits',
                style: AppTextStyles.displaySmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              AppSpacing.verticalSm,
              Text(
                'Cardiovascular activity, restorative sleep, and recovery factors determine androgen balance and longevity.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.slate600,
                ),
              ),
              AppSpacing.verticalXl,

              // 1. Exercise Frequency
              Text(
                'Weekly Resistance & Cardio Training',
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              AppSpacing.verticalSm,
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  'Sedentary',
                  '1-2 days/week',
                  '3-4 days/week',
                  '5+ days/week',
                ].map((freq) {
                  final isSelected = state.exerciseFrequency == freq;
                  return _buildChoiceChip(
                    label: freq,
                    isSelected: isSelected,
                    onTap: () {
                      context.read<OnboardingBloc>().add(
                            LifestyleUpdated(exerciseFrequency: freq),
                          );
                    },
                  );
                }).toList(),
              ),
              AppSpacing.verticalLg,

              // 2. Typical Sleep Duration
              Text(
                'Typical Nightly Sleep: ${state.typicalSleepHours.toStringAsFixed(1)} hrs',
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              AppSpacing.verticalXs,
              Text(
                'Testosterone synthesis occurs primarily during uninterrupted deep REM cycles.',
                style: AppTextStyles.bodySmall.copyWith(color: AppColors.slate500),
              ),
              AppSpacing.verticalSm,
              AppCard(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: AppColors.secondary,
                    inactiveTrackColor: AppColors.slate200,
                    thumbColor: AppColors.primary,
                    overlayColor: AppColors.primary.withValues(alpha: 0.12),
                  ),
                  child: Slider(
                    value: state.typicalSleepHours,
                    min: 4.0,
                    max: 10.0,
                    divisions: 12,
                    label: '${state.typicalSleepHours.toStringAsFixed(1)}h',
                    onChanged: (val) {
                      context.read<OnboardingBloc>().add(
                            LifestyleUpdated(sleepHours: val),
                          );
                    },
                  ),
                ),
              ),
              AppSpacing.verticalLg,

              // 3. Alcohol Intake
              Text(
                'Alcohol Consumption',
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              AppSpacing.verticalSm,
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  'None / Rare',
                  '1-2 drinks/week',
                  '3-6 drinks/week',
                  '7+ drinks/week',
                ].map((alc) {
                  final isSelected = state.alcoholIntake == alc;
                  return _buildChoiceChip(
                    label: alc,
                    isSelected: isSelected,
                    onTap: () {
                      context.read<OnboardingBloc>().add(
                            LifestyleUpdated(alcoholIntake: alc),
                          );
                    },
                  );
                }).toList(),
              ),
              AppSpacing.verticalLg,

              // 4. Tobacco / Nicotine
              Text(
                'Tobacco & Nicotine Usage',
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              AppSpacing.verticalSm,
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  'Non-smoker',
                  'Occasional Nicotine',
                  'Daily Smoker / Vaper',
                ].map((tob) {
                  final isSelected = state.smokingStatus == tob;
                  return _buildChoiceChip(
                    label: tob,
                    isSelected: isSelected,
                    onTap: () {
                      context.read<OnboardingBloc>().add(
                            LifestyleUpdated(smokingStatus: tob),
                          );
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildChoiceChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppSpacing.roundedFull,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 10.0),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: AppSpacing.roundedFull,
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: 1.2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.18),
                    blurRadius: 8.0,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: AppTextStyles.labelMedium.copyWith(
            color: isSelected ? Colors.white : AppColors.slate700,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
