import 'package:flutter/material.dart';
import 'package:nikita/common/colors/app_colors.dart';
import 'package:nikita/common/dimensions/app_dimensions.dart';
import 'package:nikita/common/typography/app_typography.dart';

class StarRatingWidget extends StatelessWidget {
  final double rating;
  final int? reviewCount;
  final double size;

  const StarRatingWidget({
    super.key,
    required this.rating,
    this.reviewCount,
    this.size = AppDimensions.iconSizeMd,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(5, (index) {
          IconData icon;
          if (index < rating.floor()) {
            icon = Icons.star;
          } else if (index == rating.floor() && rating % 1 != 0) {
            icon = Icons.star_half;
          } else {
            icon = Icons.star_border;
          }
          return Icon(
            icon,
            color: AppColors.starColor,
            size: size,
          );
        }),
        if (reviewCount != null) ...[
          const SizedBox(width: AppDimensions.spacingXs),
          Text(
            '($reviewCount)',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ],
    );
  }
}
