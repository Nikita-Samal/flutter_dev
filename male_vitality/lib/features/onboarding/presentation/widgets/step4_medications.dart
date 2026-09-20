import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/colors/app_colors.dart';
import '../../../../common/widgets/cards/app_card.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_event.dart';
import '../bloc/onboarding_state.dart';

class _MedicationItem {
  final String name;
  final String category;
  final IconData icon;

  const _MedicationItem({
    required this.name,
    required this.category,
    required this.icon,
  });
}

/// Step 4: Active Medications & Supplements
class Step4Medications extends StatelessWidget {
  const Step4Medications({super.key});

  static const List<_MedicationItem> _items = [
    _MedicationItem(
      name: 'Testosterone Replacement (TRT)',
      category: 'Hormone Optimization',
      icon: Icons.medication_liquid_rounded,
    ),
    _MedicationItem(
      name: 'Enclomiphene / HCG',
      category: 'Fertility & Endocrine',
      icon: Icons.science_rounded,
    ),
    _MedicationItem(
      name: 'Blood Pressure Rx',
      category: 'Cardiovascular',
      icon: Icons.favorite_rounded,
    ),
    _MedicationItem(
      name: 'Statins (Lipid Management)',
      category: 'Cardiovascular / Metabolic',
      icon: Icons.monitor_heart_rounded,
    ),
    _MedicationItem(
      name: 'Tadalafil / Sildenafil',
      category: 'Andrology / Sexual Health',
      icon: Icons.healing_rounded,
    ),
    _MedicationItem(
      name: 'Vitamin D3 + K2',
      category: 'Longevity Supplement',
      icon: Icons.wb_sunny_rounded,
    ),
    _MedicationItem(
      name: 'Omega-3 Fish Oil (EPA/DHA)',
      category: 'Lipid & Brain Health',
      icon: Icons.water_drop_rounded,
    ),
    _MedicationItem(
      name: 'Creatine Monohydrate',
      category: 'Muscle & Cognitive Health',
      icon: Icons.fitness_center_rounded,
    ),
    _MedicationItem(
      name: 'None',
      category: 'No active medications or supplements',
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
                'Current Medications & Supplements',
                style: AppTextStyles.displaySmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              AppSpacing.verticalSm,
              Text(
                'Accurate medication tracking ensures contraindication safety with upcoming lab screenings and telehealth appointments.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.slate600,
                ),
              ),
              AppSpacing.verticalLg,

              // Meds list
              ..._items.map((item) {
                final isSelected = state.currentMedications.contains(item.name);

                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: AppCard(
                    padding: AppSpacing.cardPaddingDense,
                    borderColor: isSelected ? AppColors.secondary : AppColors.border,
                    backgroundColor: isSelected ? AppColors.secondary50 : Colors.white,
                    onTap: () {
                      context.read<OnboardingBloc>().add(MedicationToggled(item.name));
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
                            item.icon,
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
                                item.name,
                                style: AppTextStyles.titleSmall.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: isSelected ? AppColors.secondary800 : AppColors.textPrimary,
                                ),
                              ),
                              AppSpacing.verticalXs,
                              Text(
                                item.category,
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
