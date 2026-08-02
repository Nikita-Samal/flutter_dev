part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class IncrementCounter extends HomeEvent {
  const IncrementCounter();
}

class DecrementCounter extends HomeEvent {
  const DecrementCounter();
}

class ResetCounter extends HomeEvent {
  const ResetCounter();
}
