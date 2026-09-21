import 'package:equatable/equatable.dart';
import 'package:nikita/features/cart/domain/entities/cart_item_entity.dart';

sealed class CartState extends Equatable {
  const CartState();
  
  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItemEntity> items;

  const CartLoaded({required this.items});

  double get subtotal => items.fold(0, (sum, item) => sum + item.itemTotal);
  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);
  bool get isEmpty => items.isEmpty;

  @override
  List<Object?> get props => [items];
}

class CartError extends CartState {
  final String message;

  const CartError({required this.message});

  @override
  List<Object?> get props => [message];
}

class CartOperationSuccess extends CartState {
  final String message;

  const CartOperationSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}
