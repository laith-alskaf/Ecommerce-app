import 'package:dartz/dartz.dart';
import 'package:simple_e_commerce/core/error/exceptions.dart';
import 'package:simple_e_commerce/core/error/failure.dart';
import 'package:simple_e_commerce/core/network/network_info.dart';
import 'package:simple_e_commerce/data/datasources/products/product_remote_datasource.dart';
import 'package:simple_e_commerce/domain/entities/product_entity.dart';
import 'package:simple_e_commerce/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  // final CategoryLocalDataSource localDataSource; // If you had local caching
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    // required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ({List<ProductEntity> products, int totalPage})>>
  getAllProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.getAllProducts();
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
}
