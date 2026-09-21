import 'package:nikita/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> signIn({required String email, required String password});
  Future<UserEntity> signUp({required String email, required String password, required String name});
  Future<void> signOut();
  Future<void> sendPasswordResetEmail({required String email});
  Stream<UserEntity?> get authStateChanges;
  Future<UserEntity?> getCurrentUser();
}
