import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_e_commerce/core/usecases/usecase.dart';
import 'package:simple_e_commerce/domain/usecases/category/get_all_categories_usecase.dart';
import 'package:simple_e_commerce/presentation/controllers/category/categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final GetAllCategoriesUsecase getAllCategoriesUsecase;

  CategoriesCubit({required this.getAllCategoriesUsecase}) : super(CategoriesInitial());

  Future<void> fetchCategories() async {
    emit(CategoriesLoading());
    final failureOrCategories = await getAllCategoriesUsecase.call(const NoParams()); // Use const NoParams()
    failureOrCategories.fold(
      (failure) => emit(CategoriesError(message: failure.message)),
      (categories) {
        if (categories.isEmpty) {
          emit(const CategoriesLoaded(categories: [])); // Still emit loaded but with empty list
        } else {
          emit(CategoriesLoaded(categories: categories));
        }
      },
    );
  }
}