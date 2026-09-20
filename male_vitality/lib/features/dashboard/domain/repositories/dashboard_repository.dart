import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/dashboard_data.dart';

/// Pure Dart Repository Contract for Home Dashboard
abstract class DashboardRepository {
  /// Fetches comprehensive dashboard metrics for the current user
  Future<Either<Failure, DashboardData>> getDashboardData();

  /// Real-time stream that emits updated dashboard metrics whenever the user profile changes
  Stream<DashboardData> watchDashboardData();

  /// Toggles today's priority focus status
  Future<Either<Failure, TodaysFocus>> toggleTodaysFocus(String focusId, bool isCompleted);
}
