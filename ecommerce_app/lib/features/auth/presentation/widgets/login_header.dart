import 'package:flutter/material.dart';
import 'package:nikita/common/colors/app_colors.dart';
import 'package:nikita/common/typography/app_typography.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Circular brand icon container - 80x80, gradient background, shopping bag icon
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primary, AppColors.primaryDark],
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Icon(Icons.shopping_bag_rounded, color: Colors.white, size: 40),
        ),
        const SizedBox(height: 24),
        Text('Nikita', style: AppTypography.displayMedium.copyWith(color: AppColors.textPrimary)),
        const SizedBox(height: 8),
        Text('Your premium shopping experience', style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary)),
      ],
    );
  }
}
