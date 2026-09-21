import 'package:equatable/equatable.dart';

sealed class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

class ProductsLoadRequested extends ProductsEvent {
  final String? categoryId;

  const ProductsLoadRequested({this.categoryId});

  @override
  List<Object?> get props => [categoryId];
}

class FeaturedProductsLoadRequested extends ProductsEvent {}

class ProductDetailRequested extends ProductsEvent {
  final String productId;

  const ProductDetailRequested(this.productId);

  @override
  List<Object?> get props => [productId];
}

class ProductSearchRequested extends ProductsEvent {
  final String query;

  const ProductSearchRequested(this.query);

  @override
  List<Object?> get props => [query];
}

class CategoryProductsLoadRequested extends ProductsEvent {
  final String categoryId;

  const CategoryProductsLoadRequested(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}
