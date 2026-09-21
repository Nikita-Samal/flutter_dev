import 'package:equatable/equatable.dart';

class WishlistEntity extends Equatable {
  final String userId;
  final List<String> productIds;
  final DateTime updatedAt;

  const WishlistEntity({
    required this.userId,
    required this.productIds,
    required this.updatedAt,
  });

  WishlistEntity copyWith({
    String? userId,
    List<String>? productIds,
    DateTime? updatedAt,
  }) {
    return WishlistEntity(
      userId: userId ?? this.userId,
      productIds: productIds ?? this.productIds,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [userId, productIds, updatedAt];
}
