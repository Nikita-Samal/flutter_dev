import 'package:nikita/features/cart/data/datasources/cart_remote_datasource.dart';
import 'package:nikita/features/cart/data/models/cart_item_model.dart';
import 'package:nikita/features/cart/domain/entities/cart_item_entity.dart';
import 'package:nikita/features/cart/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;

  CartRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<CartItemEntity>> getCartItems(String userId) async {
    return await remoteDataSource.getCartItems(userId);
  }

  @override
  Future<void> addToCart({required String userId, required CartItemEntity item}) async {
    final model = CartItemModel.fromEntity(item);
    await remoteDataSource.addToCart(userId: userId, item: model);
  }

  @override
  Future<void> updateQuantity({required String userId, required String productId, required int quantity}) async {
    await remoteDataSource.updateQuantity(userId: userId, productId: productId, quantity: quantity);
  }

  @override
  Future<void> removeFromCart({required String userId, required String productId}) async {
    await remoteDataSource.removeFromCart(userId: userId, productId: productId);
  }

  @override
  Future<void> clearCart(String userId) async {
    await remoteDataSource.clearCart(userId);
  }

  @override
  Stream<List<CartItemEntity>> watchCartItems(String userId) {
    return remoteDataSource.watchCartItems(userId);
  }
}
