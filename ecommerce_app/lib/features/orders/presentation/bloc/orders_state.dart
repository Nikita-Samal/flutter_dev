import 'package:equatable/equatable.dart';
import 'package:nikita/features/orders/domain/entities/order_entity.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();
  
  @override
  List<Object?> get props => [];
}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersLoaded extends OrdersState {
  final List<OrderEntity> orders;

  const OrdersLoaded(this.orders);

  @override
  List<Object> get props => [orders];
}

class OrderDetailLoaded extends OrdersState {
  final OrderEntity order;

  const OrderDetailLoaded(this.order);

  @override
  List<Object> get props => [order];
}

class OrderCreateSuccess extends OrdersState {
  final OrderEntity order;

  const OrderCreateSuccess(this.order);

  @override
  List<Object> get props => [order];
}

class OrdersError extends OrdersState {
  final String message;

  const OrdersError(this.message);

  @override
  List<Object> get props => [message];
}
