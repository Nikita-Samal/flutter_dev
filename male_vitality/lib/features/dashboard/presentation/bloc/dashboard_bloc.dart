import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/dashboard_data.dart';
import '../../domain/repositories/dashboard_repository.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository _dashboardRepository;

  DashboardBloc({required DashboardRepository dashboardRepository})
      : _dashboardRepository = dashboardRepository,
        super(const DashboardState()) {
    on<DashboardLoadRequested>(_onDashboardLoadRequested);
    on<DashboardRefreshRequested>(_onDashboardRefreshRequested);
    on<TodaysFocusActionToggled>(_onTodaysFocusActionToggled);
  }

  Future<void> _onDashboardLoadRequested(
    DashboardLoadRequested event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(status: DashboardStatus.loading));
    await emit.forEach<DashboardData>(
      _dashboardRepository.watchDashboardData(),
      onData: (data) => state.copyWith(
        status: DashboardStatus.loaded,
        data: data,
      ),
      onError: (error, stackTrace) => state.copyWith(
        status: DashboardStatus.failure,
        errorMessage: error.toString(),
      ),
    );
  }

  Future<void> _onDashboardRefreshRequested(
    DashboardRefreshRequested event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(isRefreshing: true));
    final result = await _dashboardRepository.getDashboardData();

    result.fold(
      (failure) => emit(state.copyWith(
        isRefreshing: false,
        errorMessage: failure.message,
      )),
      (data) => emit(state.copyWith(
        status: DashboardStatus.loaded,
        data: data,
        isRefreshing: false,
      )),
    );
  }

  Future<void> _onTodaysFocusActionToggled(
    TodaysFocusActionToggled event,
    Emitter<DashboardState> emit,
  ) async {
    if (state.data == null) return;

    final updatedFocus = state.data!.todaysFocus.copyWith(
      isCompleted: event.isCompleted,
    );
    final updatedData = state.data!.copyWith(todaysFocus: updatedFocus);
    emit(state.copyWith(data: updatedData));

    final result = await _dashboardRepository.toggleTodaysFocus(
      event.focusId,
      event.isCompleted,
    );

    result.fold(
      (failure) {
        // Rollback on failure
        emit(state.copyWith(data: state.data));
      },
      (savedFocus) {
        final confirmedData = state.data!.copyWith(todaysFocus: savedFocus);
        emit(state.copyWith(data: confirmedData));
      },
    );
  }
}
