import 'package:equatable/equatable.dart';
import '../../../../domain/entities/user_profile.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Initial uninitialized state
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Processing authentication action
class AuthLoading extends AuthState {
  const AuthLoading();
}

/// User is authenticated and has finished onboarding
class Authenticated extends AuthState {
  final UserProfile user;

  const Authenticated(this.user);

  @override
  List<Object?> get props => [user];
}

/// User created account but needs to complete multi-step clinical onboarding
class AuthenticatedNeedsOnboarding extends AuthState {
  final UserProfile user;

  const AuthenticatedNeedsOnboarding(this.user);

  @override
  List<Object?> get props => [user];
}

/// No active user session
class Unauthenticated extends AuthState {
  const Unauthenticated();
}

/// Authentication or network failure
class AuthFailureState extends AuthState {
  final String message;

  const AuthFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
