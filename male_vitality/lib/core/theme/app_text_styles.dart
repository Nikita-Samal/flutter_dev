import 'package:flutter/material.dart';
import '../../common/colors/app_colors.dart';

/// MaleVitality Design System - Typography
///
/// Designed with high legibility for clinical vitals, lab diagnostics,
/// and accessible mobile wellness tracking.
abstract class AppTextStyles {
  // Font Family Definition
  static const String fontFamily = 'Inter';
  static const List<String> fontFallbacks = <String>[
    '-apple-system',
    'BlinkMacSystemFont',
    'Segoe UI',
    'Roboto',
    'Helvetica Neue',
    'sans-serif',
  ];

  // ==========================================
  // Display Styles (Large Numbers, Hero Stats)
  // ==========================================
  static const TextStyle displayLarge = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFallbacks,
    fontSize: 32.0,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.8,
    height: 1.25,
    color: AppColors.textPrimary,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFallbacks,
    fontSize: 28.0,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.6,
    height: 1.28,
    color: AppColors.textPrimary,
  );

  static const TextStyle displaySmall = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFallbacks,
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.4,
    height: 1.33,
    color: AppColors.textPrimary,
  );

  // ==========================================
  // Headline Styles (Section Headers)
  // ==========================================
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFallbacks,
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFallbacks,
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.1,
    height: 1.44,
    color: AppColors.textPrimary,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFallbacks,
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.0,
    height: 1.5,
    color: AppColors.textPrimary,
  );

  // ==========================================
  // Title Styles (Card Titles & List Headers)
  // ==========================================
  static const TextStyle titleLarge = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFallbacks,
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.0,
    height: 1.5,
    color: AppColors.textPrimary,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFallbacks,
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    height: 1.43,
    color: AppColors.textPrimary,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFallbacks,
    fontSize: 13.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.38,
    color: AppColors.textSecondary,
  );

  // ==========================================
  // Body Styles (Paragraphs & Descriptions)
  // ==========================================
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFallbacks,
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.2,
    height: 1.5,
    color: AppColors.textSecondary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFallbacks,
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
    height: 1.43,
    color: AppColors.textSecondary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFallbacks,
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.2,
    height: 1.33,
    color: AppColors.textTertiary,
  );

  // ==========================================
  // Label Styles (Buttons, Tags, Tabs)
  // ==========================================
  static const TextStyle labelLarge = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFallbacks,
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    height: 1.43,
    color: AppColors.textPrimary,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFallbacks,
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
    height: 1.33,
    color: AppColors.textSecondary,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFallbacks,
    fontSize: 11.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.3,
    height: 1.27,
    color: AppColors.textTertiary,
  );

  // ==========================================
  // Clinical Metric Specific Styles
  // ==========================================
  static const TextStyle metricHero = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFallbacks,
    fontSize: 40.0,
    fontWeight: FontWeight.w700,
    letterSpacing: -1.0,
    height: 1.1,
    color: AppColors.primary,
  );

  static const TextStyle metricValue = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFallbacks,
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 1.2,
    color: AppColors.textPrimary,
  );

  static const TextStyle metricUnit = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFallbacks,
    fontSize: 13.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    color: AppColors.textTertiary,
  );

  // ==========================================
  // Material TextTheme Builders
  // ==========================================
  static TextTheme createTextTheme({bool isDark = false}) {
    final Color primaryText = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final Color secondaryText = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
    final Color tertiaryText = isDark ? AppColors.textTertiaryDark : AppColors.textTertiary;

    return TextTheme(
      displayLarge: displayLarge.copyWith(color: primaryText),
      displayMedium: displayMedium.copyWith(color: primaryText),
      displaySmall: displaySmall.copyWith(color: primaryText),
      headlineLarge: headlineLarge.copyWith(color: primaryText),
      headlineMedium: headlineMedium.copyWith(color: primaryText),
      headlineSmall: headlineSmall.copyWith(color: primaryText),
      titleLarge: titleLarge.copyWith(color: primaryText),
      titleMedium: titleMedium.copyWith(color: primaryText),
      titleSmall: titleSmall.copyWith(color: secondaryText),
      bodyLarge: bodyLarge.copyWith(color: secondaryText),
      bodyMedium: bodyMedium.copyWith(color: secondaryText),
      bodySmall: bodySmall.copyWith(color: tertiaryText),
      labelLarge: labelLarge.copyWith(color: primaryText),
      labelMedium: labelMedium.copyWith(color: secondaryText),
      labelSmall: labelSmall.copyWith(color: tertiaryText),
    );
  }
}
