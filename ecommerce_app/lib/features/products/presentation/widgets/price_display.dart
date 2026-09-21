import 'package:flutter/material.dart';

class PriceDisplay extends StatelessWidget {
  final double price;
  final double? discountPrice;
  final bool showOriginal;
  final TextStyle? priceStyle;
  final TextStyle? originalPriceStyle;

  const PriceDisplay({
    super.key,
    required this.price,
    this.discountPrice,
    this.showOriginal = true,
    this.priceStyle,
    this.originalPriceStyle,
  });

  @override
  Widget build(BuildContext context) {
    final hasDiscount = discountPrice != null && discountPrice! < price;
    final effectivePrice = discountPrice ?? price;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '\$${effectivePrice.toStringAsFixed(2)}',
          style: priceStyle ??
              const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
        ),
        if (hasDiscount && showOriginal) ...[
          const SizedBox(width: 8),
          Text(
            '\$${price.toStringAsFixed(2)}',
            style: originalPriceStyle ??
                const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
          ),
        ],
      ],
    );
  }
}
