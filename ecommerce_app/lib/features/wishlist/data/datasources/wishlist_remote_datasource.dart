import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nikita/features/wishlist/data/models/wishlist_model.dart';

abstract class WishlistRemoteDataSource {
  Future<WishlistModel> getWishlist(String userId);
  Future<void> addToWishlist({required String userId, required String productId});
  Future<void> removeFromWishlist({required String userId, required String productId});
  Future<bool> isProductWishlisted({required String userId, required String productId});
  Stream<WishlistModel> watchWishlist(String userId);
}

class WishlistRemoteDataSourceImpl implements WishlistRemoteDataSource {
  final FirebaseFirestore firestore;

  WishlistRemoteDataSourceImpl({required this.firestore});

  @override
  Future<WishlistModel> getWishlist(String userId) async {
    try {
      final doc = await firestore.collection('wishlists').doc(userId).get();
      if (doc.exists && doc.data() != null) {
        return WishlistModel.fromFirestore(doc.data()!, userId);
      }
      return WishlistModel(userId: userId, productIds: const [], updatedAt: DateTime.now());
    } on FirebaseException catch (e) {
      throw Exception(e.message ?? 'Server Exception');
    } catch (e) {
      throw Exception('Server Exception');
    }
  }

  @override
  Future<void> addToWishlist({required String userId, required String productId}) async {
    try {
      final docRef = firestore.collection('wishlists').doc(userId);
      await docRef.set({
        'productIds': FieldValue.arrayUnion([productId]),
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } on FirebaseException catch (e) {
      throw Exception(e.message ?? 'Server Exception');
    } catch (e) {
      throw Exception('Server Exception');
    }
  }

  @override
  Future<void> removeFromWishlist({required String userId, required String productId}) async {
    try {
      final docRef = firestore.collection('wishlists').doc(userId);
      await docRef.update({
        'productIds': FieldValue.arrayRemove([productId]),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
      throw Exception(e.message ?? 'Server Exception');
    } catch (e) {
      throw Exception('Server Exception');
    }
  }

  @override
  Future<bool> isProductWishlisted({required String userId, required String productId}) async {
    try {
      final wishlist = await getWishlist(userId);
      return wishlist.productIds.contains(productId);
    } catch (e) {
      return false;
    }
  }

  @override
  Stream<WishlistModel> watchWishlist(String userId) {
    return firestore.collection('wishlists').doc(userId).snapshots().map((doc) {
      if (doc.exists && doc.data() != null) {
        return WishlistModel.fromFirestore(doc.data()!, userId);
      }
      return WishlistModel(userId: userId, productIds: const [], updatedAt: DateTime.now());
    });
  }
}
