import 'package:flutter/material.dart';

import '../common/colours_palette.dart';

abstract final class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: ColoursPalette.cream,
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColoursPalette.forest,
      primary: ColoursPalette.forest,
      surface: ColoursPalette.surface,
    ),
    fontFamily: 'Arial',
  );
}
