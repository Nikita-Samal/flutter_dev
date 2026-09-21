import 'package:nikita/features/wishlist/domain/repositories/wishlist_repository.dart';

class ToggleWishlistUseCase {
  final WishlistRepository repository;

  ToggleWishlistUseCase(this.repository);

  Future<void> call({required String userId, required String productId}) async {
    final isWishlisted = await repository.isProductWishlisted(userId: userId, productId: productId);
    if (isWishlisted) {
      await repository.removeFromWishlist(userId: userId, productId: productId);
    } else {
      await repository.addToWishlist(userId: userId, productId: productId);
    }
  }
}
