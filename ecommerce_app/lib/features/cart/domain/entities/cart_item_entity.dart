import 'package:equatable/equatable.dart';

class CartItemEntity extends Equatable {
  final String productId;
  final String productName;
  final String productImage;
  final double price;
  final double? discountPrice;
  final int quantity;
  final int maxStock;
  final DateTime addedAt;

  const CartItemEntity({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.price,
    this.discountPrice,
    required this.quantity,
    required this.maxStock,
    required this.addedAt,
  });
  
  double get effectivePrice => discountPrice ?? price;
  double get itemTotal => effectivePrice * quantity;
  bool get isAtMaxQuantity => quantity >= maxStock;
  
  CartItemEntity copyWith({
    String? productId,
    String? productName,
    String? productImage,
    double? price,
    double? discountPrice,
    int? quantity,
    int? maxStock,
    DateTime? addedAt,
  }) {
    return CartItemEntity(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productImage: productImage ?? this.productImage,
      price: price ?? this.price,
      discountPrice: discountPrice ?? this.discountPrice,
      quantity: quantity ?? this.quantity,
      maxStock: maxStock ?? this.maxStock,
      addedAt: addedAt ?? this.addedAt,
    );
  }
  
  @override
  List<Object?> get props => [
        productId,
        productName,
        productImage,
        price,
        discountPrice,
        quantity,
        maxStock,
        addedAt,
      ];
}
