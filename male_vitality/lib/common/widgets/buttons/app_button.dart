import 'package:flutter/material.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../colors/app_colors.dart';

enum AppButtonVariant {
  primary,
  secondary,
  outline,
  ghost,
  danger,
}

enum AppButtonSize {
  small(height: 36.0, iconSize: 16.0),
  medium(height: 48.0, iconSize: 20.0),
  large(height: 56.0, iconSize: 24.0);

  final double height;
  final double iconSize;

  const AppButtonSize({required this.height, required this.iconSize});
}

/// Clinical & Action Button adhering to MaleVitality Design System
class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final bool isLoading;
  final bool isFullWidth;
  final Widget? leadingIcon;
  final Widget? trailingIcon;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isFullWidth = true,
    this.leadingIcon,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = onPressed != null && !isLoading;

    Color backgroundColor;
    Color foregroundColor;
    BorderSide? borderSide;

    switch (variant) {
      case AppButtonVariant.primary:
        backgroundColor = isEnabled ? AppColors.primary : AppColors.slate200;
        foregroundColor = isEnabled ? Colors.white : AppColors.slate400;
        break;
      case AppButtonVariant.secondary:
        backgroundColor = isEnabled ? AppColors.secondary : AppColors.slate200;
        foregroundColor = isEnabled ? Colors.white : AppColors.slate400;
        break;
      case AppButtonVariant.outline:
        backgroundColor = Colors.transparent;
        foregroundColor = isEnabled ? AppColors.primary : AppColors.slate400;
        borderSide = BorderSide(
          color: isEnabled ? AppColors.primary : AppColors.slate300,
          width: 1.5,
        );
        break;
      case AppButtonVariant.ghost:
        backgroundColor = Colors.transparent;
        foregroundColor = isEnabled ? AppColors.primary : AppColors.slate400;
        break;
      case AppButtonVariant.danger:
        backgroundColor = isEnabled ? AppColors.error : AppColors.slate200;
        foregroundColor = isEnabled ? Colors.white : AppColors.slate400;
        break;
    }

    final TextStyle textStyle = AppTextStyles.labelLarge.copyWith(
      color: foregroundColor,
      fontSize: size == AppButtonSize.small ? 13.0 : 15.0,
    );

    final Widget content = Row(
      mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) ...[
          SizedBox(
            width: size.iconSize,
            height: size.iconSize,
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
            ),
          ),
          AppSpacing.horizontalSm,
        ] else if (leadingIcon != null) ...[
          leadingIcon!,
          AppSpacing.horizontalSm,
        ],
        Flexible(
          child: Text(
            text,
            style: textStyle,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        if (!isLoading && trailingIcon != null) ...[
          AppSpacing.horizontalSm,
          trailingIcon!,
        ],
      ],
    );

    final Widget buttonWidget = Material(
      color: backgroundColor,
      borderRadius: AppSpacing.roundedMd,
      child: InkWell(
        onTap: isEnabled ? onPressed : null,
        borderRadius: AppSpacing.roundedMd,
        child: Container(
          height: size.height,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          decoration: BoxDecoration(
            borderRadius: AppSpacing.roundedMd,
            border: borderSide != null ? Border.fromBorderSide(borderSide) : null,
          ),
          child: content,
        ),
      ),
    );

    if (isFullWidth) {
      return SizedBox(
        width: double.infinity,
        child: buttonWidget,
      );
    }

    return buttonWidget;
  }
}
