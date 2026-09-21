import 'package:nikita/features/cart/domain/entities/cart_item_entity.dart';
import 'package:nikita/features/orders/domain/entities/order_entity.dart';
import 'package:nikita/features/orders/domain/repositories/order_repository.dart';

class CreateOrderParams {
  final String userId;
  final List<CartItemEntity> items;
  final ShippingAddress address;
  final double subtotal;
  final double shipping;
  final double tax;
  final double total;

  CreateOrderParams({
    required this.userId,
    required this.items,
    required this.address,
    required this.subtotal,
    required this.shipping,
    required this.tax,
    required this.total,
  });
}

class CreateOrderUseCase {
  final OrderRepository repository;

  CreateOrderUseCase(this.repository);

  Future<OrderEntity> call(CreateOrderParams params) {
    return repository.createOrder(
      userId: params.userId,
      items: params.items,
      address: params.address,
      subtotal: params.subtotal,
      shipping: params.shipping,
      tax: params.tax,
      total: params.total,
    );
  }
}
