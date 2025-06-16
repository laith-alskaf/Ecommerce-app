import 'package:dartz/dartz.dart';
import 'package:simple_e_commerce/core/error/failure.dart';
import 'package:simple_e_commerce/domain/entities/product_entity.dart';

abstract class WishlistRepository {
  Future<Either<Failure, ({List<ProductEntity> wishlist})>> getWishlist();

  Future<Either<Failure, String>> addProductToWishlist({required String id});

  Future<Either<Failure, String>> removeProductFromWishlist({required String id});

  Future<Either<Failure, String>> removeAllProductsFromWishlist();
}
