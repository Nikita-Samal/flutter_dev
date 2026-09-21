import 'package:nikita/core/errors/exceptions.dart';
import 'package:nikita/core/errors/failures.dart';
import 'package:nikita/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:nikita/features/auth/domain/entities/user_entity.dart';
import 'package:nikita/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _dataSource;
  const AuthRepositoryImpl(this._dataSource);

  @override
  Future<UserEntity> signIn({required String email, required String password}) async {
    try {
      return await _dataSource.signIn(email: email, password: password);
    } on AuthException catch (e) {
      throw AuthFailure(e.message);
    } on Exception catch (_) {
      throw const ServerFailure('Unexpected error');
    }
  }

  @override
  Future<UserEntity> signUp({required String email, required String password, required String name}) async {
    try {
      return await _dataSource.signUp(email: email, password: password, name: name);
    } on AuthException catch (e) {
      throw AuthFailure(e.message);
    } on Exception catch (_) {
      throw const ServerFailure('Unexpected error');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _dataSource.signOut();
    } on AuthException catch (e) {
      throw AuthFailure(e.message);
    } on Exception catch (_) {
      throw const ServerFailure('Unexpected error');
    }
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _dataSource.sendPasswordResetEmail(email: email);
    } on AuthException catch (e) {
      throw AuthFailure(e.message);
    } on Exception catch (_) {
      throw const ServerFailure('Unexpected error');
    }
  }

  @override
  Stream<UserEntity?> get authStateChanges {
    return _dataSource.authStateChanges;
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    try {
      return await _dataSource.getCurrentUser();
    } catch (_) {
      return null;
    }
  }
}
