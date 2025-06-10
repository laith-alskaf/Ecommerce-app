import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String id;
  final String name;
  final String? imageUrl;
  final String? description;

  const CategoryEntity({
    required this.id,
    required this.name,
    this.imageUrl,
    this.description,
  });

  @override
  List<Object?> get props => [id, name, imageUrl, description];
}
