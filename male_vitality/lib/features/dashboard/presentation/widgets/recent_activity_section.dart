import 'package:flutter/material.dart';
import '../../../../common/colors/app_colors.dart';
import '../../../../common/widgets/cards/app_card.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/date_utils.dart';
import '../../domain/entities/dashboard_data.dart';

/// Recent Activity & Biomarker Trends Timeline Preview
class RecentActivitySection extends StatelessWidget {
  final List<RecentActivityItem> activities;

  const RecentActivitySection({
    super.key,
    required this.activities,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Activity & Trends',
              style: AppTextStyles.headlineSmall.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              'Last 24 Hours',
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.slate500,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        AppSpacing.verticalSm,

        AppCard(
          padding: AppSpacing.cardPadding,
          child: Column(
            children: activities.asMap().entries.map((entry) {
              final index = entry.key;
              final activity = entry.value;
              final isLast = index == activities.length - 1;
              final relativeTime = AppDateUtils.formatRelative(activity.timestamp);

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 38.0,
                          height: 38.0,
                          decoration: BoxDecoration(
                            color: _getActivityColor(activity.category).withValues(alpha: 0.12),
                            borderRadius: AppSpacing.roundedSm,
                          ),
                          child: Icon(
                            _getActivityIcon(activity.category),
                            color: _getActivityColor(activity.category),
                            size: 18.0,
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
                                  Text(
                                    activity.title,
                                    style: AppTextStyles.titleSmall.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  Text(
                                    relativeTime,
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: AppColors.slate400,
                                      fontSize: 11.0,
                                    ),
                                  ),
                                ],
                              ),
                              AppSpacing.verticalXs,
                              Text(
                                activity.subtitle,
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.slate600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!isLast)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
                      child: Divider(
                        color: AppColors.slate100,
                        thickness: 1.0,
                        height: 1.0,
                      ),
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Color _getActivityColor(String category) {
    switch (category) {
      case 'workout':
        return AppColors.fitness;
      case 'sleep':
        return AppColors.sleep;
      case 'medication':
        return AppColors.endocrine;
      case 'cardio':
        return AppColors.cardiovascular;
      default:
        return AppColors.secondary;
    }
  }

  IconData _getActivityIcon(String category) {
    switch (category) {
      case 'workout':
        return Icons.fitness_center_rounded;
      case 'sleep':
        return Icons.bedtime_rounded;
      case 'medication':
        return Icons.medication_rounded;
      case 'cardio':
        return Icons.monitor_heart_rounded;
      default:
        return Icons.check_circle_outline_rounded;
    }
  }
}
