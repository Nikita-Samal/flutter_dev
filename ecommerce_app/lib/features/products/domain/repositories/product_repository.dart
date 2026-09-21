import 'package:nikita/features/products/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> getProducts({String? categoryId, String? searchQuery, int? limit});
  Future<List<ProductEntity>> getFeaturedProducts({int limit = 10});
  Future<List<ProductEntity>> getProductsByCategory(String categoryId, {int? limit});
  Future<ProductEntity> getProductById(String productId);
  Future<List<ProductEntity>> searchProducts(String query);
  Stream<List<ProductEntity>> watchFeaturedProducts();
}
