import 'package:nikita/core/errors/exceptions.dart';
import 'package:nikita/core/errors/failures.dart';
import 'package:nikita/features/products/data/datasources/product_remote_datasource.dart';
import 'package:nikita/features/products/domain/entities/product_entity.dart';
import 'package:nikita/features/products/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ProductEntity>> getProducts({String? categoryId, String? searchQuery, int? limit}) async {
    try {
      return await remoteDataSource.getProducts(
        categoryId: categoryId,
        searchQuery: searchQuery,
        limit: limit ?? 20,
      );
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<List<ProductEntity>> getFeaturedProducts({int limit = 10}) async {
    try {
      return await remoteDataSource.getFeaturedProducts(limit: limit);
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<List<ProductEntity>> getProductsByCategory(String categoryId, {int? limit}) async {
    try {
      return await remoteDataSource.getProductsByCategory(categoryId, limit: limit ?? 20);
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<ProductEntity> getProductById(String productId) async {
    try {
      return await remoteDataSource.getProductById(productId);
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<List<ProductEntity>> searchProducts(String query) async {
    try {
      return await remoteDataSource.searchProducts(query);
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Stream<List<ProductEntity>> watchFeaturedProducts() {
    return remoteDataSource.watchFeaturedProducts();
  }
}
