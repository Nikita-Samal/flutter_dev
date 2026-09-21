import 'package:nikita/features/wishlist/domain/entities/wishlist_entity.dart';

abstract class WishlistRepository {
  Future<WishlistEntity> getWishlist(String userId);
  Future<void> addToWishlist({required String userId, required String productId});
  Future<void> removeFromWishlist({required String userId, required String productId});
  Future<bool> isProductWishlisted({required String userId, required String productId});
  Stream<WishlistEntity> watchWishlist(String userId);
}
