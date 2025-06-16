import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_e_commerce/core/usecases/usecase.dart';
import 'package:simple_e_commerce/domain/entities/product_entity.dart';
import 'package:simple_e_commerce/domain/usecases/wishlist/add_product_to_wishlist_usecase.dart';
import 'package:simple_e_commerce/domain/usecases/wishlist/get_wishlist_usecase.dart';
import 'package:simple_e_commerce/domain/usecases/wishlist/remove_all_products_from_wishlist_usecase.dart';
import 'package:simple_e_commerce/domain/usecases/wishlist/remove_product_from_wishlist_usecase.dart';
import 'package:simple_e_commerce/presentation/controllers/wishlist/wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final GetWishlistUseCase getWishlistUseCase;
  final RemoveAllProductsFromWishlistUseCase
  removeAllProductsFromWishlistUseCase;
  final RemoveProductFromWishlistUseCase removeProductFromWishlistUseCase;
  final AddProductToWishlistUseCase addProductToWishlistUseCase;

  WishlistCubit({
    required this.getWishlistUseCase,
    required this.removeAllProductsFromWishlistUseCase,
    required this.removeProductFromWishlistUseCase,
    required this.addProductToWishlistUseCase,
  }) : super(WishlistInitial()) {
    fetchWishlist();
  }

  final ScrollController scrollController = ScrollController();
  int pageNumber = 3;
  bool isProductFavorite = false;
  final TextEditingController searchController = TextEditingController();
  List<ProductEntity> products = <ProductEntity>[];

  Future<void> fetchWishlist() async {
    emit(WishlistLoading());
    final failureOrProducts = await getWishlistUseCase.call(NoParams());
    failureOrProducts.fold(
      (failure) => emit(WishlistError(message: failure.message)),
      (result) {
        if (result.wishlist.isEmpty) {
          emit(const WishlistLoaded(wishlistItems: []));
        } else {
          emit(WishlistLoaded(wishlistItems: result.wishlist));
        }
      },
    );
  }

  Future<void> addProduct({required ProductEntity product}) async {
    emit(AddProductLoading());
    final failureOrProducts = await addProductToWishlistUseCase.call(
      product.id,
    );
    failureOrProducts.fold(
      (failure) => emit(AddProductError(message: failure.message)),
      (result) {
        List<ProductEntity> wishlistProduct = [product];
        wishlistProduct.addAll(state.wishlistItems);
        emit(
          AddProductSuccess(wishlistItems: wishlistProduct, message: result),
        );
      },
    );
  }

  Future<void> removeProduct({required ProductEntity product}) async {
    emit(RemoveProductLoading());
    final failureOrProducts = await removeProductFromWishlistUseCase.call(
      product.id,
    );
    failureOrProducts.fold(
      (failure) => emit(RemoveProductError(message: failure.message)),
      (result) {
        List<ProductEntity> wishlistProduct = state.wishlistItems;
        wishlistProduct.removeWhere((prod) => prod.id == product.id);
        emit(
          RemoveProductSuccess(wishlistItems: wishlistProduct, message: result),
        );
      },
    );
  }

  Future<void> removeAllProducts() async {
    emit(RemoveAllProductsLoading());
    final failureOrProducts = await removeAllProductsFromWishlistUseCase.call(
      NoParams(),
    );
    failureOrProducts.fold(
      (failure) => emit(RemoveAllProductsError(message: failure.message)),
      (result) {
        emit(RemoveAllProductsSuccess(wishlistItems: [], message: result));
      },
    );
  }
}
