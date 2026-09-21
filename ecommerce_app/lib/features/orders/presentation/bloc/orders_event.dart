import 'package:equatable/equatable.dart';
import 'package:nikita/features/cart/domain/entities/cart_item_entity.dart';
import 'package:nikita/features/orders/domain/entities/order_entity.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object> get props => [];
}

class OrdersWatchRequested extends OrdersEvent {
  final String userId;

  const OrdersWatchRequested(this.userId);

  @override
  List<Object> get props => [userId];
}

class OrderDetailRequested extends OrdersEvent {
  final String orderId;

  const OrderDetailRequested(this.orderId);

  @override
  List<Object> get props => [orderId];
}

class OrderCreateRequested extends OrdersEvent {
  final String userId;
  final List<CartItemEntity> items;
  final ShippingAddress address;
  final double subtotal;
  final double shipping;
  final double tax;
  final double total;

  const OrderCreateRequested({
    required this.userId,
    required this.items,
    required this.address,
    required this.subtotal,
    required this.shipping,
    required this.tax,
    required this.total,
  });

  @override
  List<Object> get props => [userId, items, address, subtotal, shipping, tax, total];
}
