import 'package:equatable/equatable.dart';
import 'package:nikita/features/wishlist/domain/entities/wishlist_entity.dart';

sealed class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object?> get props => [];
}

class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final WishlistEntity wishlist;
  final List<String> productIds;

  const WishlistLoaded({required this.wishlist, required this.productIds});

  @override
  List<Object?> get props => [wishlist, productIds];
}

class WishlistError extends WishlistState {
  final String message;

  const WishlistError({required this.message});

  @override
  List<Object?> get props => [message];
}
