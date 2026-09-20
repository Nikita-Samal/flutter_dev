import 'package:equatable/equatable.dart';
import '../../../../domain/entities/user_profile.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

/// Request to subscribe to live user profile stream from repository
class ProfileSubscriptionRequested extends ProfileEvent {
  const ProfileSubscriptionRequested();
}

/// Request to persist updated clinical demographics and intake to repository
class ProfileUpdateSubmitted extends ProfileEvent {
  final UserProfile profile;

  const ProfileUpdateSubmitted(this.profile);

  @override
  List<Object?> get props => [profile];
}
