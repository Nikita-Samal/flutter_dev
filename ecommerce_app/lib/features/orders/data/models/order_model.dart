import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nikita/common/enums/app_enums.dart';
import 'package:nikita/features/orders/data/models/order_item_model.dart';
import 'package:nikita/features/orders/domain/entities/order_entity.dart';

class ShippingAddressModel extends ShippingAddress {
  const ShippingAddressModel({
    required super.fullName,
    required super.address,
    required super.city,
    required super.state,
    required super.postalCode,
    required super.phone,
  });

  factory ShippingAddressModel.fromMap(Map<String, dynamic> map) {
    return ShippingAddressModel(
      fullName: map['fullName'] as String? ?? '',
      address: map['address'] as String? ?? '',
      city: map['city'] as String? ?? '',
      state: map['state'] as String? ?? '',
      postalCode: map['postalCode'] as String? ?? '',
      phone: map['phone'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'address': address,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'phone': phone,
    };
  }
}

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.userId,
    required super.orderNumber,
    required super.items,
    required super.subtotal,
    required super.discount,
    required super.shipping,
    required super.tax,
    required super.total,
    required super.paymentStatus,
    required super.orderStatus,
    required super.shippingAddress,
    super.paymentMethod,
    required super.createdAt,
    required super.updatedAt,
  });

  factory OrderModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    
    return OrderModel(
      id: doc.id,
      userId: data['userId'] as String? ?? '',
      orderNumber: data['orderNumber'] as String? ?? '',
      items: (data['items'] as List<dynamic>?)
              ?.map((item) => OrderItemModel.fromMap(item as Map<String, dynamic>))
              .toList() ??
          [],
      subtotal: (data['subtotal'] as num?)?.toDouble() ?? 0.0,
      discount: (data['discount'] as num?)?.toDouble() ?? 0.0,
      shipping: (data['shipping'] as num?)?.toDouble() ?? 0.0,
      tax: (data['tax'] as num?)?.toDouble() ?? 0.0,
      total: (data['total'] as num?)?.toDouble() ?? 0.0,
      paymentStatus: PaymentStatus.values.firstWhere(
        (e) => e.toString().split('.').last == data['paymentStatus'],
        orElse: () => PaymentStatus.pending,
      ),
      orderStatus: OrderStatus.values.firstWhere(
        (e) => e.toString().split('.').last == data['orderStatus'],
        orElse: () => OrderStatus.pending,
      ),
      shippingAddress: ShippingAddressModel.fromMap(
        data['shippingAddress'] as Map<String, dynamic>? ?? {},
      ),
      paymentMethod: data['paymentMethod'] as String?,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'orderNumber': orderNumber,
      'items': items.map((item) => (item as OrderItemModel).toMap()).toList(),
      'subtotal': subtotal,
      'discount': discount,
      'shipping': shipping,
      'tax': tax,
      'total': total,
      'paymentStatus': paymentStatus.toString().split('.').last,
      'orderStatus': orderStatus.toString().split('.').last,
      'shippingAddress': (shippingAddress as ShippingAddressModel).toMap(),
      'paymentMethod': paymentMethod,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }
}
