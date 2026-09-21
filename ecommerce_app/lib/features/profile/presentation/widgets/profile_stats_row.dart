import 'package:flutter/material.dart';

class ProfileStatsRow extends StatelessWidget {
  final int ordersCount;
  final int wishlistCount;
  final int reviewsCount;
  final VoidCallback onOrdersTap;
  final VoidCallback onWishlistTap;

  const ProfileStatsRow({
    Key? key,
    required this.ordersCount,
    required this.wishlistCount,
    required this.reviewsCount,
    required this.onOrdersTap,
    required this.onWishlistTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatItem('Orders', ordersCount, onOrdersTap),
        _buildStatItem('Wishlist', wishlistCount, onWishlistTap),
        _buildStatItem('Reviews', reviewsCount, () {}),
      ],
    );
  }

  Widget _buildStatItem(String label, int count, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              count.toString(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
