import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../common/colors/app_colors.dart';
import '../../../../common/extensions/context_extensions.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';
import '../bloc/dashboard_state.dart';
import '../widgets/greeting_header.dart';
import '../widgets/health_score_card.dart';
import '../widgets/quick_vitals_section.dart';
import '../widgets/todays_focus_card.dart';
import '../widgets/upcoming_screenings_section.dart';

/// Comprehensive Master Home Dashboard Screen for MaleVitality
class HomeDashboardScreen extends StatefulWidget {
  const HomeDashboardScreen({super.key});

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
  int _currentNavIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().add(const DashboardLoadRequested());
  }

  void _onNavigationItemSelected(int index) {
    setState(() {
      _currentNavIndex = index;
    });

    switch (index) {
      case 0:
        context.go(AppRoutes.home);
        break;
      case 1:
        context.go(AppRoutes.modules);
        break;
      case 2:
        context.go(AppRoutes.track);
        break;
      case 3:
        context.go(AppRoutes.learn);
        break;
      case 4:
        context.go(AppRoutes.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocConsumer<DashboardBloc, DashboardState>(
          listener: (context, state) {
            if (state.status == DashboardStatus.failure && state.errorMessage != null) {
              context.showSnackBar(state.errorMessage!, isError: true);
            }
          },
          builder: (context, state) {
            if (state.status == DashboardStatus.loading && state.data == null) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              );
            }

            if (state.status == DashboardStatus.failure && state.data == null) {
              return Center(
                child: Padding(
                  padding: AppSpacing.screenPadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.cloud_off_rounded,
                        size: 48.0,
                        color: AppColors.error,
                      ),
                      AppSpacing.verticalMd,
                      const Text(
                        'Failed to load health metrics',
                        style: AppTextStyles.headlineSmall,
                      ),
                      AppSpacing.verticalXs,
                      Text(
                        state.errorMessage ?? 'Please check your connection.',
                        style: AppTextStyles.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      AppSpacing.verticalLg,
                      ElevatedButton.icon(
                        onPressed: () {
                          context.read<DashboardBloc>().add(const DashboardLoadRequested());
                        },
                        icon: const Icon(Icons.refresh_rounded),
                        label: const Text('Try Again'),
                      ),
                    ],
                  ),
                ),
              );
            }

            final data = state.data;
            if (data == null) {
              return const SizedBox.shrink();
            }

            return RefreshIndicator(
              color: AppColors.secondary,
              backgroundColor: Colors.white,
              onRefresh: () async {
                context.read<DashboardBloc>().add(const DashboardRefreshRequested());
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: AppSpacing.screenPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Greeting & Life Stage Header (Minimal)
                    GreetingHeader(
                      userName: data.userName,
                      lifeStage: data.lifeStage,
                      onNotificationTap: () {
                        context.showSnackBar('No pending critical notifications.');
                      },
                      onProfileTap: () {
                        context.go(AppRoutes.profile);
                      },
                    ),
                    const SizedBox(height: 20.0),

                    // 2. Large Elegant Health Score (Hero Element)
                    HealthScoreCard(
                      healthScore: data.healthScore,
                    ),
                    const SizedBox(height: 24.0),

                    // 3. One "Today's Focus" Priority Protocol Card
                    TodaysFocusCard(
                      focus: data.todaysFocus,
                      onToggleCompleted: (completed) {
                        context.read<DashboardBloc>().add(
                              TodaysFocusActionToggled(
                                focusId: data.todaysFocus.id,
                                isCompleted: completed,
                              ),
                            );
                        if (completed) {
                          context.showSuccessSnackBar(
                            'Protocol marked complete! Vitality score refreshed.',
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 24.0),

                    // 4. Compact Vitals Row (Max 4 Key Metrics)
                    QuickVitalsSection(
                      vitals: data.vitals,
                      onVitalTap: (vital) {
                        context.showSnackBar(
                          '${vital.label}: ${vital.value} ${vital.unit} (${vital.statusLabel})',
                        );
                      },
                    ),
                    const SizedBox(height: 24.0),

                    // 5. Subtle Upcoming Screenings Section
                    UpcomingScreeningsSection(
                      screenings: data.upcomingScreenings,
                      onScheduleTap: (screening) {
                        context.showSuccessSnackBar(
                          'Appointment request sent for ${screening.title}.',
                        );
                      },
                    ),
                    const SizedBox(height: 32.0),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentNavIndex,
        onDestinationSelected: _onNavigationItemSelected,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view_rounded),
            label: 'Modules',
          ),
          NavigationDestination(
            icon: Icon(Icons.show_chart_outlined),
            selectedIcon: Icon(Icons.show_chart_rounded),
            label: 'Track',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book_rounded),
            label: 'Learn',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
