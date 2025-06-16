import 'package:dartz/dartz.dart';
import 'package:simple_e_commerce/core/error/exceptions.dart';
import 'package:simple_e_commerce/core/error/failure.dart';
import 'package:simple_e_commerce/core/network/network_info.dart';
import 'package:simple_e_commerce/data/datasources/wishlist/wishlist_remote_datasource.dart';
import 'package:simple_e_commerce/domain/entities/product_entity.dart';
import 'package:simple_e_commerce/domain/repositories/wishlist_repository.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistRemoteDataSource remoteDataSource;

  final NetworkInfo networkInfo;

  WishlistRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ({List<ProductEntity> wishlist})>>
  getWishlist() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.getWishlist();
        return Right((wishlist: remoteProducts.wishlist));
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
  Future<Either<Failure, String>> addProductToWishlist({
    required String id,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.addProductToWishlist(
          id: id,
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
  Future<Either<Failure, String>> removeProductFromWishlist({
    required String id,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.removeProductFromWishlist(
          id: id,
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
  Future<Either<Failure, String>> removeAllProductsFromWishlist() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts =
            await remoteDataSource.removeAllProductsFromWishlist();
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
