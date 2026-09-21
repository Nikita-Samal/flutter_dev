import 'package:nikita/features/orders/domain/entities/order_entity.dart';
import 'package:nikita/features/orders/domain/repositories/order_repository.dart';

class WatchUserOrdersUseCase {
  final OrderRepository repository;

  WatchUserOrdersUseCase(this.repository);

  Stream<List<OrderEntity>> call(String userId) {
    return repository.watchUserOrders(userId);
  }
}
