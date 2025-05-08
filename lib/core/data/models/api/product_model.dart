import 'dart:convert';

class ProductModel {
  Rating? rating;
  String? title;
  String? description;
  double? price;
  int? stockQuantity;
  String? categoryId;
  List<String>? images;
  String? createdBy;
  String? id;
  String? createdAt;
  String? updatedAt;

  ProductModel({
    this.rating,
    this.title,
    this.description,
    this.price,
    this.stockQuantity,
    this.categoryId,
    this.images,
    this.createdBy,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;
    title = json['title'];
    description = json['description'];
    price = json['price']?.toDouble();
    stockQuantity = json['stockQuantity'];
    categoryId = json['categoryId'];
    images = json['images'] != null ? List<String>.from(json['images']) : [];
    createdBy = json['createdBy'];
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (rating != null) {
      data['rating'] = rating!.toJson();
    }
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['stockQuantity'] = stockQuantity;
    data['categoryId'] = categoryId;
    data['images'] = images;
    data['createdBy'] = createdBy;
    data['id'] = id;
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
      'createdBy': model.createdBy,
      'id': model.id,
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

class Rating {
  double? rate;
  int? count;

  Rating({this.rate, this.count});

  Rating.fromJson(Map<String, dynamic> json) {
    rate = json['rate']?.toDouble();
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rate'] = rate;
    data['count'] = count;
    return data;
  }

  static Map<String, dynamic> toMap(Rating model) {
    return {
      'rate': model.rate,
      'count': model.count,
    };
  }
}