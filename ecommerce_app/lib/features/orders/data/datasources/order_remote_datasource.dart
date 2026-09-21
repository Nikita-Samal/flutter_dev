import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nikita/common/enums/app_enums.dart';
import 'package:nikita/features/cart/domain/entities/cart_item_entity.dart';
import 'package:nikita/features/orders/data/models/order_item_model.dart';
import 'package:nikita/features/orders/data/models/order_model.dart';
import 'package:nikita/features/orders/domain/entities/order_entity.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getUserOrders(String userId);
  Future<OrderModel> getOrderById(String orderId);
  Future<OrderModel> createOrder({
    required String userId,
    required List<CartItemEntity> items,
    required ShippingAddress address,
    required double subtotal,
    required double shipping,
    required double tax,
    required double total,
  });
  Stream<List<OrderModel>> watchUserOrders(String userId);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final FirebaseFirestore firestore;

  OrderRemoteDataSourceImpl(this.firestore);

  @override
  Future<List<OrderModel>> getUserOrders(String userId) async {
    final snapshot = await firestore
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs.map((doc) => OrderModel.fromFirestore(doc)).toList();
  }

  @override
  Future<OrderModel> getOrderById(String orderId) async {
    final doc = await firestore.collection('orders').doc(orderId).get();
    if (!doc.exists) {
      throw Exception('Order not found');
    }
    return OrderModel.fromFirestore(doc);
  }

  @override
  Future<OrderModel> createOrder({
    required String userId,
    required List<CartItemEntity> items,
    required ShippingAddress address,
    required double subtotal,
    required double shipping,
    required double tax,
    required double total,
  }) async {
    final docRef = firestore.collection('orders').doc();
    final now = DateTime.now();
    final orderNumber = 'ORD-${now.millisecondsSinceEpoch}';

    final orderItems = items
        .map((item) => OrderItemModel(
              productId: item.productId,
              productName: item.productName,
              productImage: item.productImage,
              price: item.price,
              quantity: item.quantity,
              itemTotal: item.price * item.quantity,
            ))
        .toList();

    final orderModel = OrderModel(
      id: docRef.id,
      userId: userId,
      orderNumber: orderNumber,
      items: orderItems,
      subtotal: subtotal,
      discount: 0.0,
      shipping: shipping,
      tax: tax,
      total: total,
      paymentStatus: PaymentStatus.pending,
      orderStatus: OrderStatus.pending,
      shippingAddress: ShippingAddressModel(
        fullName: address.fullName,
        address: address.address,
        city: address.city,
        state: address.state,
        postalCode: address.postalCode,
        phone: address.phone,
      ),
      createdAt: now,
      updatedAt: now,
    );

    await docRef.set(orderModel.toFirestore());
    return orderModel;
  }

  @override
  Stream<List<OrderModel>> watchUserOrders(String userId) {
    return firestore
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => OrderModel.fromFirestore(doc)).toList());
  }
}
