import 'package:equatable/equatable.dart';
import 'package:simple_e_commerce/domain/entities/product_entity.dart';

abstract class ProductsState extends Equatable {
  final int totalPage;

  const ProductsState({this.totalPage = 1});

  @override
  List<Object?> get props => [totalPage];
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<ProductEntity> products;

  const ProductsLoaded({required this.products, super.totalPage});

  @override
  List<Object?> get props => [products];
}

class ProductsError extends ProductsState {
  final String message;

  const ProductsError({required this.message});

  @override
  List<Object?> get props => [message];
}
