import 'package:nikita/features/cart/domain/repositories/cart_repository.dart';

class ClearCartUseCase {
  final CartRepository repository;

  ClearCartUseCase(this.repository);

  Future<void> call(String userId) async {
    return await repository.clearCart(userId);
  }
}
