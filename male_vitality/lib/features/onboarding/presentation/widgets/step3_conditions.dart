import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/colors/app_colors.dart';
import '../../../../common/widgets/cards/app_card.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_event.dart';
import '../bloc/onboarding_state.dart';

class _ConditionOption {
  final String title;
  final String description;
  final IconData icon;

  const _ConditionOption({
    required this.title,
    required this.description,
    required this.icon,
  });
}

/// Step 3: Existing Health Conditions & Risk Stratification
class Step3Conditions extends StatelessWidget {
  const Step3Conditions({super.key});

  static const List<_ConditionOption> _options = [
    _ConditionOption(
      title: 'Low Energy & Fatigue',
      description: 'Potential androgen or cortisol imbalance',
      icon: Icons.battery_alert_rounded,
    ),
    _ConditionOption(
      title: 'High Blood Pressure',
      description: 'Systolic >120 mmHg or diastolic >80 mmHg',
      icon: Icons.speed_rounded,
    ),
    _ConditionOption(
      title: 'Elevated Cholesterol',
      description: 'Elevated ApoB, LDL, or low HDL',
      icon: Icons.bloodtype_rounded,
    ),
    _ConditionOption(
      title: 'Pre-diabetes / Glucose Concerns',
      description: 'Fasting glucose >100 mg/dL or elevated HbA1c',
      icon: Icons.monitor_heart_rounded,
    ),
    _ConditionOption(
      title: 'Sleep Apnea & Insomnia',
      description: 'Fragmented deep sleep or chronic snoring',
      icon: Icons.bedtime_rounded,
    ),
    _ConditionOption(
      title: 'Joint & Musculoskeletal Pain',
      description: 'Stiffness, tendonitis, or reduced mobility',
      icon: Icons.accessibility_new_rounded,
    ),
    _ConditionOption(
      title: 'High Stress & Mental Fog',
      description: 'Prolonged work stress, focus issues, or anxiety',
      icon: Icons.psychology_rounded,
    ),
    _ConditionOption(
      title: 'None',
      description: 'No chronic conditions, seeking peak vitality',
      icon: Icons.check_circle_outline_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Current Health Conditions',
                style: AppTextStyles.displaySmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              AppSpacing.verticalSm,
              Text(
                'Select any areas you would like your clinical wellness protocols to prioritize.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.slate600,
                ),
              ),
              AppSpacing.verticalLg,

              // Conditions list
              ..._options.map((option) {
                final isSelected = state.healthConditions.contains(option.title);

                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: AppCard(
                    padding: AppSpacing.cardPaddingDense,
                    borderColor: isSelected ? AppColors.secondary : AppColors.border,
                    backgroundColor: isSelected ? AppColors.secondary50 : Colors.white,
                    onTap: () {
                      context.read<OnboardingBloc>().add(HealthConditionToggled(option.title));
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.secondary.withValues(alpha: 0.15)
                                : AppColors.slate100,
                            borderRadius: AppSpacing.roundedSm,
                          ),
                          child: Icon(
                            option.icon,
                            color: isSelected ? AppColors.secondary : AppColors.slate600,
                            size: 20.0,
                          ),
                        ),
                        AppSpacing.horizontalMd,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                option.title,
                                style: AppTextStyles.titleSmall.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: isSelected ? AppColors.secondary800 : AppColors.textPrimary,
                                ),
                              ),
                              AppSpacing.verticalXs,
                              Text(
                                option.description,
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.slate500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          isSelected
                              ? Icons.check_circle_rounded
                              : Icons.radio_button_unchecked_rounded,
                          color: isSelected ? AppColors.secondary : AppColors.slate300,
                          size: 22.0,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
