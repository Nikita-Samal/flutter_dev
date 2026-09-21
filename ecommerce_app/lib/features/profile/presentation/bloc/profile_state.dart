import 'package:equatable/equatable.dart';

// Assuming UserEntity is defined somewhere globally, like auth feature
// For now we will use a generic placeholder or dynamic
class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? imageUrl;
  
  const UserEntity({required this.id, required this.name, required this.email, this.phone, this.imageUrl});
  
  @override
  List<Object?> get props => [id, name, email, phone, imageUrl];
}

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserEntity user;

  const ProfileLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class ProfileUpdateSuccess extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object> get props => [message];
}

class ProfileLoggingOut extends ProfileState {}
