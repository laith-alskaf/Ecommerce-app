import 'package:dartz/dartz.dart';
import 'package:simple_e_commerce/core/error/failure.dart';
import 'package:simple_e_commerce/core/params/product/create_product_params.dart';
import 'package:simple_e_commerce/core/params/product/get_product_pagination_params.dart';
import 'package:simple_e_commerce/core/usecases/usecase.dart';
import 'package:simple_e_commerce/domain/entities/product_entity.dart';
import 'package:simple_e_commerce/domain/repositories/product_repository.dart';

class SearchProductUseCase
    implements Usecase<List<ProductEntity>, GetProductPaginationParams> {
  final ProductRepository repository;

  SearchProductUseCase(this.repository);

  @override
  Future<Either<Failure, List<ProductEntity>>> call(
    GetProductPaginationParams getProductPaginationParams,
  ) async {
    return await repository.searchProduct(getProductPaginationParams);
  }
}
