import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nikita/common/enums/app_enums.dart';
import 'package:nikita/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:nikita/features/orders/presentation/bloc/orders_state.dart';
import 'package:nikita/features/orders/presentation/widgets/order_card.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Active', 'Completed', 'Cancelled'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _filters.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final filter = _filters[index];
                final isSelected = filter == _selectedFilter;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    label: Text(filter),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedFilter = filter;
                      });
                    },
                    selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
                    checkmarkColor: Theme.of(context).primaryColor,
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<OrdersBloc, OrdersState>(
              builder: (context, state) {
                if (state is OrdersLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is OrdersError) {
                  return Center(child: Text('Error: ${state.message}'));
                } else if (state is OrdersLoaded) {
                  final filteredOrders = state.orders.where((order) {
                    if (_selectedFilter == 'All') return true;
                    if (_selectedFilter == 'Active') {
                      return order.orderStatus != OrderStatus.delivered &&
                             order.orderStatus != OrderStatus.cancelled;
                    }
                    if (_selectedFilter == 'Completed') {
                      return order.orderStatus == OrderStatus.delivered;
                    }
                    if (_selectedFilter == 'Cancelled') {
                      return order.orderStatus == OrderStatus.cancelled;
                    }
                    return true;
                  }).toList();

                  if (filteredOrders.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_bag_outlined, size: 64, color: Colors.grey.shade400),
                          const SizedBox(height: 16),
                          const Text('No orders yet', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Start Shopping'),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredOrders.length,
                    itemBuilder: (context, index) {
                      final order = filteredOrders[index];
                      return OrderCard(
                        order: order,
                        onTap: () {
                          // TODO: Navigate to detail page
                        },
                      );
                    },
                  );
                }
                return const Center(child: Text('No orders found.'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
