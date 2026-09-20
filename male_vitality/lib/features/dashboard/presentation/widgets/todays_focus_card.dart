import 'package:flutter/material.dart';
import '../../../../common/colors/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/dashboard_data.dart';

/// The Priority Daily Clinical Focus Protocol
class TodaysFocusCard extends StatelessWidget {
  final TodaysFocus focus;
  final ValueChanged<bool> onToggleCompleted;

  const TodaysFocusCard({
    super.key,
    required this.focus,
    required this.onToggleCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: focus.isCompleted
              ? AppColors.success.withValues(alpha: 0.35)
              : AppColors.slate200,
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.04),
            blurRadius: 18.0,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row: Category Badge & Duration
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: focus.isCompleted ? AppColors.successLight : AppColors.secondary100,
                    borderRadius: AppSpacing.roundedFull,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        focus.isCompleted
                            ? Icons.check_circle_rounded
                            : Icons.bolt_rounded,
                        size: 13.0,
                        color: focus.isCompleted ? AppColors.successDark : AppColors.secondary,
                      ),
                      const SizedBox(width: 5.0),
                      Flexible(
                        child: Text(
                          focus.category.toUpperCase(),
                          style: AppTextStyles.labelSmall.copyWith(
                            color: focus.isCompleted ? AppColors.successDark : AppColors.secondary800,
                            fontWeight: FontWeight.w700,
                            fontSize: 10.0,
                            letterSpacing: 0.6,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.schedule_rounded,
                    size: 13.0,
                    color: AppColors.slate400,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    focus.durationMinutes,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.slate500,
                      fontWeight: FontWeight.w600,
                      fontSize: 11.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14.0),

          // Protocol Title
          Text(
            focus.title,
            style: AppTextStyles.titleLarge.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
              fontSize: 17.5,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 6.0),

          // Clinical Rationale
          Text(
            focus.description,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.slate600,
              fontSize: 13.5,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 18.0),

          // Tactile Action Button
          SizedBox(
            width: double.infinity,
            height: 44.0,
            child: Material(
              color: focus.isCompleted ? AppColors.successLight : AppColors.primary,
              borderRadius: BorderRadius.circular(12.0),
              child: InkWell(
                onTap: () => onToggleCompleted(!focus.isCompleted),
                borderRadius: BorderRadius.circular(12.0),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        focus.isCompleted ? Icons.check_rounded : Icons.check_circle_outline_rounded,
                        size: 17.0,
                        color: focus.isCompleted ? AppColors.successDark : Colors.white,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        focus.isCompleted ? 'Protocol Completed' : focus.actionLabel,
                        style: AppTextStyles.labelLarge.copyWith(
                          color: focus.isCompleted ? AppColors.successDark : Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 13.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
