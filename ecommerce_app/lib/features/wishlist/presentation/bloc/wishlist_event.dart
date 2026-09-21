import 'package:equatable/equatable.dart';

sealed class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object?> get props => [];
}

class WatchWishlistRequested extends WishlistEvent {
  final String userId;

  const WatchWishlistRequested({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class ToggleWishlistRequested extends WishlistEvent {
  final String userId;
  final String productId;

  const ToggleWishlistRequested({required this.userId, required this.productId});

  @override
  List<Object?> get props => [userId, productId];
}
