import 'package:flutter/material.dart';

import 'core/app_theme.dart';
import 'features/presentation/pages/grocery_home_page.dart';

void main() => runApp(const GroceryApp());

class GroceryApp extends StatelessWidget {
  const GroceryApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Freshly',
    theme: AppTheme.light,
    home: const GroceryHomePage(),
  );
}
