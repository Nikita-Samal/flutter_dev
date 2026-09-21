import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nikita/features/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:nikita/features/wishlist/presentation/bloc/wishlist_event.dart';
import 'package:nikita/features/wishlist/presentation/bloc/wishlist_state.dart';
import 'package:nikita/features/wishlist/presentation/widgets/wishlist_product_card.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  void initState() {
    super.initState();
    final uid = fb_auth.FirebaseAuth.instance.currentUser?.uid ?? '';
    context.read<WishlistBloc>().add(WatchWishlistRequested(userId: uid));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
      ),
      body: BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          if (state is WishlistLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WishlistError) {
            return Center(child: Text(state.message));
          } else if (state is WishlistLoaded) {
            if (state.productIds.isEmpty) {
              return const Center(
                child: Text('No saved items', style: TextStyle(fontSize: 18, color: Colors.grey)),
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: state.productIds.length,
              itemBuilder: (context, index) {
                final productId = state.productIds[index];
                return WishlistProductCard(
                  productId: productId,
                  onRemove: () {
                    context.read<WishlistBloc>().add(ToggleWishlistRequested(userId: fb_auth.FirebaseAuth.instance.currentUser?.uid ?? '', productId: productId));
                  },
                  onAddToCart: () {
                    // Integration with CartBloc can happen here
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Added to cart')),
                    );
                  },
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
