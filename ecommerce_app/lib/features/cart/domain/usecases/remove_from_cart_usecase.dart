import 'package:nikita/features/cart/domain/repositories/cart_repository.dart';

class RemoveFromCartUseCase {
  final CartRepository repository;

  RemoveFromCartUseCase(this.repository);

  Future<void> call({required String userId, required String productId}) async {
    return await repository.removeFromCart(userId: userId, productId: productId);
  }
}
