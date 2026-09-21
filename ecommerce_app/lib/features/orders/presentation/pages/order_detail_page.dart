import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nikita/common/enums/app_enums.dart';
import 'package:nikita/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:nikita/features/orders/presentation/bloc/orders_state.dart';
import 'package:nikita/features/orders/presentation/widgets/order_items_list.dart';
import 'package:nikita/features/orders/presentation/widgets/order_timeline.dart';

class OrderDetailPage extends StatelessWidget {
  final String orderNumber; // Used for initial appbar title if needed
  
  const OrderDetailPage({Key? key, required this.orderNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order #$orderNumber'),
      ),
      body: BlocBuilder<OrdersBloc, OrdersState>(
        builder: (context, state) {
          if (state is OrdersLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrdersError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is OrderDetailLoaded) {
            final order = state.order;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OrderTimeline(currentStatus: order.orderStatus),
                  const SizedBox(height: 24),
                  const Text('Items', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  OrderItemsList(items: order.items),
                  const SizedBox(height: 24),
                  const Text('Shipping Address', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(order.shippingAddress.formatted, style: const TextStyle(height: 1.5)),
                  ),
                  const SizedBox(height: 24),
                  const Text('Order Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _buildSummaryRow('Subtotal', order.subtotal),
                  _buildSummaryRow('Shipping', order.shipping),
                  _buildSummaryRow('Tax', order.tax),
                  const Divider(),
                  _buildSummaryRow('Total', order.total, isTotal: true),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Text('Payment Status: '),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: order.paymentStatus == PaymentStatus.paid ? Colors.green.shade50 : Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          order.paymentStatus == PaymentStatus.paid ? 'PAID' : 'PENDING',
                          style: TextStyle(
                            color: order.paymentStatus == PaymentStatus.paid ? Colors.green : Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.help_outline),
                      label: const Text('Need Help?'),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 16 : 14,
            ),
          ),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 16 : 14,
            ),
          ),
        ],
      ),
    );
  }
}
