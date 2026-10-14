import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';

enum ButtonIntent {
  add,
  save,
  danger,
}

class ZmlAppButton extends StatelessWidget {
  final ButtonIntent intent;
  final VoidCallback? onPressed;
  final String label;

  const ZmlAppButton({
    super.key,
    required this.intent,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final Color backgroundColor;
    final Color foregroundColor;

    switch (intent) {
      case ButtonIntent.add:
        backgroundColor = colorScheme.primary;
        foregroundColor = colorScheme.onPrimary;
        break;

      case ButtonIntent.save:
        backgroundColor = colorScheme.secondary;
        foregroundColor = colorScheme.onSecondary;
        break;

      case ButtonIntent.danger:
        backgroundColor = colorScheme.error;
        foregroundColor = colorScheme.onError;
        break;
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
      ),
      child: Text(label),
    );
  }
}