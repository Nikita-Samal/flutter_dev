import 'package:nikita/features/products/domain/entities/product_entity.dart';
import 'package:nikita/features/products/domain/repositories/product_repository.dart';

class GetProductsUseCase {
  final ProductRepository repository;

  GetProductsUseCase(this.repository);

  Future<List<ProductEntity>> call({String? categoryId, String? searchQuery, int? limit}) {
    return repository.getProducts(categoryId: categoryId, searchQuery: searchQuery, limit: limit);
  }
}
