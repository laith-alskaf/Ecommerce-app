import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/data/models/api/product_model.dart';
import 'package:simple_e_commerce/core/data/repositories/product_repositories.dart';
import 'package:simple_e_commerce/core/enums/message_type.dart';
import 'package:simple_e_commerce/core/services/base_controller.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_toast.dart';

class ProductsViewController extends BaseController {
  final TextEditingController searchController = TextEditingController();
  RxList<ProductModel> filteredProducts = <ProductModel>[].obs;

  Future searchProducts({required String title}) async {
    filteredProducts.clear();
    await runLoadingFutureFunction(
      function: () async {
        await ProductRepositories.searchProduct(title: title).then((value) {
          value.fold(
            (l) {
              CustomToast.showMessage(
                message: l,
                messageType: MessageType.REJECTED,
              );
              update();
            },
            (r) {
              filteredProducts.addAll(r);
              update();
            },
          );
        });
      },
    );
  }

  @override
  void onInit() async {
    filteredProducts = allProducts;
    update();
    super.onInit();
  }
}
