import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? discountPrice;
  final List<String> images;
  final String categoryId;
  final String categoryName;
  final int stock;
  final double rating;
  final int reviewCount;
  final String status; // 'active', 'outOfStock', 'archived'
  final bool isFeatured;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.discountPrice,
    required this.images,
    required this.categoryId,
    required this.categoryName,
    required this.stock,
    required this.rating,
    required this.reviewCount,
    required this.status,
    required this.isFeatured,
    required this.createdAt,
    required this.updatedAt,
  });
  
  bool get isOnSale => discountPrice != null && discountPrice! < price;
  bool get isInStock => stock > 0 && status == 'active';
  double get effectivePrice => discountPrice ?? price;
  double get discountPercent => isOnSale ? ((price - discountPrice!) / price * 100).roundToDouble() : 0;
  String get mainImage => images.isNotEmpty ? images.first : '';
  
  ProductEntity copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    double? discountPrice,
    List<String>? images,
    String? categoryId,
    String? categoryName,
    int? stock,
    double? rating,
    int? reviewCount,
    String? status,
    bool? isFeatured,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      discountPrice: discountPrice ?? this.discountPrice,
      images: images ?? this.images,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      stock: stock ?? this.stock,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      status: status ?? this.status,
      isFeatured: isFeatured ?? this.isFeatured,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
  
  @override
  List<Object?> get props => [
    id, name, description, price, discountPrice, images, 
    categoryId, categoryName, stock, rating, reviewCount, 
    status, isFeatured, createdAt, updatedAt
  ];
}
