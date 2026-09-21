import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nikita/features/wishlist/domain/entities/wishlist_entity.dart';

class WishlistModel extends WishlistEntity {
  const WishlistModel({
    required super.userId,
    required super.productIds,
    required super.updatedAt,
  });

  factory WishlistModel.fromFirestore(Map<String, dynamic> data, String userId) {
    return WishlistModel(
      userId: userId,
      productIds: List<String>.from(data['productIds'] ?? []),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  factory WishlistModel.fromEntity(WishlistEntity entity) {
    return WishlistModel(
      userId: entity.userId,
      productIds: entity.productIds,
      updatedAt: entity.updatedAt,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'productIds': productIds,
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }
}
