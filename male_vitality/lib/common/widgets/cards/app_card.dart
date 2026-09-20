import 'package:flutter/material.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../colors/app_colors.dart';

/// Clinical Surface & Metric Card for MaleVitality
class AppCard extends StatelessWidget {
  final Widget child;
  final String? title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? statusIndicatorColor;

  const AppCard({
    super.key,
    required this.child,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.padding = AppSpacing.cardPadding,
    this.backgroundColor,
    this.borderColor,
    this.statusIndicatorColor,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultBg = isDark ? AppColors.cardDark : AppColors.card;
    final defaultBorder = isDark ? AppColors.borderDark : AppColors.border;

    Widget cardBody = Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null || leading != null || trailing != null) ...[
            Row(
              children: [
                if (leading != null) ...[
                  leading!,
                  AppSpacing.horizontalSm,
                ],
                if (title != null)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title!,
                          style: AppTextStyles.titleMedium.copyWith(
                            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                          ),
                        ),
                        if (subtitle != null) ...[
                          AppSpacing.verticalXs,
                          Text(
                            subtitle!,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: isDark ? AppColors.textTertiaryDark : AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                if (trailing != null) trailing!,
              ],
            ),
            AppSpacing.verticalMd,
          ],
          child,
        ],
      ),
    );

    // If status indicator is provided, show a subtle accent bar on the left
    if (statusIndicatorColor != null) {
      cardBody = IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 4.0,
              decoration: BoxDecoration(
                color: statusIndicatorColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppSpacing.radiusLg),
                  bottomLeft: Radius.circular(AppSpacing.radiusLg),
                ),
              ),
            ),
            Expanded(child: cardBody),
          ],
        ),
      );
    }

    return Material(
      color: backgroundColor ?? defaultBg,
      shape: RoundedRectangleBorder(
        borderRadius: AppSpacing.roundedLg,
        side: BorderSide(color: borderColor ?? defaultBorder, width: 1.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: cardBody,
      ),
    );
  }
}
