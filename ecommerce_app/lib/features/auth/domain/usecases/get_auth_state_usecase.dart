import 'package:nikita/features/auth/domain/entities/user_entity.dart';
import 'package:nikita/features/auth/domain/repositories/auth_repository.dart';

class GetAuthStateUseCase {
  final AuthRepository _repository;
  const GetAuthStateUseCase(this._repository);
  
  Stream<UserEntity?> execute() {
    return _repository.authStateChanges;
  }
}
