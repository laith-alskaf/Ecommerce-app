import 'dart:convert';

import 'package:simple_e_commerce/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  final String? createdAt;
  final String? updatedAt;

  const ProductModel({
    required super.id,
    required super.categoryId,
    required super.images,
    required super.title,
    super.description,
    super.price,
    super.stockQuantity,
    super.rating,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    rating: json['rating'] != null ? RatingModel.fromJson(json['rating']) : null,
    title: json['title'],
    description: json['description'],
    price: json['price']?.toDouble(),
    stockQuantity: json['stockQuantity'],
    categoryId: json['categoryId'],
    images: json['images'] != null ? List<String>.from(json['images']) : [],
    id: json['_id'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (rating != null) {
      data['rating'] = RatingModel.toMap(data['rating']);
    }
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['stockQuantity'] = stockQuantity;
    data['categoryId'] = categoryId;
    data['images'] = images;
    data['_id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  static Map<String, dynamic> toMap(ProductModel model) {
    return {
      'rating': model.rating,
      'title': model.title,
      'description': model.description,
      'price': model.price,
      'stockQuantity': model.stockQuantity,
      'categoryId': model.categoryId,
      'images': model.images,
      '_id': model.id,
      'createdAt': model.createdAt,
      'updatedAt': model.updatedAt,
    };
  }

  static String encode(List<ProductModel> list) => json.encode(
    list
        .map<Map<String, dynamic>>((element) => ProductModel.toMap(element))
        .toList(),
  );

  static List<ProductModel> decode(String strList) =>
      (json.decode(strList) as List<dynamic>)
          .map<ProductModel>((item) => ProductModel.fromJson(item))
          .toList();
}



class RatingModel extends RatingEntity {
  const RatingModel({super.rate, super.count});

  factory RatingModel.fromJson(Map<String, dynamic> json) =>
      RatingModel(rate: json['rate']?.toDouble(), count: json['count']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rate'] = rate;
    data['count'] = count;
    return data;
  }

  static Map<String, dynamic> toMap(RatingModel model) {
    return {'rate': model.rate, 'count': model.count};
  }
}
