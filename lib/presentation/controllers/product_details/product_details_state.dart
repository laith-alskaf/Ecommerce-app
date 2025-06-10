import 'package:equatable/equatable.dart';
import 'package:simple_e_commerce/domain/entities/product_entity.dart';

abstract class ProductDetailsState extends Equatable {
  final bool isProductFavorite;

  const ProductDetailsState({this.isProductFavorite = false});

  @override
  List<Object?> get props => [isProductFavorite];
}

class ProductsInitial extends ProductDetailsState {}

class ProductsLoading extends ProductDetailsState {}

class ToggleFavoriteStatus extends ProductDetailsState {}

class ProductsLoaded extends ProductDetailsState {
  final List<ProductEntity> products;

  const ProductsLoaded({required this.products});

  @override
  List<Object?> get props => [products];
}

class ProductsError extends ProductDetailsState {
  final String message;

  const ProductsError({required this.message});

  @override
  List<Object?> get props => [message];
}
