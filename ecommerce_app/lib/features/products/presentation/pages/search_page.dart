import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nikita/features/products/presentation/bloc/products_bloc.dart';
import 'package:nikita/features/products/presentation/bloc/products_event.dart';
import 'package:nikita/features/products/presentation/bloc/products_state.dart';
import 'package:nikita/features/products/presentation/widgets/product_list_item.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  final List<String> _recentSearches = [];

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty) {
        context.read<ProductsBloc>().add(ProductSearchRequested(query));
        if (!_recentSearches.contains(query)) {
          _recentSearches.add(query);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search products...',
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                setState(() {});
              },
            ),
          ),
          onChanged: _onSearchChanged,
        ),
      ),
      body: _searchController.text.isEmpty
          ? _buildRecentSearches()
          : BlocBuilder<ProductsBloc, ProductsState>(
              builder: (context, state) {
                if (state is ProductsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProductSearchLoaded) {
                  final products = state.products;
                  if (products.isEmpty) {
                    return const Center(child: Text('No products found.'));
                  }
                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return ProductListItem(
                        product: products[index],
                        onTap: () {
                          Navigator.pushNamed(context, '/product-detail', arguments: products[index].id);
                        },
                      );
                    },
                  );
                } else if (state is ProductsError) {
                  return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
                }
                return const SizedBox.shrink();
              },
            ),
    );
  }

  Widget _buildRecentSearches() {
    if (_recentSearches.isEmpty) {
      return const Center(child: Text('No recent searches', style: TextStyle(color: Colors.grey)));
    }
    return ListView.builder(
      itemCount: _recentSearches.length,
      itemBuilder: (context, index) {
        final query = _recentSearches[index];
        return ListTile(
          leading: const Icon(Icons.history),
          title: Text(query),
          onTap: () {
            _searchController.text = query;
            _onSearchChanged(query);
          },
        );
      },
    );
  }
}
