import 'package:nikita/features/cart/domain/repositories/cart_repository.dart';

class UpdateCartQuantityUseCase {
  final CartRepository repository;

  UpdateCartQuantityUseCase(this.repository);

  Future<void> call({required String userId, required String productId, required int quantity}) async {
    return await repository.updateQuantity(userId: userId, productId: productId, quantity: quantity);
  }
}
