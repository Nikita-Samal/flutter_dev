import 'package:nikita/features/auth/domain/entities/user_entity.dart';
import 'package:nikita/features/auth/domain/repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository _repository;
  const SignInUseCase(this._repository);
  
  Future<UserEntity> execute({required String email, required String password}) {
    return _repository.signIn(email: email, password: password);
  }
}
