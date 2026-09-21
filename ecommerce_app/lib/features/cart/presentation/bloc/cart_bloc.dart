import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nikita/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:nikita/features/cart/domain/usecases/clear_cart_usecase.dart';
import 'package:nikita/features/cart/domain/usecases/get_cart_usecase.dart';
import 'package:nikita/features/cart/domain/usecases/remove_from_cart_usecase.dart';
import 'package:nikita/features/cart/domain/usecases/update_cart_quantity_usecase.dart';
import 'package:nikita/features/cart/presentation/bloc/cart_event.dart';
import 'package:nikita/features/cart/presentation/bloc/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartUseCase getCartUseCase;
  final AddToCartUseCase addToCartUseCase;
  final UpdateCartQuantityUseCase updateCartQuantityUseCase;
  final RemoveFromCartUseCase removeFromCartUseCase;
  final ClearCartUseCase clearCartUseCase;

  CartBloc({
    required this.getCartUseCase,
    required this.addToCartUseCase,
    required this.updateCartQuantityUseCase,
    required this.removeFromCartUseCase,
    required this.clearCartUseCase,
  }) : super(CartInitial()) {
    on<CartWatchRequested>(_onCartWatchRequested);
    on<CartItemAdded>(_onCartItemAdded);
    on<CartItemQuantityUpdated>(_onCartItemQuantityUpdated);
    on<CartItemRemoved>(_onCartItemRemoved);
    on<CartCleared>(_onCartCleared);
  }

  Future<void> _onCartWatchRequested(CartWatchRequested event, Emitter<CartState> emit) async {
    emit(CartLoading());
    await emit.forEach(
      getCartUseCase(event.userId),
      onData: (items) => CartLoaded(items: items),
      onError: (error, stackTrace) => CartError(message: error.toString()),
    );
  }

  Future<void> _onCartItemAdded(CartItemAdded event, Emitter<CartState> emit) async {
    try {
      await addToCartUseCase(userId: event.userId, item: event.item);
      // We don't emit success here directly as the stream will update, but we could emit an operation success
      // However, typical setup uses a side-effect listener or just rely on stream
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  Future<void> _onCartItemQuantityUpdated(CartItemQuantityUpdated event, Emitter<CartState> emit) async {
    try {
      await updateCartQuantityUseCase(
        userId: event.userId,
        productId: event.productId,
        quantity: event.quantity,
      );
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  Future<void> _onCartItemRemoved(CartItemRemoved event, Emitter<CartState> emit) async {
    try {
      await removeFromCartUseCase(userId: event.userId, productId: event.productId);
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  Future<void> _onCartCleared(CartCleared event, Emitter<CartState> emit) async {
    try {
      await clearCartUseCase(event.userId);
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }
}
