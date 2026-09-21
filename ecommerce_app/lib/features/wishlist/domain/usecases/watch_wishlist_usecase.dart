import 'package:nikita/features/wishlist/domain/entities/wishlist_entity.dart';
import 'package:nikita/features/wishlist/domain/repositories/wishlist_repository.dart';

class WatchWishlistUseCase {
  final WishlistRepository repository;

  WatchWishlistUseCase(this.repository);

  Stream<WishlistEntity> call(String userId) {
    return repository.watchWishlist(userId);
  }
}
