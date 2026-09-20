import 'package:flutter/material.dart';

/// MaleVitality Design System - Spacing & Radius Tokens
///
/// Implements an 8-point spatial grid system optimized for clinical readability,
/// responsive card densities, and touch-target accessibility.
abstract class AppSpacing {
  // ==========================================
  // Primitive Spacing Scale (Pixels)
  // ==========================================
  static const double none = 0.0;
  static const double xxs = 2.0;
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double xxxl = 64.0;

  // ==========================================
  // Insets (EdgeInsets)
  // ==========================================
  static const EdgeInsets insetZero = EdgeInsets.zero;

  // All sides
  static const EdgeInsets insetAllXs = EdgeInsets.all(xs);
  static const EdgeInsets insetAllSm = EdgeInsets.all(sm);
  static const EdgeInsets insetAllMd = EdgeInsets.all(md);
  static const EdgeInsets insetAllLg = EdgeInsets.all(lg);
  static const EdgeInsets insetAllXl = EdgeInsets.all(xl);

  // Horizontal
  static const EdgeInsets insetHorizontalXs = EdgeInsets.symmetric(horizontal: xs);
  static const EdgeInsets insetHorizontalSm = EdgeInsets.symmetric(horizontal: sm);
  static const EdgeInsets insetHorizontalMd = EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets insetHorizontalLg = EdgeInsets.symmetric(horizontal: lg);
  static const EdgeInsets insetHorizontalXl = EdgeInsets.symmetric(horizontal: xl);

  // Vertical
  static const EdgeInsets insetVerticalXs = EdgeInsets.symmetric(vertical: xs);
  static const EdgeInsets insetVerticalSm = EdgeInsets.symmetric(vertical: sm);
  static const EdgeInsets insetVerticalMd = EdgeInsets.symmetric(vertical: md);
  static const EdgeInsets insetVerticalLg = EdgeInsets.symmetric(vertical: lg);
  static const EdgeInsets insetVerticalXl = EdgeInsets.symmetric(vertical: xl);

  // Standard Screen Padding
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: md,
    vertical: lg,
  );

  // Card Insets
  static const EdgeInsets cardPadding = EdgeInsets.all(md);
  static const EdgeInsets cardPaddingDense = EdgeInsets.all(sm);
  static const EdgeInsets cardPaddingRelaxed = EdgeInsets.all(lg);

  // ==========================================
  // Layout Gaps (SizedBox)
  // ==========================================
  static const SizedBox gapEmpty = SizedBox.shrink();

  // Vertical Gaps
  static const SizedBox verticalXs = SizedBox(height: xs);
  static const SizedBox verticalSm = SizedBox(height: sm);
  static const SizedBox verticalMd = SizedBox(height: md);
  static const SizedBox verticalLg = SizedBox(height: lg);
  static const SizedBox verticalXl = SizedBox(height: xl);
  static const SizedBox verticalXxl = SizedBox(height: xxl);

  // Horizontal Gaps
  static const SizedBox horizontalXs = SizedBox(width: xs);
  static const SizedBox horizontalSm = SizedBox(width: sm);
  static const SizedBox horizontalMd = SizedBox(width: md);
  static const SizedBox horizontalLg = SizedBox(width: lg);
  static const SizedBox horizontalXl = SizedBox(width: xl);

  // ==========================================
  // Border Radius Scale
  // ==========================================
  static const double radiusXs = 4.0;
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;
  static const double radiusFull = 999.0;

  // BorderRadius Geometry
  static const BorderRadius roundedXs = BorderRadius.all(Radius.circular(radiusXs));
  static const BorderRadius roundedSm = BorderRadius.all(Radius.circular(radiusSm));
  static const BorderRadius roundedMd = BorderRadius.all(Radius.circular(radiusMd));
  static const BorderRadius roundedLg = BorderRadius.all(Radius.circular(radiusLg));
  static const BorderRadius roundedXl = BorderRadius.all(Radius.circular(radiusXl));
  static const BorderRadius roundedFull = BorderRadius.all(Radius.circular(radiusFull));
}
