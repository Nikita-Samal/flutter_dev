import 'package:nikita/features/products/domain/entities/product_entity.dart';
import 'package:nikita/features/products/domain/repositories/product_repository.dart';

class GetProductsByCategoryUseCase {
  final ProductRepository repository;

  GetProductsByCategoryUseCase(this.repository);

  Future<List<ProductEntity>> call(String categoryId, {int? limit}) {
    return repository.getProductsByCategory(categoryId, limit: limit);
  }
}
