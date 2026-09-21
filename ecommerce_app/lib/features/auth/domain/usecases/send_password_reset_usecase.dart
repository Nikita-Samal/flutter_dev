import 'package:nikita/features/auth/domain/repositories/auth_repository.dart';

class SendPasswordResetUseCase {
  final AuthRepository _repository;
  const SendPasswordResetUseCase(this._repository);
  
  Future<void> execute({required String email}) {
    return _repository.sendPasswordResetEmail(email: email);
  }
}
