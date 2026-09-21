import 'package:nikita/features/auth/domain/repositories/auth_repository.dart';

class SignOutUseCase {
  final AuthRepository _repository;
  const SignOutUseCase(this._repository);
  
  Future<void> execute() {
    return _repository.signOut();
  }
}
