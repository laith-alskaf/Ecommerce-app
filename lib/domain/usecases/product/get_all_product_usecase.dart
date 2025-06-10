import 'package:dartz/dartz.dart';
import 'package:simple_e_commerce/core/error/failure.dart';
import 'package:simple_e_commerce/core/usecases/usecase.dart';
import 'package:simple_e_commerce/domain/entities/product_entity.dart';
import 'package:simple_e_commerce/domain/repositories/product_repository.dart';

class GetAllProductsUseCase
    implements
        Usecase<({List<ProductEntity> products, int totalPage}), NoParams> {
  final ProductRepository repository;

  GetAllProductsUseCase(this.repository);

  @override
  Future<Either<Failure, ({List<ProductEntity> products, int totalPage})>> call(
    NoParams params,
  ) async {
    return await repository.getAllProducts();
  }
}
