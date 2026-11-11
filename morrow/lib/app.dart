import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_text_styles.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/home/screens/home_screen.dart';

/// Root application widget.
///
/// [firebaseReady] – set to false when Firebase is not yet configured;
/// the app runs in UI-preview mode showing the login screen directly.
class MorrowApp extends StatelessWidget {
  const MorrowApp({super.key, this.firebaseReady = false});

  final bool firebaseReady;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Morrow',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: firebaseReady ? const _AuthGate() : const LoginScreen(),
    );
  }
}

/// Auth gate that listens to Firebase auth state changes.
class _AuthGate extends StatelessWidget {
  const _AuthGate();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // ── Loading ───────────────────────────────────────────────────────
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const _SplashScreen();
        }

        // ── Authenticated ─────────────────────────────────────────────────
        if (snapshot.hasData && snapshot.data != null) {
          return const HomeScreen();
        }

        // ── Unauthenticated ───────────────────────────────────────────────
        return const LoginScreen();
      },
    );
  }
}

/// Splash screen shown while Firebase initializes or auth state resolves.
class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: AppColors.primaryGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 28,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(
                Icons.favorite_rounded,
                color: Colors.white,
                size: 42,
              ),
            )
                .animate(onPlay: (c) => c.repeat())
                .scaleXY(
                  begin: 1.0,
                  end: 1.08,
                  duration: 900.ms,
                  curve: Curves.easeInOut,
                )
                .then()
                .scaleXY(
                  begin: 1.08,
                  end: 1.0,
                  duration: 900.ms,
                  curve: Curves.easeInOut,
                ),
            const SizedBox(height: 24),
            Text(
              'MORROW',
              style: AppTextStyles.brandTitle.copyWith(fontSize: 32),
            ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
          ],
        ),
      ),
    );
  }
}
