import 'package:flutter/material.dart';
import '../../../../common/colors/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/dashboard_data.dart';

/// Quick Vitals Grid Section
class QuickVitalsSection extends StatelessWidget {
  final List<VitalMetricItem> vitals;
  final ValueChanged<VitalMetricItem>? onVitalTap;

  const QuickVitalsSection({
    super.key,
    required this.vitals,
    this.onVitalTap,
  });

  @override
  Widget build(BuildContext context) {
    // Focused strictly on 3–4 key metrics maximum
    final displayVitals = vitals.take(4).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8.0,
          runSpacing: 4.0,
          children: [
            Text(
              'Quick Vitals & Biomarkers',
              style: AppTextStyles.titleLarge.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
                fontSize: 18.0,
                letterSpacing: -0.2,
              ),
            ),
            Text(
              '4 Key Indicators',
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.slate400,
                fontWeight: FontWeight.w600,
                fontSize: 11.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),

        // 2-Column Responsive Clean Grid (single-column fallback on narrow viewports)
        LayoutBuilder(
          builder: (context, constraints) {
            final cardWidth = constraints.maxWidth >= 320.0
                ? (constraints.maxWidth - 12.0) / 2
                : constraints.maxWidth;

            return Wrap(
              spacing: 12.0,
              runSpacing: 12.0,
              children: displayVitals.map((vital) {
                return SizedBox(
                  width: cardWidth,
                  child: _buildVitalCard(vital),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildVitalCard(VitalMetricItem item) {
    final Color domainColor = _getDomainColor(item.category);
    final IconData icon = _getDomainIcon(item.category, item.keyName);

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      child: InkWell(
        onTap: onVitalTap != null ? () => onVitalTap!(item) : null,
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: AppColors.slate200,
              width: 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.035),
                blurRadius: 12.0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top row: Domain Icon & Status Pill
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 28.0,
                    height: 28.0,
                    decoration: BoxDecoration(
                      color: domainColor.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, size: 15.0, color: domainColor),
                  ),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: item.isOptimal
                            ? AppColors.successLight
                            : AppColors.warningLight,
                        borderRadius: AppSpacing.roundedXs,
                      ),
                      child: Text(
                        item.statusLabel,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: item.isOptimal
                              ? AppColors.successDark
                              : AppColors.warningDark,
                          fontWeight: FontWeight.w700,
                          fontSize: 9.5,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),

              // Metric Label
              Text(
                item.label,
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.slate500,
                  fontSize: 12.0,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2.0),

              // Main Value & Unit
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        item.value,
                        style: AppTextStyles.titleLarge.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                          fontSize: 19.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4.0),
                  Flexible(
                    child: Text(
                      item.unit,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.slate400,
                        fontSize: 11.0,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6.0),

              // Trend Indicator
              Text(
                item.trendText,
                style: AppTextStyles.labelSmall.copyWith(
                  color: item.isPositiveTrend
                      ? AppColors.secondary
                      : AppColors.slate500,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getDomainColor(String category) {
    switch (category) {
      case 'cardio':
        return AppColors.cardiovascular;
      case 'endocrine':
        return AppColors.endocrine;
      case 'sleep':
        return AppColors.sleep;
      case 'metabolic':
        return AppColors.nutrition;
      case 'fitness':
        return AppColors.fitness;
      default:
        return AppColors.primary;
    }
  }

  IconData _getDomainIcon(String category, String keyName) {
    if (keyName == 'blood_pressure') return Icons.favorite_border_rounded;
    if (keyName == 'total_testosterone') return Icons.biotech_rounded;
    if (keyName == 'resting_heart_rate') return Icons.monitor_heart_outlined;
    if (keyName == 'sleep_duration') return Icons.bedtime_outlined;
    if (keyName == 'body_weight') return Icons.scale_outlined;
    if (keyName == 'daily_steps') return Icons.directions_walk_rounded;
    return Icons.health_and_safety_outlined;
  }
}
