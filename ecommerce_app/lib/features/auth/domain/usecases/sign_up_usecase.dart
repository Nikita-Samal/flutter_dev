import 'package:nikita/features/auth/domain/entities/user_entity.dart';
import 'package:nikita/features/auth/domain/repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository _repository;
  const SignUpUseCase(this._repository);
  
  Future<UserEntity> execute({required String email, required String password, required String name}) {
    return _repository.signUp(email: email, password: password, name: name);
  }
}
