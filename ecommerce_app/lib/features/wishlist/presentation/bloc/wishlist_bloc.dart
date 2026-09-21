import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nikita/features/wishlist/domain/usecases/toggle_wishlist_usecase.dart';
import 'package:nikita/features/wishlist/domain/usecases/watch_wishlist_usecase.dart';
import 'package:nikita/features/wishlist/presentation/bloc/wishlist_event.dart';
import 'package:nikita/features/wishlist/presentation/bloc/wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final WatchWishlistUseCase watchWishlistUseCase;
  final ToggleWishlistUseCase toggleWishlistUseCase;

  WishlistBloc({
    required this.watchWishlistUseCase,
    required this.toggleWishlistUseCase,
  }) : super(WishlistInitial()) {
    on<WatchWishlistRequested>(_onWatchWishlistRequested);
    on<ToggleWishlistRequested>(_onToggleWishlistRequested);
  }

  Future<void> _onWatchWishlistRequested(WatchWishlistRequested event, Emitter<WishlistState> emit) async {
    emit(WishlistLoading());
    await emit.forEach(
      watchWishlistUseCase(event.userId),
      onData: (wishlist) => WishlistLoaded(wishlist: wishlist, productIds: wishlist.productIds),
      onError: (error, stackTrace) => WishlistError(message: error.toString()),
    );
  }

  Future<void> _onToggleWishlistRequested(ToggleWishlistRequested event, Emitter<WishlistState> emit) async {
    try {
      await toggleWishlistUseCase(userId: event.userId, productId: event.productId);
    } catch (e) {
      emit(WishlistError(message: e.toString()));
    }
  }
}
