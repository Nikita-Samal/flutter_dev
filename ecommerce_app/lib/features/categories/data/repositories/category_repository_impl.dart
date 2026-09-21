import 'package:nikita/features/categories/data/datasources/category_remote_datasource.dart';
import 'package:nikita/features/categories/domain/entities/category_entity.dart';
import 'package:nikita/features/categories/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;

  CategoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<CategoryEntity>> getCategories() async {
    try {
      return await remoteDataSource.getCategories();
    } catch (e) {
      throw Exception('Failed to load categories: \$e');
    }
  }

  @override
  Future<CategoryEntity> getCategoryById(String id) async {
    try {
      return await remoteDataSource.getCategoryById(id);
    } catch (e) {
      throw Exception('Failed to load category: \$e');
    }
  }
}
