import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Dispatched upon app startup to check existing session
class AuthCheckRequested extends AuthEvent {
  const AuthCheckRequested();
}

/// Dispatched when user submits login form
class LoginSubmitted extends AuthEvent {
  final String email;
  final String password;

  const LoginSubmitted({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

/// Dispatched when user submits signup form
class SignUpSubmitted extends AuthEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  const SignUpSubmitted({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [firstName, lastName, email, password];
}

/// Dispatched when user requests logout
class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}
