import 'package:flutter/material.dart';

class DiscountBadge extends StatelessWidget {
  final double discountPercent;

  const DiscountBadge({super.key, required this.discountPercent});

  @override
  Widget build(BuildContext context) {
    if (discountPercent <= 0) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '-${discountPercent.toInt()}%',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
