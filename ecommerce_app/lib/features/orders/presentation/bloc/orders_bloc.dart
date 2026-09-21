import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nikita/features/orders/domain/usecases/create_order_usecase.dart';
import 'package:nikita/features/orders/domain/usecases/get_order_by_id_usecase.dart';
import 'package:nikita/features/orders/domain/usecases/watch_user_orders_usecase.dart';
import 'package:nikita/features/orders/presentation/bloc/orders_event.dart';
import 'package:nikita/features/orders/presentation/bloc/orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final WatchUserOrdersUseCase watchUserOrders;
  final GetOrderByIdUseCase getOrderById;
  final CreateOrderUseCase createOrder;
  StreamSubscription? _ordersSubscription;

  OrdersBloc({
    required this.watchUserOrders,
    required this.getOrderById,
    required this.createOrder,
  }) : super(OrdersInitial()) {
    on<OrdersWatchRequested>(_onOrdersWatchRequested);
    on<OrderDetailRequested>(_onOrderDetailRequested);
    on<OrderCreateRequested>(_onOrderCreateRequested);
  }

  void _onOrdersWatchRequested(OrdersWatchRequested event, Emitter<OrdersState> emit) {
    emit(OrdersLoading());
    _ordersSubscription?.cancel();
    _ordersSubscription = watchUserOrders(event.userId).listen(
      (orders) {
        if (!isClosed) add(_OrdersUpdated(orders));
      },
      onError: (e) {
        if (!isClosed) add(_OrdersErrorEvent(e.toString()));
      },
    );
  }

  Future<void> _onOrderDetailRequested(OrderDetailRequested event, Emitter<OrdersState> emit) async {
    emit(OrdersLoading());
    try {
      final order = await getOrderById(event.orderId);
      emit(OrderDetailLoaded(order));
    } catch (e) {
      emit(OrdersError(e.toString()));
    }
  }

  Future<void> _onOrderCreateRequested(OrderCreateRequested event, Emitter<OrdersState> emit) async {
    emit(OrdersLoading());
    try {
      final order = await createOrder(
        CreateOrderParams(
          userId: event.userId,
          items: event.items,
          address: event.address,
          subtotal: event.subtotal,
          shipping: event.shipping,
          tax: event.tax,
          total: event.total,
        ),
      );
      emit(OrderCreateSuccess(order));
    } catch (e) {
      emit(OrdersError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _ordersSubscription?.cancel();
    return super.close();
  }
}

class _OrdersUpdated extends OrdersEvent {
  final List<dynamic> orders;
  const _OrdersUpdated(this.orders);
}

class _OrdersErrorEvent extends OrdersEvent {
  final String error;
  const _OrdersErrorEvent(this.error);
}
