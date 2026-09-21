import 'package:equatable/equatable.dart';
import 'package:nikita/features/cart/domain/entities/cart_item_entity.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class CartWatchRequested extends CartEvent {
  final String userId;

  const CartWatchRequested({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class CartItemAdded extends CartEvent {
  final String userId;
  final CartItemEntity item;

  const CartItemAdded({required this.userId, required this.item});

  @override
  List<Object?> get props => [userId, item];
}

class CartItemQuantityUpdated extends CartEvent {
  final String userId;
  final String productId;
  final int quantity;

  const CartItemQuantityUpdated({
    required this.userId,
    required this.productId,
    required this.quantity,
  });

  @override
  List<Object?> get props => [userId, productId, quantity];
}

class CartItemRemoved extends CartEvent {
  final String userId;
  final String productId;

  const CartItemRemoved({required this.userId, required this.productId});

  @override
  List<Object?> get props => [userId, productId];
}

class CartCleared extends CartEvent {
  final String userId;

  const CartCleared({required this.userId});

  @override
  List<Object?> get props => [userId];
}
