import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/user_profile.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthRepository _authRepository;

  ProfileBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const ProfileState()) {
    on<ProfileSubscriptionRequested>(_onSubscriptionRequested);
    on<ProfileUpdateSubmitted>(_onUpdateSubmitted);
  }

  Future<void> _onSubscriptionRequested(
    ProfileSubscriptionRequested event,
    Emitter<ProfileState> emit,
  ) async {
    if (state.profile == null) {
      emit(state.copyWith(status: ProfileStatus.loading));
    }

    await emit.forEach<UserProfile?>(
      _authRepository.watchCurrentUserProfile(),
      onData: (userProfile) {
        if (userProfile == null) {
          return state.copyWith(
            status: ProfileStatus.failure,
            errorMessage: 'User profile session unavailable.',
          );
        }
        return state.copyWith(
          status: ProfileStatus.loaded,
          profile: userProfile,
        );
      },
      onError: (error, stackTrace) {
        return state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: 'Failed to subscribe to profile updates: $error',
        );
      },
    );
  }

  Future<void> _onUpdateSubmitted(
    ProfileUpdateSubmitted event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStatus.saving, errorMessage: null, successMessage: null));

    final result = await _authRepository.updateUserProfile(event.profile);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (updatedProfile) => emit(
        state.copyWith(
          status: ProfileStatus.success,
          profile: updatedProfile,
          successMessage: 'Clinical profile updated successfully.',
        ),
      ),
    );
  }
}
