import 'package:flutter/material.dart';
import '../../../../common/colors/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/dashboard_data.dart';

/// Upcoming Clinical Screenings & Diagnostic Orders Section
class UpcomingScreeningsSection extends StatelessWidget {
  final List<DashboardScreeningItem> screenings;
  final ValueChanged<DashboardScreeningItem>? onScheduleTap;

  const UpcomingScreeningsSection({
    super.key,
    required this.screenings,
    this.onScheduleTap,
  });

  @override
  Widget build(BuildContext context) {
    if (screenings.isEmpty) return const SizedBox.shrink();

    // Show primary next upcoming screening in a subtle, quiet card
    final primaryScreening = screenings.first;

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
              'Upcoming Screenings',
              style: AppTextStyles.titleLarge.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
                fontSize: 18.0,
                letterSpacing: -0.2,
              ),
            ),
            Text(
              'Next Preventive Milestone',
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.slate400,
                fontWeight: FontWeight.w600,
                fontSize: 11.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),

        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: AppColors.slate200,
              width: 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.03),
                blurRadius: 12.0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 36.0,
                    height: 36.0,
                    decoration: BoxDecoration(
                      color: AppColors.secondary100,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Icon(
                      Icons.biotech_outlined,
                      size: 20.0,
                      color: AppColors.secondary,
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                primaryScreening.category.toUpperCase(),
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: AppColors.secondary700,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10.0,
                                  letterSpacing: 0.5,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              'In ${primaryScreening.daysRemaining} days',
                              style: AppTextStyles.labelSmall.copyWith(
                                color: primaryScreening.daysRemaining <= 14
                                    ? AppColors.warningDark
                                    : AppColors.slate500,
                                fontWeight: FontWeight.w600,
                                fontSize: 11.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          primaryScreening.title,
                          style: AppTextStyles.titleMedium.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                            fontSize: 15.0,
                          ),
                        ),
                        const SizedBox(height: 3.0),
                        Text(
                          primaryScreening.providerOrLab,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.slate500,
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14.0),
              SizedBox(
                width: double.infinity,
                height: 38.0,
                child: OutlinedButton.icon(
                  onPressed: onScheduleTap != null
                      ? () => onScheduleTap!(primaryScreening)
                      : null,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.slate300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  ),
                  icon: const Icon(Icons.event_available_rounded, size: 16.0, color: AppColors.primary),
                  label: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Schedule Lab Appointment',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 12.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
