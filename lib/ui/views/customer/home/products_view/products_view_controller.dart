import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/data/models/api/product_model.dart';
import 'package:simple_e_commerce/core/data/repositories/product_repositories.dart';
import 'package:simple_e_commerce/core/enums/message_type.dart';
import 'package:simple_e_commerce/core/services/base_controller.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_toast.dart';

class ProductsViewController extends BaseController {
  final TextEditingController searchController = TextEditingController();
  RxList<ProductModel> filteredProducts = <ProductModel>[].obs;
  RxBool emptyProducts = false.obs;

  Future getProducts({required String title}) async {
    filteredProducts.clear();
    await runLoadingFutureFunction(
      function: ProductRepositories.searchProduct(title: title).then((value) {
        value.fold(
          (l) {
            emptyProducts.value = true;
            CustomToast.showMessage(
              message: l,
              messageType: MessageType.REJECTED,
            );
          },
          (r) {
            filteredProducts.addAll(r);
          },
        );
      }),
    );
  }

  @override
  void onInit() async {
    await getALlProducts().then((c) {
      filteredProducts = allProducts;
    });
    super.onInit();
  }
}
