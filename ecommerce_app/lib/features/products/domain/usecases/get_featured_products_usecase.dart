import 'package:nikita/features/products/domain/entities/product_entity.dart';
import 'package:nikita/features/products/domain/repositories/product_repository.dart';

class GetFeaturedProductsUseCase {
  final ProductRepository repository;

  GetFeaturedProductsUseCase(this.repository);

  Future<List<ProductEntity>> call({int limit = 10}) {
    return repository.getFeaturedProducts(limit: limit);
  }
}
