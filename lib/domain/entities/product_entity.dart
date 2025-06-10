import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String id;
  final String title;
  final List<String> images;
  final String categoryId;
  final RatingEntity? rating;
  final String? description;
  final double? price;
  final int? stockQuantity;

  const ProductEntity({
    this.rating,
    this.description,
    this.price,
    this.stockQuantity,
    required this.id,
    required this.title,
    required this.categoryId,
    required this.images,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    images,
    description,
    categoryId,
    price,
    rating,
    stockQuantity,
  ];
}

class RatingEntity extends Equatable {
  final double? rate;
  final int? count;

  const RatingEntity({this.rate, this.count});
  @override
  List<Object?> get props => [rate, count];
}
