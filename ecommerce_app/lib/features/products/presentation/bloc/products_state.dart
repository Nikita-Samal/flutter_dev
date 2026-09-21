import 'package:equatable/equatable.dart';
import 'package:nikita/features/products/domain/entities/product_entity.dart';

sealed class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object?> get props => [];
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<ProductEntity> products;

  const ProductsLoaded({required this.products});

  @override
  List<Object?> get props => [products];
}

class FeaturedProductsLoaded extends ProductsState {
  final List<ProductEntity> products;

  const FeaturedProductsLoaded({required this.products});

  @override
  List<Object?> get props => [products];
}

class ProductDetailLoaded extends ProductsState {
  final ProductEntity product;

  const ProductDetailLoaded({required this.product});

  @override
  List<Object?> get props => [product];
}

class ProductsError extends ProductsState {
  final String message;

  const ProductsError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProductSearchLoaded extends ProductsState {
  final List<ProductEntity> products;
  final String query;

  const ProductSearchLoaded({required this.products, required this.query});

  @override
  List<Object?> get props => [products, query];
}
