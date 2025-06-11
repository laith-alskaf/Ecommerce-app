import 'package:dartz/dartz.dart';
import 'package:simple_e_commerce/core/error/failure.dart';
import 'package:simple_e_commerce/core/params/product/create_product_params.dart';
import 'package:simple_e_commerce/core/params/product/get_product_pagination_params.dart';
import 'package:simple_e_commerce/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, ({List<ProductEntity> products, int totalPage})>>
  getAllProducts(GetProductPaginationParams productPaginationParams);

  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory({
    required String categoryId,
  });

  Future<Either<Failure, List<ProductEntity>>> searchProduct(
    GetProductPaginationParams productPaginationParams,
  );

  Future<Either<Failure, List<ProductEntity>>> getProductsMine(
    GetProductPaginationParams productPaginationParams,
  );

  Future<Either<Failure, String>> createProduct({
    required CreateProductParams createProductParams,
  });

  Future<Either<Failure, String>> deleteProduct({required String productId});
}
