import 'package:flutter/material.dart';
import 'package:simple_e_commerce/core/data/models/api/category_model.dart';
import 'package:simple_e_commerce/core/data/models/api/product_model.dart';
import 'package:simple_e_commerce/core/data/repositories/category_repositories.dart';
import 'package:simple_e_commerce/core/data/repositories/product_repositories.dart';
import 'package:simple_e_commerce/core/enums/message_type.dart';
import 'package:simple_e_commerce/core/services/base_controller.dart';
import 'package:simple_e_commerce/core/utils/colors.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_toast.dart';

class AllProductsViewController extends BaseController {
  Color clickButton = AppColors.blueColor;
  int selectedNum = 0;
  List<String> allCategoryName = <String>[];
  List<CategoryModel> allCategory = <CategoryModel>[];
  String selectCategory = '';
  int pageNumber = 1;

  filterProductByCat(int index, String nameCategory) {
    selectedNum = index;
    selectCategory = nameCategory;
    String idCat = '';
    for (var value in allCategory) {
      if (value.name == selectCategory) {
        idCat = value.id!;
      }
    }
    if (selectedNum == 0) {
      getALlProducts();
    } else {
      getProductsByCategory(categoryID: idCat);
    }
    update();
  }

  Future getALlCategory() async {
    allCategoryName.clear();
    allCategory.clear();
    await runLoadingFutureFunction(
      function: () async {
        await CategoryRepositories.allCategory().then((value) {
          value.fold(
            (l) {
              CustomToast.showMessage(
                message: l,
                messageType: MessageType.REJECTED,
              );
            },
            (r) async {
              await getALlProducts();
              allCategoryName.add('All');
              for (var value in r) {
                allCategoryName.add(value.name!);
              }
              allCategory.addAll(r);
              update();
            },
          );
        });
      },
    );
  }

  Future getProductsByCategory({required String categoryID}) async {
    selectedNum == 0 ? selectCategory = '' : null;
    allProducts.value = <ProductModel>[];
    await runLoadingFutureFunction(
      function: () async {
        await ProductRepositories.getProductsByCategory(
          categoryId: categoryID,
        ).then((value) {
          value.fold(
            (l) {
              CustomToast.showMessage(
                message: l,
                messageType: MessageType.REJECTED,
              );
            },
            (r) {
              allProducts.addAll(r);
              update();
            },
          );
        });
      },
    );
  }

  @override
  void onInit() async {
    super.onInit();
    await getALlCategory();
  }
}
