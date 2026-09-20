import 'package:dartz/dartz.dart';
import '../../../../core/constants/life_stage_constants.dart';
import '../../../../core/error/failures.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../domain/entities/dashboard_data.dart';
import '../../domain/repositories/dashboard_repository.dart';

/// Mock implementation providing clinical mock data for Home Dashboard
class MockDashboardRepository implements DashboardRepository {
  final AuthRepository? _authRepository;
  final Duration delay;
  TodaysFocus _currentFocus = const TodaysFocus(
    id: 'focus_01',
    title: 'Morning Sunlight & Electrolyte Protocol',
    category: 'Circadian Endocrine Priming',
    durationMinutes: '10 min',
    description:
        '16 oz water + electrolytes with 10 mins direct sunlight exposure to synchronize cortisol awakening response and diurnal testosterone pulsatility.',
    actionLabel: 'Mark Completed',
    isCompleted: false,
  );

  MockDashboardRepository({
    AuthRepository? authRepository,
    this.delay = const Duration(milliseconds: 350),
  }) : _authRepository = authRepository;

  @override
  Future<Either<Failure, DashboardData>> getDashboardData() async {
    if (delay > Duration.zero) {
      await Future<void>.delayed(delay);
    }

    String userName = 'Marcus';
    LifeStage userLifeStage = LifeStage.primeVitality;

    if (_authRepository != null) {
      final userResult = await _authRepository.getCurrentUser();
      userResult.fold((_) {}, (user) {
        if (user != null) {
          if (user.firstName.isNotEmpty) {
            userName = user.firstName;
          }
          userLifeStage = user.lifeStage;
        }
      });
    }

    final data = DashboardData(
      userName: userName,
      lifeStage: userLifeStage,
      healthScore: const HealthScore(
        overallScore: 88,
        ratingLabel: 'Optimal Vitality',
        percentileText: 'Top 14% in your demographic group',
        endocrinePercentage: 0.92,
        cardiovascularPercentage: 0.89,
        sleepRecoveryPercentage: 0.85,
        metabolicPercentage: 0.90,
      ),
      todaysFocus: _currentFocus,
      vitals: const [
        VitalMetricItem(
          keyName: 'blood_pressure',
          label: 'Blood Pressure',
          value: '118/78',
          unit: 'mmHg',
          statusLabel: 'Optimal',
          isOptimal: true,
          trendText: '+2% stability',
          isPositiveTrend: true,
          category: 'cardio',
        ),
        VitalMetricItem(
          keyName: 'total_testosterone',
          label: 'Total Testosterone',
          value: '685',
          unit: 'ng/dL',
          statusLabel: 'Optimal',
          isOptimal: true,
          trendText: 'Free T: 18.2 pg/mL',
          isPositiveTrend: true,
          category: 'endocrine',
        ),
        VitalMetricItem(
          keyName: 'resting_heart_rate',
          label: 'Resting Heart Rate',
          value: '62',
          unit: 'bpm',
          statusLabel: 'Normal',
          isOptimal: true,
          trendText: 'HRV: 68 ms',
          isPositiveTrend: true,
          category: 'cardio',
        ),
        VitalMetricItem(
          keyName: 'sleep_duration',
          label: 'Sleep Duration',
          value: '7h 45m',
          unit: '86% Quality',
          statusLabel: 'Restorative',
          isOptimal: true,
          trendText: '+35m deep sleep',
          isPositiveTrend: true,
          category: 'sleep',
        ),
        VitalMetricItem(
          keyName: 'body_weight',
          label: 'Body Weight',
          value: '82.4',
          unit: 'kg',
          statusLabel: 'On Target',
          isOptimal: true,
          trendText: '-0.6 kg this week',
          isPositiveTrend: true,
          category: 'metabolic',
        ),
        VitalMetricItem(
          keyName: 'daily_steps',
          label: 'Daily Activity',
          value: '8,420',
          unit: 'of 10,000',
          statusLabel: '84% Goal',
          isOptimal: true,
          trendText: '+1,200 vs yesterday',
          isPositiveTrend: true,
          category: 'fitness',
        ),
      ],
      upcomingScreenings: [
        DashboardScreeningItem(
          id: 'scr_01',
          title: 'Comprehensive Hormone & Lipid Panel',
          category: 'Endocrine Diagnostic',
          dueDate: DateTime.now().add(const Duration(days: 14)),
          daysRemaining: 14,
          providerOrLab: 'Quest Diagnostics',
          isUrgent: false,
        ),
        DashboardScreeningItem(
          id: 'scr_02',
          title: 'Cardiovascular Risk & ApoB Assessment',
          category: 'Cardiology',
          dueDate: DateTime.now().add(const Duration(days: 42)),
          daysRemaining: 42,
          providerOrLab: 'Labcorp Clinical',
          isUrgent: false,
        ),
      ],
      recentActivities: [
        RecentActivityItem(
          id: 'act_01',
          title: 'Resistance Training Session',
          subtitle: 'Upper Hypertrophy · 52 mins · 420 kcal',
          timestamp: DateTime.now().subtract(const Duration(hours: 3)),
          impactBadge: '+Anabolic Stimulus',
          category: 'workout',
        ),
        RecentActivityItem(
          id: 'act_02',
          title: 'Sleep Architecture Logged',
          subtitle: '1h 55m Deep Sleep · 2h 10m REM',
          timestamp: DateTime.now().subtract(const Duration(hours: 6)),
          impactBadge: 'Restorative',
          category: 'sleep',
        ),
        RecentActivityItem(
          id: 'act_03',
          title: 'Supplements & Vitals Recorded',
          subtitle: 'Vitamin D3 5000IU + Omega-3 2000mg',
          timestamp: DateTime.now().subtract(const Duration(hours: 7)),
          impactBadge: 'Adherent',
          category: 'medication',
        ),
      ],
    );

    return Right(data);
  }

  @override
  Stream<DashboardData> watchDashboardData() async* {
    if (_authRepository != null) {
      await for (final _ in _authRepository.watchCurrentUserProfile()) {
        final result = await getDashboardData();
        if (result.isRight()) {
          yield result.getOrElse(() => throw Exception());
        }
      }
    } else {
      final result = await getDashboardData();
      if (result.isRight()) {
        yield result.getOrElse(() => throw Exception());
      }
    }
  }

  @override
  Future<Either<Failure, TodaysFocus>> toggleTodaysFocus(
    String focusId,
    bool isCompleted,
  ) async {
    if (delay > Duration.zero) {
      await Future<void>.delayed(delay);
    }
    _currentFocus = _currentFocus.copyWith(isCompleted: isCompleted);
    return Right(_currentFocus);
  }
}
