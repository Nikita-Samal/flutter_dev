import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../common/colors/app_colors.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

/// Refined 2026 Medical-Wellness Splash Screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.94, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.85, curve: Curves.easeOutCubic),
      ),
    );

    _controller.forward();

    // Trigger auth session check
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthBloc>().add(const AuthCheckRequested());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleNavigation(AuthState state) {
    // 3-second total calm display duration
    Future<void>.delayed(const Duration(milliseconds: 3000), () {
      if (!mounted) return;
      if (state is Authenticated) {
        context.go(AppRoutes.home);
      } else if (state is AuthenticatedNeedsOnboarding) {
        context.go(AppRoutes.onboarding);
      } else if (state is Unauthenticated || state is AuthFailureState) {
        context.go(AppRoutes.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is! AuthLoading && state is! AuthInitial) {
          _handleNavigation(state);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Stack(
          children: [
            // Ambient Soft Gradient Depth
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(0.0, -0.15),
                    radius: 1.1,
                    colors: [
                      AppColors.primary600.withValues(alpha: 0.35),
                      AppColors.primary,
                      AppColors.primary900,
                    ],
                  ),
                ),
              ),
            ),

            // Main Brand Center
            Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Refined Minimalist Clinical Monogram Emblem
                      Container(
                        width: 88.0,
                        height: 88.0,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.07),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.secondary.withValues(alpha: 0.3),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.secondary.withValues(alpha: 0.2),
                              blurRadius: 36.0,
                              spreadRadius: 2.0,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 56.0,
                                height: 56.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.secondary.withValues(alpha: 0.12),
                                ),
                              ),
                              const Icon(
                                Icons.shield_outlined,
                                size: 44.0,
                                color: AppColors.secondary200,
                              ),
                              const Icon(
                                Icons.add_rounded,
                                size: 22.0,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32.0),

                      // Brand Wordmark
                      Text(
                        'MALEVITALITY',
                        style: AppTextStyles.displaySmall.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 3.2,
                          fontSize: 24.0,
                        ),
                      ),
                      const SizedBox(height: 8.0),

                      // Refined Subtitle
                      Text(
                        'CLINICAL LONGEVITY & HEALTH OPTIMIZATION',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.primary200.withValues(alpha: 0.85),
                          letterSpacing: 1.6,
                          fontWeight: FontWeight.w600,
                          fontSize: 10.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom Clinical Verification Seal
            Positioned(
              left: 16.0,
              right: 16.0,
              bottom: 44.0,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.06),
                        borderRadius: AppSpacing.roundedFull,
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.1),
                          width: 1.0,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.verified_user_outlined,
                            size: 14.0,
                            color: AppColors.secondary300,
                          ),
                          const SizedBox(width: 6.0),
                          Text(
                            'HIPAA COMPLIANT · MEDICAL GRADE PLATFORM',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColors.primary200,
                              fontSize: 10.0,
                              letterSpacing: 0.8,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
