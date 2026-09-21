import 'package:nikita/features/cart/domain/entities/cart_item_entity.dart';
import 'package:nikita/features/orders/domain/entities/order_entity.dart';

abstract class OrderRepository {
  Future<List<OrderEntity>> getUserOrders(String userId);
  Future<OrderEntity> getOrderById(String orderId);
  Future<OrderEntity> createOrder({
    required String userId,
    required List<CartItemEntity> items,
    required ShippingAddress address,
    required double subtotal,
    required double shipping,
    required double tax,
    required double total,
  });
  Stream<List<OrderEntity>> watchUserOrders(String userId);
}
