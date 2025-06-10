import 'package:simple_e_commerce/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  final String? createdBy;
  final String? modelCreatedAt;
  final String? modelUpdatedAt;

  const CategoryModel({
    required super.id,
    required super.name,
    super.description,
    super.imageUrl,
    this.createdBy,
    this.modelCreatedAt,
    this.modelUpdatedAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      imageUrl: json['image'] as String?,
      description: json['description'] as String?,
      createdBy: json['createdBy'] as String?,
      modelCreatedAt: json['createdAt'] as String?,
      modelUpdatedAt: json['updatedAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'image': imageUrl,
      'description': description,
      'createdBy': createdBy,
      'createdAt': modelCreatedAt,
      'updatedAt': modelUpdatedAt,
    };
  }
}
