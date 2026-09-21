import 'package:nikita/features/cart/domain/entities/cart_item_entity.dart';
import 'package:nikita/features/orders/data/datasources/order_remote_datasource.dart';
import 'package:nikita/features/orders/domain/entities/order_entity.dart';
import 'package:nikita/features/orders/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl({required this.remoteDataSource});

  @override
  Future<OrderEntity> createOrder({
    required String userId,
    required List<CartItemEntity> items,
    required ShippingAddress address,
    required double subtotal,
    required double shipping,
    required double tax,
    required double total,
  }) async {
    return await remoteDataSource.createOrder(
      userId: userId,
      items: items,
      address: address,
      subtotal: subtotal,
      shipping: shipping,
      tax: tax,
      total: total,
    );
  }

  @override
  Future<OrderEntity> getOrderById(String orderId) async {
    return await remoteDataSource.getOrderById(orderId);
  }

  @override
  Future<List<OrderEntity>> getUserOrders(String userId) async {
    return await remoteDataSource.getUserOrders(userId);
  }

  @override
  Stream<List<OrderEntity>> watchUserOrders(String userId) {
    return remoteDataSource.watchUserOrders(userId);
  }
}
