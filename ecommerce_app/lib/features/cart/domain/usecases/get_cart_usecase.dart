import 'package:nikita/features/cart/domain/entities/cart_item_entity.dart';
import 'package:nikita/features/cart/domain/repositories/cart_repository.dart';

class GetCartUseCase {
  final CartRepository repository;

  GetCartUseCase(this.repository);

  Stream<List<CartItemEntity>> call(String userId) {
    return repository.watchCartItems(userId);
  }
}
