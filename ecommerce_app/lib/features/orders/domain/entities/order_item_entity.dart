import 'package:equatable/equatable.dart';

class OrderItemEntity extends Equatable {
  final String productId;
  final String productName;
  final String productImage;
  final double price;
  final int quantity;
  final double itemTotal;
  
  const OrderItemEntity({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.price,
    required this.quantity,
    required this.itemTotal,
  });
  
  @override
  List<Object?> get props => [productId, productName, productImage, price, quantity, itemTotal];
}
