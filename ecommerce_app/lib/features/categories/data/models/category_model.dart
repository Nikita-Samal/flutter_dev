import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nikita/features/categories/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.name,
    super.imageUrl,
    super.description,
    required super.productCount,
    required super.status,
    required super.createdAt,
  });

  factory CategoryModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    
    return CategoryModel(
      id: doc.id,
      name: data['name'] as String? ?? 'Unknown',
      imageUrl: data['imageUrl'] as String?,
      description: data['description'] as String?,
      productCount: data['productCount'] as int? ?? 0,
      status: data['status'] as String? ?? 'active',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'description': description,
      'productCount': productCount,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
