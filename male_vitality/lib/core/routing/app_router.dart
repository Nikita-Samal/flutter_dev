import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../common/colors/app_colors.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/signup_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/dashboard/presentation/screens/home_dashboard_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

/// Central Route Names and Paths
abstract class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String onboarding = '/onboarding';
  static const String home = '/';
  static const String modules = '/modules';
  static const String track = '/track';
  static const String learn = '/learn';
  static const String profile = '/profile';
}

/// Central GoRouter configuration for MaleVitality
abstract class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.signup,
        name: 'signup',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) => const HomeDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.modules,
        name: 'modules',
        builder: (context, state) => const _PlaceholderScreen(
          title: 'Health Modules',
          subtitle: 'Endocrine, Cardiovascular, Mental Health, Sexual Health, and Longevity protocols.',
          icon: Icons.grid_view_outlined,
        ),
      ),
      GoRoute(
        path: AppRoutes.track,
        name: 'track',
        builder: (context, state) => const _PlaceholderScreen(
          title: 'Track & Biomarkers',
          subtitle: 'Log testosterone levels, blood pressure, sleep, workouts, and substances.',
          icon: Icons.show_chart_outlined,
        ),
      ),
      GoRoute(
        path: AppRoutes.learn,
        name: 'learn',
        builder: (context, state) => const _PlaceholderScreen(
          title: 'Learn & Education',
          subtitle: 'Evidence-based articles, doctor-curated guides, and life stage recommendations.',
          icon: Icons.menu_book_outlined,
        ),
      ),
      GoRoute(
        path: AppRoutes.profile,
        name: 'profile',
        builder: (context, state) => const _PlaceholderScreen(
          title: 'Profile & Settings',
          subtitle: 'Manage demographics, caregiver access, clinical records, and security.',
          icon: Icons.person_outline,
        ),
      ),
    ],
    errorBuilder: (context, state) {
      return Scaffold(
        appBar: AppBar(title: const Text('Not Found')),
        body: Center(
          child: Padding(
            padding: AppSpacing.screenPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline_rounded,
                  size: 56.0,
                  color: AppColors.error,
                ),
                AppSpacing.verticalMd,
                const Text('404 - Page Not Found', style: AppTextStyles.headlineMedium),
                AppSpacing.verticalSm,
                Text(
                  state.error?.toString() ?? 'The requested path could not be found.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium,
                ),
                AppSpacing.verticalLg,
                ElevatedButton(
                  onPressed: () => context.go(AppRoutes.home),
                  child: const Text('Back to Home'),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

/// Minimal, clean foundation placeholder screen
class _PlaceholderScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _PlaceholderScreen({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: AppSpacing.cardPadding,
                  child: Row(
                    children: [
                      Container(
                        padding: AppSpacing.insetAllSm,
                        decoration: const BoxDecoration(
                          color: AppColors.primary100,
                          borderRadius: AppSpacing.roundedMd,
                        ),
                        child: Icon(icon, color: AppColors.primary, size: 28.0),
                      ),
                      AppSpacing.horizontalMd,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(title, style: AppTextStyles.titleLarge),
                            AppSpacing.verticalXs,
                            Text(subtitle, style: AppTextStyles.bodySmall),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AppSpacing.verticalLg,
              const Text('Quick Navigation', style: AppTextStyles.headlineSmall),
              AppSpacing.verticalSm,
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  const _NavChip(label: 'Home', path: AppRoutes.home, currentTitle: 'Home'),
                  _NavChip(label: 'Modules', path: AppRoutes.modules, currentTitle: title),
                  _NavChip(label: 'Track', path: AppRoutes.track, currentTitle: title),
                  _NavChip(label: 'Learn', path: AppRoutes.learn, currentTitle: title),
                  _NavChip(label: 'Profile', path: AppRoutes.profile, currentTitle: title),
                  _NavChip(label: 'Login', path: AppRoutes.login, currentTitle: title),
                  _NavChip(label: 'Onboarding', path: AppRoutes.onboarding, currentTitle: title),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavChip extends StatelessWidget {
  final String label;
  final String path;
  final String currentTitle;

  const _NavChip({
    required this.label,
    required this.path,
    required this.currentTitle,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = currentTitle.toLowerCase().startsWith(label.toLowerCase());

    return FilterChip(
      selected: isSelected,
      label: Text(label),
      onSelected: (_) => context.go(path),
    );
  }
}
