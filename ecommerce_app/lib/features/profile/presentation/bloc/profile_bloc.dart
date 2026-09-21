import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nikita/features/profile/presentation/bloc/profile_event.dart';
import 'package:nikita/features/profile/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  // In a real app, you would inject AuthBloc or AuthUseCase here
  
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileLoadRequested>(_onProfileLoadRequested);
    on<ProfileUpdateRequested>(_onProfileUpdateRequested);
    on<ProfileImageUpdateRequested>(_onProfileImageUpdateRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  void _onProfileLoadRequested(ProfileLoadRequested event, Emitter<ProfileState> emit) {
    emit(ProfileLoading());
    // Dummy implementation for loading user from Auth state
    emit(ProfileLoaded(UserEntity(
      id: event.userId,
      name: 'John Doe',
      email: 'john.doe@example.com',
    )));
  }

  void _onProfileUpdateRequested(ProfileUpdateRequested event, Emitter<ProfileState> emit) {
    // Show not implemented toast or handle update
    emit(const ProfileError('Not implemented: Firebase Storage not configured yet'));
  }

  void _onProfileImageUpdateRequested(ProfileImageUpdateRequested event, Emitter<ProfileState> emit) {
    // Show not implemented toast or handle update
    emit(const ProfileError('Not implemented: Firebase Storage not configured yet'));
  }

  void _onLogoutRequested(LogoutRequested event, Emitter<ProfileState> emit) {
    emit(ProfileLoggingOut());
    // Call SignOutUseCase here and handle auth state redirection elsewhere
  }
}
