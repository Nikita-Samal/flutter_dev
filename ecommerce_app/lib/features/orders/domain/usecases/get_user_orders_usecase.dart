import 'package:nikita/features/orders/domain/entities/order_entity.dart';
import 'package:nikita/features/orders/domain/repositories/order_repository.dart';

class GetUserOrdersUseCase {
  final OrderRepository repository;

  GetUserOrdersUseCase(this.repository);

  Future<List<OrderEntity>> call(String userId) {
    return repository.getUserOrders(userId);
  }
}
