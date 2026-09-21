import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nikita/core/constants/firebase_constants.dart';
import 'package:nikita/core/errors/exceptions.dart';
import 'package:nikita/features/products/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts({String? categoryId, String? searchQuery, int limit = 20});
  Future<List<ProductModel>> getFeaturedProducts({int limit = 10});
  Future<List<ProductModel>> getProductsByCategory(String categoryId, {int limit = 20});
  Future<ProductModel> getProductById(String productId);
  Future<List<ProductModel>> searchProducts(String query);
  Stream<List<ProductModel>> watchFeaturedProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final FirebaseFirestore _firestore;
  const ProductRemoteDataSourceImpl({required FirebaseFirestore firestore}) : _firestore = firestore;
  
  CollectionReference<Map<String, dynamic>> get _products =>
    _firestore.collection(FirebaseConstants.productsCollection);

  @override
  Future<List<ProductModel>> getProducts({String? categoryId, String? searchQuery, int limit = 20}) async {
    try {
      Query<Map<String, dynamic>> query = _products;
      
      if (categoryId != null && categoryId.isNotEmpty) {
        query = query.where('categoryId', isEqualTo: categoryId);
      }
      
      query = query.limit(limit);
      
      final snapshot = await query.get();
      var products = snapshot.docs.map((doc) => ProductModel.fromFirestore(doc)).toList();
      
      if (searchQuery != null && searchQuery.isNotEmpty) {
        final searchLower = searchQuery.toLowerCase();
        products = products.where((p) => p.name.toLowerCase().contains(searchLower)).toList();
      }
      
      return products;
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Unknown Firebase error');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ProductModel>> getFeaturedProducts({int limit = 10}) async {
    try {
      final snapshot = await _products
          .where('isFeatured', isEqualTo: true)
          .limit(limit)
          .get();
      return snapshot.docs.map((doc) => ProductModel.fromFirestore(doc)).toList();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Unknown Firebase error');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(String categoryId, {int limit = 20}) async {
    try {
      final snapshot = await _products
          .where('categoryId', isEqualTo: categoryId)
          .limit(limit)
          .get();
      return snapshot.docs.map((doc) => ProductModel.fromFirestore(doc)).toList();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Unknown Firebase error');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ProductModel> getProductById(String productId) async {
    try {
      final doc = await _products.doc(productId).get();
      if (!doc.exists) {
        throw const ServerException('Product not found');
      }
      return ProductModel.fromFirestore(doc);
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Unknown Firebase error');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      final snapshot = await _products.get();
      final allProducts = snapshot.docs.map((doc) => ProductModel.fromFirestore(doc)).toList();
      final searchLower = query.toLowerCase();
      return allProducts.where((p) => p.name.toLowerCase().contains(searchLower)).toList();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Unknown Firebase error');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Stream<List<ProductModel>> watchFeaturedProducts() {
    return _products
        .where('isFeatured', isEqualTo: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => ProductModel.fromFirestore(doc)).toList());
  }
}
