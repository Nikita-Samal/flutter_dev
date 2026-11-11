import 'package:flutter/material.dart';

/// Morrow Brand Color Palette
/// Warm, premium, maternal-care-inspired palette.
class AppColors {
  AppColors._();

  // ─── Primary – Warm Cream ───────────────────────────────────────────────────
  static const Color background = Color(0xFFFDF6EE);
  static const Color surface = Color(0xFFFFFBF7);
  static const Color surfaceVariant = Color(0xFFF5EDE3);

  // ─── Accent – Soft Peach ───────────────────────────────────────────────────
  static const Color peach = Color(0xFFE8A598);
  static const Color peachLight = Color(0xFFF2C4BB);
  static const Color peachDark = Color(0xFFD4857A);

  // ─── Accent – Muted Rose ───────────────────────────────────────────────────
  static const Color rose = Color(0xFFCB8694);
  static const Color roseLight = Color(0xFFDFAAB5);
  static const Color roseDark = Color(0xFFB06575);

  // ─── Secondary – Sage Green ────────────────────────────────────────────────
  static const Color sage = Color(0xFF8FAF96);
  static const Color sageLight = Color(0xFFB3CABA);
  static const Color sageDark = Color(0xFF6A9074);

  // ─── Primary Brand (Peach-Rose gradient) ───────────────────────────────────
  static const Color primary = Color(0xFFD98C8C);
  static const Color primaryLight = Color(0xFFE8AEAE);
  static const Color primaryDark = Color(0xFFC07070);

  // ─── Text ──────────────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF3D2C2C);
  static const Color textSecondary = Color(0xFF8C6E6E);
  static const Color textHint = Color(0xFFB89898);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // ─── Border / Divider ──────────────────────────────────────────────────────
  static const Color border = Color(0xFFE8D5CF);
  static const Color divider = Color(0xFFF0E0DA);

  // ─── State ─────────────────────────────────────────────────────────────────
  static const Color error = Color(0xFFD35858);
  static const Color errorLight = Color(0xFFFDE8E8);
  static const Color success = Color(0xFF5A9E6E);
  static const Color successLight = Color(0xFFE6F4EB);
  static const Color warning = Color(0xFFD4873A);
  static const Color warningLight = Color(0xFFFDF0E0);

  // ─── Overlay / Shadow ──────────────────────────────────────────────────────
  static const Color shadowWarm = Color(0x1AD98C8C);
  static const Color shadowDeep = Color(0x26B06575);
  static const Color overlay = Color(0x80FDF6EE);

  // ─── Gradient stops ────────────────────────────────────────────────────────
  static const List<Color> primaryGradient = [
    Color(0xFFE8A598),
    Color(0xFFCB8694),
  ];

  static const List<Color> backgroundGradient = [
    Color(0xFFFDF6EE),
    Color(0xFFF8ECE5),
  ];

  static const List<Color> sageGradient = [
    Color(0xFF8FAF96),
    Color(0xFF6A9074),
  ];
}
