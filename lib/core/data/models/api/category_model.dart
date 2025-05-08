import 'dart:convert';

class CategoryModel {
  String? name;
  String? description;
  String? createdBy;
  String? id;
  String? createdAt;
  String? updatedAt;

  CategoryModel({
    this.name,
    this.description,
    this.createdBy,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    createdBy = json['createdBy'];
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['createdBy'] = createdBy;
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  static Map<String, dynamic> toMap(CategoryModel model) {
    return {
      'name': model.name,
      'description': model.description,
      'createdBy': model.createdBy,
      'id': model.id,
      'createdAt': model.createdAt,
      'updatedAt': model.updatedAt,
    };
  }

  static String encode(List<CategoryModel> list) => json.encode(
    list
        .map<Map<String, dynamic>>((element) => CategoryModel.toMap(element))
        .toList(),
  );

  static List<CategoryModel> decode(String strList) =>
      (json.decode(strList) as List<dynamic>)
          .map<CategoryModel>((item) => CategoryModel.fromJson(item))
          .toList();
}