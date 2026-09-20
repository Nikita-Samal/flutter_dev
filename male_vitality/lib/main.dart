import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/constants/app_constants.dart';
import 'core/routing/app_router.dart';
import 'core/services/firebase_service.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/data/repositories/firebase_auth_repository.dart';
import 'features/auth/data/repositories/mock_auth_repository.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'features/dashboard/data/repositories/mock_dashboard_repository.dart';
import 'features/dashboard/domain/repositories/dashboard_repository.dart';
import 'features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'features/onboarding/presentation/bloc/onboarding_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase (safely falls back if project is not yet configured)
  final isFirebaseReady = await FirebaseService.initialize();

  // Set default system overlay styles
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  final AuthRepository authRepository;
  final DashboardRepository dashboardRepository;

  if (isFirebaseReady) {
    authRepository = FirebaseAuthRepository();
    dashboardRepository = DashboardRepositoryImpl(authRepository: authRepository);
  } else {
    // Graceful fallback to mock repository in local/unconfigured environments
    authRepository = MockAuthRepository();
    dashboardRepository = MockDashboardRepository(authRepository: authRepository);
  }

  runApp(MaleVitalityApp(
    authRepository: authRepository,
    dashboardRepository: dashboardRepository,
  ));
}

/// Root application widget for MaleVitality
class MaleVitalityApp extends StatelessWidget {
  final AuthRepository? authRepository;
  final DashboardRepository? dashboardRepository;

  const MaleVitalityApp({
    super.key,
    this.authRepository,
    this.dashboardRepository,
  });

  @override
  Widget build(BuildContext context) {
    final repository = authRepository ??
        (FirebaseService.isAvailable
            ? FirebaseAuthRepository()
            : MockAuthRepository());
    final dashRepo = dashboardRepository ??
        (FirebaseService.isAvailable
            ? DashboardRepositoryImpl(authRepository: repository)
            : MockDashboardRepository(authRepository: repository));

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(authRepository: repository),
        ),
        BlocProvider<OnboardingBloc>(
          create: (_) => OnboardingBloc(authRepository: repository),
        ),
        BlocProvider<DashboardBloc>(
          create: (_) => DashboardBloc(dashboardRepository: dashRepo),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,

            // Navigation Configuration
            routerConfig: AppRouter.router,

            // Design System Theme
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.system,
          );
        },
      ),
    );
  }
}
