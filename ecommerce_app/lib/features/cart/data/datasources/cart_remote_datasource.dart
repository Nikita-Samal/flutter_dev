import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nikita/features/cart/data/models/cart_item_model.dart';
import 'package:nikita/features/cart/domain/entities/cart_item_entity.dart';

abstract class CartRemoteDataSource {
  Future<List<CartItemModel>> getCartItems(String userId);
  Future<void> addToCart({required String userId, required CartItemModel item});
  Future<void> updateQuantity({required String userId, required String productId, required int quantity});
  Future<void> removeFromCart({required String userId, required String productId});
  Future<void> clearCart(String userId);
  Stream<List<CartItemModel>> watchCartItems(String userId);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final FirebaseFirestore firestore;

  CartRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<CartItemModel>> getCartItems(String userId) async {
    try {
      final snapshot = await firestore.collection('users').doc(userId).collection('cart').get();
      return snapshot.docs.map((doc) => CartItemModel.fromFirestore(doc.data())).toList();
    } on FirebaseException catch (e) {
      throw Exception(e.message ?? 'Server Exception');
    } catch (e) {
      throw Exception('Server Exception');
    }
  }

  @override
  Future<void> addToCart({required String userId, required CartItemModel item}) async {
    try {
      await firestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc(item.productId)
          .set(item.toFirestore());
    } on FirebaseException catch (e) {
      throw Exception(e.message ?? 'Server Exception');
    } catch (e) {
      throw Exception('Server Exception');
    }
  }

  @override
  Future<void> updateQuantity({required String userId, required String productId, required int quantity}) async {
    try {
      final docRef = firestore.collection('users').doc(userId).collection('cart').doc(productId);
      if (quantity <= 0) {
        await docRef.delete();
      } else {
        await docRef.update({'quantity': quantity});
      }
    } on FirebaseException catch (e) {
      throw Exception(e.message ?? 'Server Exception');
    } catch (e) {
      throw Exception('Server Exception');
    }
  }

  @override
  Future<void> removeFromCart({required String userId, required String productId}) async {
    try {
      await firestore.collection('users').doc(userId).collection('cart').doc(productId).delete();
    } on FirebaseException catch (e) {
      throw Exception(e.message ?? 'Server Exception');
    } catch (e) {
      throw Exception('Server Exception');
    }
  }

  @override
  Future<void> clearCart(String userId) async {
    try {
      final snapshot = await firestore.collection('users').doc(userId).collection('cart').get();
      final batch = firestore.batch();
      for (var doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    } on FirebaseException catch (e) {
      throw Exception(e.message ?? 'Server Exception');
    } catch (e) {
      throw Exception('Server Exception');
    }
  }

  @override
  Stream<List<CartItemModel>> watchCartItems(String userId) {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('cart')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => CartItemModel.fromFirestore(doc.data())).toList());
  }
}
