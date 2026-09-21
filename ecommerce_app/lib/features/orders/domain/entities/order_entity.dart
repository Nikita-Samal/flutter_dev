import 'package:equatable/equatable.dart';
import 'package:nikita/common/enums/app_enums.dart';
import 'package:nikita/features/orders/domain/entities/order_item_entity.dart';

class ShippingAddress extends Equatable {
  final String fullName;
  final String address;
  final String city;
  final String state;
  final String postalCode;
  final String phone;
  
  const ShippingAddress({
    required this.fullName,
    required this.address,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.phone,
  });
  
  @override
  List<Object> get props => [fullName, address, city, state, postalCode, phone];
  
  String get formatted => '$fullName\n$address\n$city, $state $postalCode\n$phone';
}

class OrderEntity extends Equatable {
  final String id;
  final String userId;
  final String orderNumber;
  final List<OrderItemEntity> items;
  final double subtotal;
  final double discount;
  final double shipping;
  final double tax;
  final double total;
  final PaymentStatus paymentStatus;
  final OrderStatus orderStatus;
  final ShippingAddress shippingAddress;
  final String? paymentMethod;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  const OrderEntity({
    required this.id,
    required this.userId,
    required this.orderNumber,
    required this.items,
    required this.subtotal,
    required this.discount,
    required this.shipping,
    required this.tax,
    required this.total,
    required this.paymentStatus,
    required this.orderStatus,
    required this.shippingAddress,
    this.paymentMethod,
    required this.createdAt,
    required this.updatedAt,
  });
  
  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);
  String get firstItemImage => items.isNotEmpty ? items.first.productImage : '';
  
  @override
  List<Object?> get props => [
    id,
    userId,
    orderNumber,
    items,
    subtotal,
    discount,
    shipping,
    tax,
    total,
    paymentStatus,
    orderStatus,
    shippingAddress,
    paymentMethod,
    createdAt,
    updatedAt,
  ];
}
