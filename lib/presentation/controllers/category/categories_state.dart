import 'package:equatable/equatable.dart';
import 'package:simple_e_commerce/domain/entities/category_entity.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();
  @override
  List<Object?> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final List<CategoryEntity> categories;
  const CategoriesLoaded({required this.categories});
  @override
  List<Object?> get props => [categories];
}

class CategoriesError extends CategoriesState {
  final String message;
  const CategoriesError({required this.message});
  @override
  List<Object?> get props => [message];
}