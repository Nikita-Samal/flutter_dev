import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../core/error/failures.dart';

/// Base UseCase contract for domain business logic (Pure Dart + Clean Architecture)
abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

/// Parameter placeholder when a use case requires no arguments
class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}
