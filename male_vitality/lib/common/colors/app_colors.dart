import 'package:flutter/material.dart';

/// MaleVitality Design System - Color Tokens
///
/// Designed for a clinical, trustworthy, and modern men's health platform.
/// Combines authoritative Deep Navy Blue (#1A3A5C) with restorative Teal (#0D9488).
abstract class AppColors {
  // ==========================================
  // Primary Palette - Deep Navy Blue (#1A3A5C)
  // ==========================================
  static const Color primary = Color(0xFF1A3A5C);
  static const Color primary50 = Color(0xFFF0F5FA);
  static const Color primary100 = Color(0xFFDCE7F3);
  static const Color primary200 = Color(0xFFB9D0E7);
  static const Color primary300 = Color(0xFF8BB1D6);
  static const Color primary400 = Color(0xFF558DC0);
  static const Color primary500 = Color(0xFF3370AA);
  static const Color primary600 = Color(0xFF24578E);
  static const Color primary700 = Color(0xFF1A3A5C); // Core Brand Primary
  static const Color primary800 = Color(0xFF16314E);
  static const Color primary900 = Color(0xFF112338);

  // ==========================================
  // Secondary Palette - Restorative Teal (#0D9488)
  // ==========================================
  static const Color secondary = Color(0xFF0D9488);
  static const Color secondary50 = Color(0xFFF0FDFA);
  static const Color secondary100 = Color(0xFFCCFBF1);
  static const Color secondary200 = Color(0xFF99F6E4);
  static const Color secondary300 = Color(0xFF5EEAD4);
  static const Color secondary400 = Color(0xFF2DD4BF);
  static const Color secondary500 = Color(0xFF14B8A6);
  static const Color secondary600 = Color(0xFF0D9488); // Core Secondary
  static const Color secondary700 = Color(0xFF0F766E);
  static const Color secondary800 = Color(0xFF115E59);
  static const Color secondary900 = Color(0xFF134E4A);

  // ==========================================
  // Neutral / Slate Palette
  // ==========================================
  static const Color slate50 = Color(0xFFF8FAFC); // Main Background
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate200 = Color(0xFFE2E8F0); // Subtle Borders & Dividers
  static const Color slate300 = Color(0xFFCBD5E1);
  static const Color slate400 = Color(0xFF94A3B8); // Muted Icons / Placeholders
  static const Color slate500 = Color(0xFF64748B); // Secondary Body Text
  static const Color slate600 = Color(0xFF475569);
  static const Color slate700 = Color(0xFF334155); // Subheadings
  static const Color slate800 = Color(0xFF1E293B); // Dark Surface / High Contrast
  static const Color slate900 = Color(0xFF0F172A); // Primary Headings

  // ==========================================
  // Surfaces & Backgrounds
  // ==========================================
  static const Color background = Color(0xFFF8FAFC);
  static const Color backgroundLight = background;
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceLight = surface;
  static const Color card = Color(0xFFFFFFFF);
  static const Color cardLight = card;

  // Dark Mode Surfaces (for optional theme support)
  static const Color backgroundDark = Color(0xFF0B1320);
  static const Color surfaceDark = Color(0xFF111D2F);
  static const Color cardDark = Color(0xFF16253B);

  // ==========================================
  // Text Colors
  // ==========================================
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textPrimaryLight = textPrimary;
  static const Color textSecondary = Color(0xFF475569);
  static const Color textSecondaryLight = textSecondary;
  static const Color textTertiary = Color(0xFF94A3B8);
  static const Color textTertiaryLight = textTertiary;

  static const Color textPrimaryDark = Color(0xFFF8FAFC);
  static const Color textSecondaryDark = Color(0xFFCBD5E1);
  static const Color textTertiaryDark = Color(0xFF64748B);

  // ==========================================
  // Borders & Dividers
  // ==========================================
  static const Color border = Color(0xFFE2E8F0);
  static const Color borderLight = border;
  static const Color borderDark = Color(0xFF24334A);
  static const Color divider = Color(0xFFEDF2F7);
  static const Color dividerLight = divider;

  // ==========================================
  // Clinical / Semantic Status Colors
  // ==========================================
  static const Color success = Color(0xFF10B981); // Normal lab / in range
  static const Color successLight = Color(0xFFD1FAE5);
  static const Color successDark = Color(0xFF047857);

  static const Color warning = Color(0xFFF59E0B); // Borderline / caution
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color warningDark = Color(0xFFB45309);

  static const Color error = Color(0xFFEF4444); // Critical alert / abnormal
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color errorDark = Color(0xFFB91C1C);

  static const Color info = Color(0xFF3B82F6); // Clinical notes / info
  static const Color infoLight = Color(0xFFDBEAFE);
  static const Color infoDark = Color(0xFF1D4ED8);

  // ==========================================
  // Men's Health Domains
  // ==========================================
  static const Color endocrine = Color(0xFFD97706); // Testosterone / Hormones
  static const Color cardiovascular = Color(0xFFE11D48); // BP, HR, Vitals
  static const Color mentalWellness = Color(0xFF8B5CF6); // Focus, Stress, Mood
  static const Color sleep = Color(0xFF6366F1); // Sleep & Recovery
  static const Color fitness = Color(0xFF0284C7); // Workouts & Strength
  static const Color nutrition = Color(0xFF059669); // Diet & Glucose
  static const Color sexualHealth = Color(0xFFEC4899); // Sexual Wellness & Fertility
}
