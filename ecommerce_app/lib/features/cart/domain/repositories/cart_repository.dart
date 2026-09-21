import 'package:nikita/features/cart/domain/entities/cart_item_entity.dart';

abstract class CartRepository {
  Future<List<CartItemEntity>> getCartItems(String userId);
  Future<void> addToCart({required String userId, required CartItemEntity item});
  Future<void> updateQuantity({required String userId, required String productId, required int quantity});
  Future<void> removeFromCart({required String userId, required String productId});
  Future<void> clearCart(String userId);
  Stream<List<CartItemEntity>> watchCartItems(String userId);
}
