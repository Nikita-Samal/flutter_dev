import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nikita/features/categories/data/models/category_model.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<CategoryModel> getCategoryById(String id);
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final FirebaseFirestore firestore;

  CategoryRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<CategoryModel>> getCategories() async {
    final snapshot = await firestore
        .collection('categories')
        .where('status', isEqualTo: 'active')
        .get();

    return snapshot.docs.map((doc) => CategoryModel.fromFirestore(doc)).toList();
  }

  @override
  Future<CategoryModel> getCategoryById(String id) async {
    final doc = await firestore.collection('categories').doc(id).get();
    if (!doc.exists) {
      throw Exception('Category not found');
    }
    return CategoryModel.fromFirestore(doc);
  }
}
