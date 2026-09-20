import 'package:equatable/equatable.dart';

/// Base Failure definition for domain and data layers
/// Pure Dart (zero Flutter dependency) to comply with Clean Architecture.
abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure({
    required this.message,
    this.statusCode,
  });

  @override
  List<Object?> get props => [message, statusCode];
}

/// Remote API or server-side communication error
class ServerFailure extends Failure {
  const ServerFailure({
    super.message = 'A server error occurred. Please try again later.',
    super.statusCode,
  });
}

/// Device connectivity or socket error
class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'No network connection detected. Please verify your internet settings.',
  });
}

/// Local storage / Cache read-write error
class CacheFailure extends Failure {
  const CacheFailure({
    super.message = 'Failed to load local cached data.',
  });
}

/// Authentication & Authorization failure
class AuthFailure extends Failure {
  const AuthFailure({
    super.message = 'Authentication failed or session has expired.',
    super.statusCode = 401,
  });
}

/// Data or Form Validation error
class ValidationFailure extends Failure {
  final Map<String, List<String>>? fieldErrors;

  const ValidationFailure({
    super.message = 'Invalid data provided.',
    this.fieldErrors,
  });

  @override
  List<Object?> get props => [message, statusCode, fieldErrors];
}

/// Entity not found failure
class NotFoundFailure extends Failure {
  const NotFoundFailure({
    super.message = 'The requested clinical resource was not found.',
    super.statusCode = 404,
  });
}
