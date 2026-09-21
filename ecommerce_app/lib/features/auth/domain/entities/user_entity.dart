import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String name;
  final String email;
  final String? phone;
  final String? profileImage;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserEntity({
    required this.uid,
    required this.name,
    required this.email,
    this.phone,
    this.profileImage,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  UserEntity copyWith({String? uid, String? name, String? email, String? phone, String? profileImage, String? role, DateTime? createdAt, DateTime? updatedAt}) {
    return UserEntity(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profileImage: profileImage ?? this.profileImage,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [uid, name, email, phone, profileImage, role, createdAt, updatedAt];
}
