import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nikita/features/cart/domain/entities/cart_item_entity.dart';

class CartItemModel extends CartItemEntity {
  const CartItemModel({
    required super.productId,
    required super.productName,
    required super.productImage,
    required super.price,
    super.discountPrice,
    required super.quantity,
    required super.maxStock,
    required super.addedAt,
  });

  factory CartItemModel.fromFirestore(Map<String, dynamic> data) {
    return CartItemModel(
      productId: data['productId'] as String,
      productName: data['productName'] as String? ?? '',
      productImage: data['productImage'] as String? ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0,
      discountPrice: (data['discountPrice'] as num?)?.toDouble(),
      quantity: data['quantity'] as int? ?? 1,
      maxStock: data['maxStock'] as int? ?? 99,
      addedAt: (data['addedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  factory CartItemModel.fromEntity(CartItemEntity entity) {
    return CartItemModel(
      productId: entity.productId,
      productName: entity.productName,
      productImage: entity.productImage,
      price: entity.price,
      discountPrice: entity.discountPrice,
      quantity: entity.quantity,
      maxStock: entity.maxStock,
      addedAt: entity.addedAt,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'productId': productId,
      'productName': productName,
      'productImage': productImage,
      'price': price,
      'discountPrice': discountPrice,
      'quantity': quantity,
      'maxStock': maxStock,
      'addedAt': Timestamp.fromDate(addedAt),
    };
  }
}
