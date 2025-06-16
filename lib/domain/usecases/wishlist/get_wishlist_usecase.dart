import 'package:dartz/dartz.dart';
import 'package:simple_e_commerce/core/error/failure.dart';
import 'package:simple_e_commerce/core/usecases/usecase.dart';
import 'package:simple_e_commerce/domain/entities/product_entity.dart';
import 'package:simple_e_commerce/domain/repositories/wishlist_repository.dart';

class GetWishlistUseCase
    implements Usecase<({List<ProductEntity> wishlist}), NoParams> {
  final WishlistRepository repository;

  GetWishlistUseCase(this.repository);

  @override
  Future<Either<Failure, ({List<ProductEntity> wishlist})>> call(NoParams noParams) async {
    return await repository.getWishlist();
  }
}
