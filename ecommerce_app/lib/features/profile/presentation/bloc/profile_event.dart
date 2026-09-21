import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class ProfileLoadRequested extends ProfileEvent {
  final String userId;

  const ProfileLoadRequested(this.userId);

  @override
  List<Object> get props => [userId];
}

class ProfileUpdateRequested extends ProfileEvent {
  final String userId;
  final String name;
  final String phone;

  const ProfileUpdateRequested({
    required this.userId,
    required this.name,
    required this.phone,
  });

  @override
  List<Object> get props => [userId, name, phone];
}

class ProfileImageUpdateRequested extends ProfileEvent {
  final String userId;
  final File imageFile;

  const ProfileImageUpdateRequested({
    required this.userId,
    required this.imageFile,
  });

  @override
  List<Object> get props => [userId, imageFile];
}

class LogoutRequested extends ProfileEvent {}
