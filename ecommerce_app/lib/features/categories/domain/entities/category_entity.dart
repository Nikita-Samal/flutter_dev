import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String id;
  final String name;
  final String? imageUrl;
  final String? description;
  final int productCount;
  final String status;
  final DateTime createdAt;

  const CategoryEntity({
    required this.id,
    required this.name,
    this.imageUrl,
    this.description,
    required this.productCount,
    required this.status,
    required this.createdAt,
  });

  CategoryEntity copyWith({
    String? id,
    String? name,
    String? imageUrl,
    String? description,
    int? productCount,
    String? status,
    DateTime? createdAt,
  }) {
    return CategoryEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      productCount: productCount ?? this.productCount,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
        description,
        productCount,
        status,
        createdAt,
      ];
}
