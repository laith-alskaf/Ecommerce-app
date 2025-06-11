import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_e_commerce/core/params/product/get_product_pagination_params.dart';
import 'package:simple_e_commerce/domain/entities/product_entity.dart';
import 'package:simple_e_commerce/domain/usecases/product/get_all_product_usecase.dart';
import 'package:simple_e_commerce/presentation/controllers/products/products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final GetAllProductsUseCase getAllProductsUseCase;

  ProductsCubit({required this.getAllProductsUseCase})
    : super(ProductsInitial());

  bool isProductFavorite = false;
  final TextEditingController searchController = TextEditingController();
  List<ProductEntity> filteredProducts = <ProductEntity>[];

  Future<void> fetchProducts() async {
    emit(ProductsLoading());
    final failureOrProducts = await getAllProductsUseCase.call(
      GetProductPaginationParams(limit: 10, page: 1),
    );
    failureOrProducts.fold(
      (failure) => emit(ProductsError(message: failure.message)),
      (result) {
        if (result.products.isEmpty) {
          emit(const ProductsLoaded(products: []));
        } else {
          emit(
            ProductsLoaded(
              products: result.products,
              totalPage: result.totalPage,
            ),
          );
        }
      },
    );
  }

  // toggleFavoriteStatus(ProductModel productDetails) async {
  //   await addProductToWishlist(id: productDetails.id!);
  //   isProductFavorite = true;
  // }
}
