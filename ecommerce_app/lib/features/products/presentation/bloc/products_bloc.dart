import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nikita/features/products/domain/usecases/get_featured_products_usecase.dart';
import 'package:nikita/features/products/domain/usecases/get_product_by_id_usecase.dart';
import 'package:nikita/features/products/domain/usecases/get_products_by_category_usecase.dart';
import 'package:nikita/features/products/domain/usecases/get_products_usecase.dart';
import 'package:nikita/features/products/domain/usecases/search_products_usecase.dart';
import 'package:nikita/features/products/presentation/bloc/products_event.dart';
import 'package:nikita/features/products/presentation/bloc/products_state.dart';
import 'package:nikita/core/errors/failures.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProductsUseCase getProductsUseCase;
  final GetFeaturedProductsUseCase getFeaturedProductsUseCase;
  final GetProductByIdUseCase getProductByIdUseCase;
  final GetProductsByCategoryUseCase getProductsByCategoryUseCase;
  final SearchProductsUseCase searchProductsUseCase;

  ProductsBloc({
    required this.getProductsUseCase,
    required this.getFeaturedProductsUseCase,
    required this.getProductByIdUseCase,
    required this.getProductsByCategoryUseCase,
    required this.searchProductsUseCase,
  }) : super(ProductsInitial()) {
    on<ProductsLoadRequested>(_onProductsLoadRequested);
    on<FeaturedProductsLoadRequested>(_onFeaturedProductsLoadRequested);
    on<ProductDetailRequested>(_onProductDetailRequested);
    on<ProductSearchRequested>(_onProductSearchRequested);
    on<CategoryProductsLoadRequested>(_onCategoryProductsLoadRequested);
  }

  Future<void> _onProductsLoadRequested(
      ProductsLoadRequested event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    try {
      final products = await getProductsUseCase(categoryId: event.categoryId);
      emit(ProductsLoaded(products: products));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }

  Future<void> _onFeaturedProductsLoadRequested(
      FeaturedProductsLoadRequested event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    try {
      final products = await getFeaturedProductsUseCase();
      emit(FeaturedProductsLoaded(products: products));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }

  Future<void> _onProductDetailRequested(
      ProductDetailRequested event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    try {
      final product = await getProductByIdUseCase(event.productId);
      emit(ProductDetailLoaded(product: product));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }

  Future<void> _onProductSearchRequested(
      ProductSearchRequested event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    try {
      final products = await searchProductsUseCase(event.query);
      emit(ProductSearchLoaded(products: products, query: event.query));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }

  Future<void> _onCategoryProductsLoadRequested(
      CategoryProductsLoadRequested event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    try {
      final products = await getProductsByCategoryUseCase(event.categoryId);
      emit(ProductsLoaded(products: products));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }
}
