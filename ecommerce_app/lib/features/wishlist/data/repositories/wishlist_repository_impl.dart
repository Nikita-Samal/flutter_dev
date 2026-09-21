import 'package:nikita/features/wishlist/data/datasources/wishlist_remote_datasource.dart';
import 'package:nikita/features/wishlist/domain/entities/wishlist_entity.dart';
import 'package:nikita/features/wishlist/domain/repositories/wishlist_repository.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistRemoteDataSource remoteDataSource;

  WishlistRepositoryImpl({required this.remoteDataSource});

  @override
  Future<WishlistEntity> getWishlist(String userId) async {
    return await remoteDataSource.getWishlist(userId);
  }

  @override
  Future<void> addToWishlist({required String userId, required String productId}) async {
    await remoteDataSource.addToWishlist(userId: userId, productId: productId);
  }

  @override
  Future<void> removeFromWishlist({required String userId, required String productId}) async {
    await remoteDataSource.removeFromWishlist(userId: userId, productId: productId);
  }

  @override
  Future<bool> isProductWishlisted({required String userId, required String productId}) async {
    return await remoteDataSource.isProductWishlisted(userId: userId, productId: productId);
  }

  @override
  Stream<WishlistEntity> watchWishlist(String userId) {
    return remoteDataSource.watchWishlist(userId);
  }
}
