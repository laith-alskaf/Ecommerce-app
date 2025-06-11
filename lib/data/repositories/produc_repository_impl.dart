import 'package:dartz/dartz.dart';
import 'package:simple_e_commerce/core/error/exceptions.dart';
import 'package:simple_e_commerce/core/error/failure.dart';
import 'package:simple_e_commerce/core/network/network_info.dart';
import 'package:simple_e_commerce/core/params/product/create_product_params.dart';
import 'package:simple_e_commerce/core/params/product/get_product_pagination_params.dart';
import 'package:simple_e_commerce/data/datasources/products/product_remote_datasource.dart';
import 'package:simple_e_commerce/domain/entities/product_entity.dart';
import 'package:simple_e_commerce/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ({List<ProductEntity> products, int totalPage})>>
  getAllProducts(GetProductPaginationParams productPaginationParams) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.getAllProducts(
          productPaginationParams,
        );
        return Right((
          products: remoteProducts.products,
          totalPage: remoteProducts.totalPages,
        ));
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message ?? 'Server Error'));
      } on NetworkException catch (e) {
        return Left(OfflineFailure(message: e.message ?? 'Network Error'));
      }
    } else {
      return Left(OfflineFailure(message: "No internet connection."));
    }
  }

  @override
  Future<Either<Failure, String>> createProduct({
    required CreateProductParams createProductParams,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.createProduct(
          createProductParams: createProductParams,
        );
        return Right(remoteProducts);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message ?? 'Server Error'));
      } on NetworkException catch (e) {
        return Left(OfflineFailure(message: e.message ?? 'Network Error'));
      }
    } else {
      return Left(OfflineFailure(message: "No internet connection."));
    }
  }

  @override
  Future<Either<Failure, String>> deleteProduct({
    required String productId,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.deleteProduct(
          productId: productId,
        );
        return Right(remoteProducts);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message ?? 'Server Error'));
      } on NetworkException catch (e) {
        return Left(OfflineFailure(message: e.message ?? 'Network Error'));
      }
    } else {
      return Left(OfflineFailure(message: "No internet connection."));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory({
    required String categoryId,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.getProductsByCategory(
          categoryId: categoryId,
        );
        return Right(remoteProducts);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message ?? 'Server Error'));
      } on NetworkException catch (e) {
        return Left(OfflineFailure(message: e.message ?? 'Network Error'));
      }
    } else {
      return Left(OfflineFailure(message: "No internet connection."));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsMine(
    GetProductPaginationParams productPaginationParams,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.getProductsMine(
          productPaginationParams,
        );
        return Right(remoteProducts);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message ?? 'Server Error'));
      } on NetworkException catch (e) {
        return Left(OfflineFailure(message: e.message ?? 'Network Error'));
      }
    } else {
      return Left(OfflineFailure(message: "No internet connection."));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> searchProduct(
    GetProductPaginationParams productPaginationParams,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.searchProduct(
          productPaginationParams,
        );
        return Right(remoteProducts);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message ?? 'Server Error'));
      } on NetworkException catch (e) {
        return Left(OfflineFailure(message: e.message ?? 'Network Error'));
      }
    } else {
      return Left(OfflineFailure(message: "No internet connection."));
    }
  }
}
