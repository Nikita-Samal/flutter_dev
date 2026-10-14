import 'package:flutter/material.dart';
import 'app_typography.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData light = ThemeData(
    useMaterial3: true,

    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.tealAccent,
      brightness: Brightness.light,
    ),

    textTheme:  TextTheme(
      titleMedium: AppTypography.title,
      bodyMedium: AppTypography.body,
      labelLarge: AppTypography.label,
    ),

    cardTheme:  CardThemeData(
      elevation: 1,
    ),

    inputDecorationTheme:  InputDecorationTheme(
      border: OutlineInputBorder(),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding:  EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    ),
  );

  static final ThemeData dark = ThemeData(
    useMaterial3: true,

    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.tealAccent,
      brightness: Brightness.dark,
    ),

    textTheme:  TextTheme(
      titleMedium: AppTypography.title,
      bodyMedium: AppTypography.body,
      labelLarge: AppTypography.label,
    ),

    cardTheme:  CardThemeData(
      elevation: 1,
    ),

    inputDecorationTheme:  InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
  );
}