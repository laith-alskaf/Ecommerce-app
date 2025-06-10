import 'package:dartz/dartz.dart';
import 'package:simple_e_commerce/core/error/failure.dart';
import 'package:simple_e_commerce/core/usecases/usecase.dart';
import 'package:simple_e_commerce/domain/entities/category_entity.dart';
import 'package:simple_e_commerce/domain/repositories/category_repository.dart';

class GetAllCategoriesUsecase implements Usecase<List<CategoryEntity>, NoParams> {
  final CategoryRepository repository;

  GetAllCategoriesUsecase(this.repository);

  @override
  Future<Either<Failure, List<CategoryEntity>>> call(NoParams params) async {
    return await repository.getAllCategories();
  }
}