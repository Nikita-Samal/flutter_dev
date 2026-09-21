import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nikita/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:nikita/features/cart/presentation/bloc/cart_event.dart';
import 'package:nikita/features/cart/presentation/bloc/cart_state.dart';
import 'package:nikita/features/cart/presentation/widgets/cart_item_widget.dart';
import 'package:nikita/features/cart/presentation/widgets/cart_summary_card.dart';
import 'package:nikita/features/cart/presentation/widgets/empty_cart.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String get _uid => fb_auth.FirebaseAuth.instance.currentUser?.uid ?? '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<CartBloc>().add(CartWatchRequested(userId: _uid));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        actions: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoaded && !state.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Text('${state.totalItems} items'),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartError) {
            return Center(child: Text(state.message));
          } else if (state is CartLoaded) {
            if (state.isEmpty) {
              return EmptyCart(
                onStartShopping: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              );
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      final item = state.items[index];
                      return CartItemWidget(
                        item: item,
                        onRemove: () {
                          context.read<CartBloc>().add(
                            CartItemRemoved(userId: _uid, productId: item.productId),
                          );
                        },
                        onIncrement: () {
                          if (!item.isAtMaxQuantity) {
                            context.read<CartBloc>().add(
                              CartItemQuantityUpdated(
                                userId: _uid,
                                productId: item.productId,
                                quantity: item.quantity + 1,
                              ),
                            );
                          }
                        },
                        onDecrement: () {
                          context.read<CartBloc>().add(
                            CartItemQuantityUpdated(
                              userId: _uid,
                              productId: item.productId,
                              quantity: item.quantity - 1,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                CartSummaryCard(
                  subtotal: state.subtotal,
                  onCheckout: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Checkout coming soon!')),
                    );
                  },
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
