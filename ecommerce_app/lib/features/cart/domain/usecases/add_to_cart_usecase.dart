import 'package:nikita/features/cart/domain/entities/cart_item_entity.dart';
import 'package:nikita/features/cart/domain/repositories/cart_repository.dart';

class AddToCartUseCase {
  final CartRepository repository;

  AddToCartUseCase(this.repository);

  Future<void> call({required String userId, required CartItemEntity item}) async {
    return await repository.addToCart(userId: userId, item: item);
  }
}
