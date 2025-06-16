import 'package:dartz/dartz.dart';
import 'package:simple_e_commerce/core/error/failure.dart';
import 'package:simple_e_commerce/core/usecases/usecase.dart';
import 'package:simple_e_commerce/domain/repositories/wishlist_repository.dart';

class RemoveProductFromWishlistUseCase implements Usecase<String, String> {
  final WishlistRepository repository;

  RemoveProductFromWishlistUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(String id) async {
    return await repository.removeProductFromWishlist(id: id);
  }
}
