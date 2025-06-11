import 'package:dartz/dartz.dart';
import 'package:simple_e_commerce/core/error/failure.dart';
import 'package:simple_e_commerce/core/params/product/get_product_pagination_params.dart';
import 'package:simple_e_commerce/core/usecases/usecase.dart';
import 'package:simple_e_commerce/domain/entities/product_entity.dart';
import 'package:simple_e_commerce/domain/repositories/product_repository.dart';

class GetAllProductsUseCase
    implements
        Usecase<
          ({List<ProductEntity> products, int totalPage}),
          GetProductPaginationParams
        > {
  final ProductRepository repository;

  GetAllProductsUseCase(this.repository);

  @override
  Future<Either<Failure, ({List<ProductEntity> products, int totalPage})>> call(
    GetProductPaginationParams params,
  ) async {
    return await repository.getAllProducts(
      GetProductPaginationParams(page: params.page, limit: params.limit),
    );
  }
}
