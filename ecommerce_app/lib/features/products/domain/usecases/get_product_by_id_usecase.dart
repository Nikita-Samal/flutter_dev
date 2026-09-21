import 'package:nikita/features/products/domain/entities/product_entity.dart';
import 'package:nikita/features/products/domain/repositories/product_repository.dart';

class GetProductByIdUseCase {
  final ProductRepository repository;

  GetProductByIdUseCase(this.repository);

  Future<ProductEntity> call(String productId) {
    return repository.getProductById(productId);
  }
}
