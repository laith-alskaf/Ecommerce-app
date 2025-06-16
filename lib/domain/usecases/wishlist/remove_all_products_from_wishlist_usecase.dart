import 'package:dartz/dartz.dart';
import 'package:simple_e_commerce/core/error/failure.dart';
import 'package:simple_e_commerce/core/usecases/usecase.dart';
import 'package:simple_e_commerce/domain/repositories/wishlist_repository.dart';

class RemoveAllProductsFromWishlistUseCase
    implements Usecase<String, NoParams> {
  final WishlistRepository repository;

  RemoveAllProductsFromWishlistUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(NoParams noParams) async {
    return await repository.removeAllProductsFromWishlist();
  }
}
