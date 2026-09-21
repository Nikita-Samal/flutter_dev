import 'package:nikita/features/products/domain/entities/product_entity.dart';
import 'package:nikita/features/products/domain/repositories/product_repository.dart';

class SearchProductsUseCase {
  final ProductRepository repository;

  SearchProductsUseCase(this.repository);

  Future<List<ProductEntity>> call(String query) {
    return repository.searchProducts(query);
  }
}
