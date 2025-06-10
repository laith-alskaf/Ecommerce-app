import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_e_commerce/core/data/models/api/product_model.dart';
import 'package:simple_e_commerce/core/usecases/usecase.dart';
import 'package:simple_e_commerce/domain/usecases/product/get_all_product_usecase.dart';
import 'package:simple_e_commerce/presentation/controllers/products/products_state.dart';

class ProductDetailsCubit extends Cubit<ProductsState> {
  final GetAllProductsUseCase getAllProductsUseCase;
  int countProduct = 0;
  bool isProductFavorite = false;

  ProductDetailsCubit({required this.getAllProductsUseCase})
    : super(ProductsInitial());

  Future<void> addProductToWishlist({required String idProduct}) async {
    emit(ProductsLoading());
    // final failureOrProducts = await getAllProductsUseCase.call(
    //   const NoParams(),
    // );
    // failureOrProducts.fold(
    //   (failure) => emit(ProductsError(message: failure.message)),
    //   (products) {
    //     if (products.isEmpty) {
    //       emit(
    //         const ProductsLoaded(products: []),
    //       ); // Still emit loaded but with empty list
    //     } else {
    //       emit(ProductsLoaded(products: products));
    //     }
    //   },
    // );
  }

}
