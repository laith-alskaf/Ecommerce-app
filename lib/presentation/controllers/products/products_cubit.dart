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
  // {
  //   scrollController.addListener(setupScrollListener);
  // };

  final ScrollController scrollController = ScrollController();
  int pageNumber = 3;
  bool isProductFavorite = false;
  final TextEditingController searchController = TextEditingController();
  List<ProductEntity> products = <ProductEntity>[];

  Future<void> fetchProducts() async {
    emit(ProductsLoading());
    final failureOrProducts = await getAllProductsUseCase.call(
      GetProductPaginationParams(limit: 10, page: pageNumber),
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
  // filterProductByCat(int index, String nameCategory) {
  //   selectedNum.value = index;
  //   selectCategory = nameCategory;
  //   String idCat = '';
  //   for (var value in allCategory) {
  //     if (value.name == selectCategory) {
  //       idCat = value.id!;
  //     }
  //   }
  //   if (selectedNum.value == 0) {
  //     getALlProducts();
  //   } else {
  //     getProductsByCategory(categoryID: idCat);
  //   }
  // }

  // Future getProductsByCategory({required String categoryID}) async {
  //   selectedNum.value == 0 ? selectCategory = '' : null;
  //   allProducts.value = <ProductModel>[];
  //   await runLoadingFutureFunction(
  //     function: () async {
  //       await ProductRepositories.getProductsByCategory(
  //         categoryId: categoryID,
  //       ).then((value) {
  //         value.fold(
  //               (l) {
  //             CustomToast.showMessage(
  //               message: l,
  //               messageType: MessageType.REJECTED,
  //             );
  //             update();
  //           },
  //               (r) {
  //             allProducts.addAll(r);
  //             update();
  //           },
  //         );
  //       });
  //     },
  //   );
  // }

  // void setupScrollListener() async {
  //   if (scrollController.position.pixels >=
  //       scrollController.position.maxScrollExtent * 0.9 &&
  //       hasMoreProducts &&
  //       !isLoadingMore.value) {
  //     isLoadingMore.value = true;
  //     await getALlProducts();
  //   }
  // }

  // toggleFavoriteStatus(ProductModel productDetails) async {
  //   await addProductToWishlist(id: productDetails.id!);
  //   isProductFavorite = true;
  // }
}
