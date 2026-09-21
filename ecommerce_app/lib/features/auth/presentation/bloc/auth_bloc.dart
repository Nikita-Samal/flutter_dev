import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nikita/core/errors/failures.dart';
import 'package:nikita/core/utils/app_logger.dart';
import 'package:nikita/features/auth/domain/usecases/get_auth_state_usecase.dart';
import 'package:nikita/features/auth/domain/usecases/send_password_reset_usecase.dart';
import 'package:nikita/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:nikita/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:nikita/features/auth/domain/usecases/sign_up_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase _signIn;
  final SignUpUseCase _signUp;
  final SignOutUseCase _signOut;
  final SendPasswordResetUseCase _passwordReset;
  final GetAuthStateUseCase _getAuthState;
  StreamSubscription? _authSubscription;

  AuthBloc({
    required SignInUseCase signIn,
    required SignUpUseCase signUp,
    required SignOutUseCase signOut,
    required SendPasswordResetUseCase passwordReset,
    required GetAuthStateUseCase getAuthState,
  }) : _signIn = signIn, _signUp = signUp, _signOut = signOut, _passwordReset = passwordReset, _getAuthState = getAuthState,
       super(const AuthInitial()) {
    on<AuthStarted>(_onAuthStarted);
    on<SignInRequested>(_onSignIn);
    on<SignUpRequested>(_onSignUp);
    on<SignOutRequested>(_onSignOut);
    on<PasswordResetRequested>(_onPasswordReset);
  }
  
  Future<void> _onAuthStarted(AuthStarted event, Emitter<AuthState> emit) async {
    await emit.forEach(
      _getAuthState.execute(),
      onData: (user) => user != null ? Authenticated(user: user) : const Unauthenticated(),
      onError: (_, __) => const Unauthenticated(),
    );
  }
  
  Future<void> _onSignIn(SignInRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      final user = await _signIn.execute(email: event.email, password: event.password);
      emit(Authenticated(user: user));
    } on AuthFailure catch (e) {
      emit(AuthError(message: e.message));
    } on Failure catch (e) {
      emit(AuthError(message: e.message));
    } catch (e) {
      emit(AuthError(message: 'An unexpected error occurred'));
      AppLogger.error('SignIn error', e);
    }
  }
  
  Future<void> _onSignUp(SignUpRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      final user = await _signUp.execute(email: event.email, password: event.password, name: event.name);
      emit(Authenticated(user: user));
    } on AuthFailure catch (e) {
      emit(AuthError(message: e.message));
    } catch (e) {
      emit(AuthError(message: 'Failed to create account'));
    }
  }
  
  Future<void> _onSignOut(SignOutRequested event, Emitter<AuthState> emit) async {
    try {
      await _signOut.execute();
      emit(const Unauthenticated());
    } catch (e) {
      emit(AuthError(message: 'Failed to sign out'));
    }
  }
  
  Future<void> _onPasswordReset(PasswordResetRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      await _passwordReset.execute(email: event.email);
      emit(const PasswordResetSent());
    } on AuthFailure catch (e) {
      emit(AuthError(message: e.message));
    } catch (e) {
      emit(AuthError(message: 'Failed to send reset email'));
    }
  }
  
  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
