import 'package:dartz/dartz.dart';
import 'package:simple_e_commerce/core/error/failure.dart';
import 'package:simple_e_commerce/core/usecases/usecase.dart';
import 'package:simple_e_commerce/domain/repositories/wishlist_repository.dart';

class AddProductToWishlistUseCase implements Usecase<String, String> {
  final WishlistRepository repository;

  AddProductToWishlistUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(String id) async {
    return await repository.addProductToWishlist(id: id);
  }
}
