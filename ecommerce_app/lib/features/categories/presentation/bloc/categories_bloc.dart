import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nikita/features/categories/domain/usecases/get_categories_usecase.dart';
import 'package:nikita/features/categories/presentation/bloc/categories_event.dart';
import 'package:nikita/features/categories/presentation/bloc/categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final GetCategoriesUseCase getCategoriesUseCase;

  CategoriesBloc({required this.getCategoriesUseCase}) : super(CategoriesInitial()) {
    on<CategoriesLoadRequested>(_onCategoriesLoadRequested);
  }

  Future<void> _onCategoriesLoadRequested(
    CategoriesLoadRequested event,
    Emitter<CategoriesState> emit,
  ) async {
    emit(CategoriesLoading());
    try {
      final categories = await getCategoriesUseCase();
      emit(CategoriesLoaded(categories: categories));
    } catch (e) {
      emit(CategoriesError(message: e.toString()));
    }
  }
}
