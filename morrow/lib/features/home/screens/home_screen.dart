import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../auth/services/auth_service.dart';

/// Home Screen – Phase 1 Placeholder
///
/// A warm, welcoming landing screen that will be expanded into the full
/// maternal and child care dashboard in Phase 2.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthService.instance.currentUser;
    final displayName = user?.displayName?.split(' ').first ?? 'Mama';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              _buildAppBar(context),
              const SizedBox(height: 40),
              _buildGreeting(displayName),
              const SizedBox(height: 40),
              _buildComingSoonCard(),
              const SizedBox(height: 28),
              _buildPillarsSection(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'MORROW',
          style: AppTextStyles.brandTitle.copyWith(fontSize: 22, letterSpacing: 4),
        ).animate().fadeIn(duration: 500.ms),
        IconButton(
          icon: const Icon(
            Icons.logout_rounded,
            color: AppColors.textSecondary,
          ),
          tooltip: 'Sign Out',
          onPressed: () async {
            await AuthService.instance.signOut();
            // authStateChanges stream handles navigation back to login
          },
        ).animate().fadeIn(duration: 500.ms, delay: 100.ms),
      ],
    );
  }

  Widget _buildGreeting(String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome to Morrow',
          style: AppTextStyles.displaySmall,
        )
            .animate()
            .fadeIn(duration: 600.ms, delay: 100.ms)
            .slideY(begin: 0.2, end: 0),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            style: AppTextStyles.bodyLarge,
            children: [
              const TextSpan(text: 'Hello, '),
              TextSpan(
                text: name,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const TextSpan(text: ' 🌸'),
            ],
          ),
        ).animate().fadeIn(duration: 500.ms, delay: 200.ms),
        const SizedBox(height: 6),
        Text(
          AppConstants.appTagline,
          style: AppTextStyles.brandTagline,
        ).animate().fadeIn(duration: 500.ms, delay: 300.ms),
      ],
    );
  }

  Widget _buildComingSoonCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFF5EBE6),
            Color(0xFFEDE4F0),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowWarm,
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.pregnant_woman_rounded,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Your Journey',
                style: AppTextStyles.titleLarge.copyWith(
                  color: AppColors.primaryDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Your complete maternal care dashboard is coming in Phase 2.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Personalized insights, health tracking, and AI-powered care are on their way.',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: 300.ms)
        .slideY(begin: 0.15, end: 0);
  }

  Widget _buildPillarsSection() {
    final pillars = [
      (
        icon: Icons.psychology_outlined,
        title: 'AI Care',
        subtitle: 'Personalized guidance',
        color: AppColors.peach,
      ),
      (
        icon: Icons.favorite_outline_rounded,
        title: 'Journey',
        subtitle: 'Mother & child',
        color: AppColors.rose,
      ),
      (
        icon: Icons.self_improvement_rounded,
        title: 'Wellness',
        subtitle: 'Mental & emotional',
        color: AppColors.sage,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What\'s Coming',
          style: AppTextStyles.titleLarge,
        ).animate().fadeIn(duration: 400.ms, delay: 400.ms),
        const SizedBox(height: 16),
        Row(
          children: pillars.asMap().entries.map((entry) {
            final i = entry.key;
            final p = entry.value;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: i < pillars.length - 1 ? 12 : 0),
                child: _PillarCard(
                  icon: p.icon,
                  title: p.title,
                  subtitle: p.subtitle,
                  color: p.color,
                  delay: 450 + (i * 80),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _PillarCard extends StatelessWidget {
  const _PillarCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.delay,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final int delay;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 10),
          Text(
            title,
            style: AppTextStyles.titleSmall.copyWith(
              color: AppColors.textPrimary,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: AppTextStyles.bodySmall.copyWith(fontSize: 11),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 400.ms, delay: Duration(milliseconds: delay))
        .slideY(begin: 0.1, end: 0);
  }
}
