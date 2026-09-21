import 'package:nikita/features/wishlist/domain/entities/wishlist_entity.dart';
import 'package:nikita/features/wishlist/domain/repositories/wishlist_repository.dart';

class GetWishlistUseCase {
  final WishlistRepository repository;

  GetWishlistUseCase(this.repository);

  Future<WishlistEntity> call(String userId) async {
    return await repository.getWishlist(userId);
  }
}
