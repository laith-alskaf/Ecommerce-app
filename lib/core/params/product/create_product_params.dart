import 'package:equatable/equatable.dart';

class CreateProductParams extends Equatable {
  final Map<String, dynamic> product;
  final List<String> images;

  const CreateProductParams({required this.product, required this.images});

  @override
  List<Object?> get props => [product, images];
}
