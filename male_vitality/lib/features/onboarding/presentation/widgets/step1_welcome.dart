import 'package:flutter/material.dart';
import '../../../../common/colors/app_colors.dart';
import '../../../../common/widgets/cards/app_card.dart';
import '../../../../core/constants/life_stage_constants.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Step 1: Welcome & Clinical Life Stage Overview
class Step1Welcome extends StatelessWidget {
  const Step1Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
            decoration: const BoxDecoration(
              color: AppColors.primary100,
              borderRadius: AppSpacing.roundedFull,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.auto_awesome, size: 14.0, color: AppColors.primary),
                AppSpacing.horizontalXs,
                Text(
                  'PRECISION HEALTH PROTOCOL',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          AppSpacing.verticalMd,

          Text(
            'Age-Optimized Care for Every Decade of Life',
            style: AppTextStyles.displaySmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
          AppSpacing.verticalSm,
          Text(
            'Men\'s hormonal, cardiovascular, and metabolic baselines evolve across your lifespan. MaleVitality calibrates every biomarker target specifically to your clinical life stage.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.slate600,
              height: 1.5,
            ),
          ),
          AppSpacing.verticalLg,

          Text(
            'The 6 Men\'s Health Life Stages',
            style: AppTextStyles.titleMedium.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          AppSpacing.verticalSm,

          // List of the 6 stages
          ...LifeStage.values.map((stage) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: AppCard(
                padding: AppSpacing.cardPaddingDense,
                child: Row(
                  children: [
                    Container(
                      width: 44.0,
                      height: 44.0,
                      decoration: BoxDecoration(
                        color: _getStageColor(stage).withValues(alpha: 0.12),
                        borderRadius: AppSpacing.roundedMd,
                      ),
                      child: Center(
                        child: Icon(
                          _getStageIcon(stage),
                          color: _getStageColor(stage),
                          size: 22.0,
                        ),
                      ),
                    ),
                    AppSpacing.horizontalMd,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  stage.label,
                                  style: AppTextStyles.titleSmall.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6.0,
                                  vertical: 2.0,
                                ),
                                decoration: const BoxDecoration(
                                  color: AppColors.slate100,
                                  borderRadius: AppSpacing.roundedXs,
                                ),
                                child: Text(
                                  stage.ageRange,
                                  style: AppTextStyles.labelSmall.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.slate700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          AppSpacing.verticalXs,
                          Text(
                            stage.clinicalFocus,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.slate500,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Color _getStageColor(LifeStage stage) {
    switch (stage) {
      case LifeStage.adolescence:
        return AppColors.fitness;
      case LifeStage.youngAdult:
        return AppColors.secondary;
      case LifeStage.primeVitality:
        return AppColors.primary;
      case LifeStage.midlife:
        return AppColors.endocrine;
      case LifeStage.mature:
        return AppColors.mentalWellness;
      case LifeStage.senior:
        return AppColors.cardiovascular;
    }
  }

  IconData _getStageIcon(LifeStage stage) {
    switch (stage) {
      case LifeStage.adolescence:
        return Icons.sports_gymnastics_rounded;
      case LifeStage.youngAdult:
        return Icons.bolt_rounded;
      case LifeStage.primeVitality:
        return Icons.fitness_center_rounded;
      case LifeStage.midlife:
        return Icons.monitor_heart_rounded;
      case LifeStage.mature:
        return Icons.health_and_safety_rounded;
      case LifeStage.senior:
        return Icons.elderly_rounded;
    }
  }
}
