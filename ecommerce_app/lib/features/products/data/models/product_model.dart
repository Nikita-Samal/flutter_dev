import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nikita/features/products/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    super.discountPrice,
    required super.images,
    required super.categoryId,
    required super.categoryName,
    required super.stock,
    required super.rating,
    required super.reviewCount,
    required super.status,
    required super.isFeatured,
    required super.createdAt,
    required super.updatedAt,
  });
  
  factory ProductModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final d = doc.data()!;
    return ProductModel(
      id: doc.id,
      name: d['name'] as String? ?? '',
      description: d['description'] as String? ?? '',
      price: (d['price'] as num?)?.toDouble() ?? 0.0,
      discountPrice: (d['discountPrice'] as num?)?.toDouble(),
      images: List<String>.from(d['images'] as List? ?? []),
      categoryId: d['categoryId'] as String? ?? '',
      categoryName: d['categoryName'] as String? ?? '',
      stock: d['stock'] as int? ?? 0,
      rating: (d['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: d['reviewCount'] as int? ?? 0,
      status: d['status'] as String? ?? 'active',
      isFeatured: d['isFeatured'] as bool? ?? false,
      createdAt: (d['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (d['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
  
  Map<String, dynamic> toFirestore() {
    return {
      'name': name, 
      'description': description, 
      'price': price,
      'discountPrice': discountPrice, 
      'images': images,
      'categoryId': categoryId, 
      'categoryName': categoryName,
      'stock': stock, 
      'rating': rating, 
      'reviewCount': reviewCount,
      'status': status, 
      'isFeatured': isFeatured,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }
}
