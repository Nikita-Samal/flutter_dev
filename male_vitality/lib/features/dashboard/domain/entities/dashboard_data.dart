import 'package:equatable/equatable.dart';
import '../../../../core/constants/life_stage_constants.dart';

/// Personalized Health Vitality Score & Subsystem Breakdowns
class HealthScore extends Equatable {
  final int overallScore; // 0 to 100
  final String ratingLabel; // e.g. "Optimal Vitality", "Good", "Needs Attention"
  final String percentileText; // e.g. "Top 12% for age 26-39"
  final double endocrinePercentage; // 0.0 to 1.0
  final double cardiovascularPercentage;
  final double sleepRecoveryPercentage;
  final double metabolicPercentage;

  const HealthScore({
    required this.overallScore,
    required this.ratingLabel,
    required this.percentileText,
    required this.endocrinePercentage,
    required this.cardiovascularPercentage,
    required this.sleepRecoveryPercentage,
    required this.metabolicPercentage,
  });

  @override
  List<Object?> get props => [
        overallScore,
        ratingLabel,
        percentileText,
        endocrinePercentage,
        cardiovascularPercentage,
        sleepRecoveryPercentage,
        metabolicPercentage,
      ];
}

/// The Single Priority Clinical Action for the Day
class TodaysFocus extends Equatable {
  final String id;
  final String title;
  final String category; // e.g. "Morning Hormonal Protocol"
  final String durationMinutes; // e.g. "15 mins"
  final String description;
  final String actionLabel; // e.g. "Complete Protocol"
  final bool isCompleted;

  const TodaysFocus({
    required this.id,
    required this.title,
    required this.category,
    required this.durationMinutes,
    required this.description,
    required this.actionLabel,
    this.isCompleted = false,
  });

  TodaysFocus copyWith({bool? isCompleted}) {
    return TodaysFocus(
      id: id,
      title: title,
      category: category,
      durationMinutes: durationMinutes,
      description: description,
      actionLabel: actionLabel,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        category,
        durationMinutes,
        description,
        actionLabel,
        isCompleted,
      ];
}

/// Quick Vital Card Item
class VitalMetricItem extends Equatable {
  final String keyName;
  final String label;
  final String value;
  final String unit;
  final String statusLabel; // e.g. "Normal", "Optimal", "Borderline"
  final bool isOptimal;
  final String trendText; // e.g. "-0.6 kg this week", "+4% HRV"
  final bool isPositiveTrend;
  final String category; // e.g. "cardio", "sleep", "hormone"

  const VitalMetricItem({
    required this.keyName,
    required this.label,
    required this.value,
    required this.unit,
    required this.statusLabel,
    required this.isOptimal,
    required this.trendText,
    required this.isPositiveTrend,
    required this.category,
  });

  @override
  List<Object?> get props => [
        keyName,
        label,
        value,
        unit,
        statusLabel,
        isOptimal,
        trendText,
        isPositiveTrend,
        category,
      ];
}

/// Upcoming Diagnostic Screening Item
class DashboardScreeningItem extends Equatable {
  final String id;
  final String title;
  final String category;
  final DateTime dueDate;
  final int daysRemaining;
  final String providerOrLab;
  final bool isUrgent;

  const DashboardScreeningItem({
    required this.id,
    required this.title,
    required this.category,
    required this.dueDate,
    required this.daysRemaining,
    required this.providerOrLab,
    this.isUrgent = false,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        category,
        dueDate,
        daysRemaining,
        providerOrLab,
        isUrgent,
      ];
}

/// Recent Log / Activity Feed Item
class RecentActivityItem extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final DateTime timestamp;
  final String impactBadge;
  final String category;

  const RecentActivityItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.timestamp,
    required this.impactBadge,
    required this.category,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        subtitle,
        timestamp,
        impactBadge,
        category,
      ];
}

/// Aggregate Dashboard Entity
class DashboardData extends Equatable {
  final String userName;
  final LifeStage lifeStage;
  final HealthScore healthScore;
  final TodaysFocus todaysFocus;
  final List<VitalMetricItem> vitals;
  final List<DashboardScreeningItem> upcomingScreenings;
  final List<RecentActivityItem> recentActivities;

  const DashboardData({
    required this.userName,
    required this.lifeStage,
    required this.healthScore,
    required this.todaysFocus,
    required this.vitals,
    required this.upcomingScreenings,
    required this.recentActivities,
  });

  DashboardData copyWith({TodaysFocus? todaysFocus}) {
    return DashboardData(
      userName: userName,
      lifeStage: lifeStage,
      healthScore: healthScore,
      todaysFocus: todaysFocus ?? this.todaysFocus,
      vitals: vitals,
      upcomingScreenings: upcomingScreenings,
      recentActivities: recentActivities,
    );
  }

  @override
  List<Object?> get props => [
        userName,
        lifeStage,
        healthScore,
        todaysFocus,
        vitals,
        upcomingScreenings,
        recentActivities,
      ];
}
