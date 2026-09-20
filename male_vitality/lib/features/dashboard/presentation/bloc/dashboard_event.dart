import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

/// Request to load initial dashboard metrics
class DashboardLoadRequested extends DashboardEvent {
  const DashboardLoadRequested();
}

/// Pull-to-refresh event
class DashboardRefreshRequested extends DashboardEvent {
  const DashboardRefreshRequested();
}

/// Action toggle for Today's Focus protocol
class TodaysFocusActionToggled extends DashboardEvent {
  final String focusId;
  final bool isCompleted;

  const TodaysFocusActionToggled({
    required this.focusId,
    required this.isCompleted,
  });

  @override
  List<Object?> get props => [focusId, isCompleted];
}
