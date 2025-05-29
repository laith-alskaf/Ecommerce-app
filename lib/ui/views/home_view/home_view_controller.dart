import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/data/models/api/category_model.dart';
import 'package:simple_e_commerce/core/data/models/api/product_model.dart';
import 'package:simple_e_commerce/core/data/repositories/category_repositories.dart';
import 'package:simple_e_commerce/core/data/repositories/product_repositories.dart';
import 'package:simple_e_commerce/core/data/repositories/auth_repositories.dart';
import 'package:simple_e_commerce/core/enums/message_type.dart';
import 'package:simple_e_commerce/core/services/base_controller.dart';
import 'package:simple_e_commerce/ui/shared/colors.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_toast.dart';
import 'package:simple_e_commerce/ui/views/auth/login_view/login_view.dart';

class HomeViewController extends BaseController {
  Rx<Color> clickButton = AppColors.blueColor.obs;
  RxInt selectedNum = 0.obs;
  RxList<String> allCategoryName = <String>[].obs;
  RxList<CategoryModel> allCategory = <CategoryModel>[].obs;
  String selectCategory = '';
  int pageNumber = 1;

  filterProductByCat(int index, String nameCategory) {
    selectedNum.value = index;
    selectCategory = nameCategory;
    String idCat = '';
    for (var value in allCategory) {
      if (value.name == selectCategory) {
        idCat = value.id!;
      }
    }
    if (selectedNum.value == 0) {
      getALlProducts();
    } else {
      getProductsByCategory(categoryID: idCat);
    }
  }

  Future getALlCategory() async {
    allCategoryName.clear();
    allCategory.clear();
    await runLoadingFutureFunction(
      function: CategoryRepositories.allCategory().then((value) {
        value.fold(
          (l) {
            CustomToast.showMessage(
              message: l,
              messageType: MessageType.REJECTED,
            );
            update();
          },
          (r) {
            allCategoryName.add('All');
            for (var value in r) {
              allCategoryName.add(value.name!);
            }
            allCategory.addAll(r);
            update();
          },
        );
      }),
    );
  }

  @override
  Future logout() async {
    await runFullLoadingFutureFunction(
      function: UserRepository().logout().then((value) {
        value.fold(
          (l) {
            CustomToast.showMessage(
              message: l,
              messageType: MessageType.REJECTED,
            );
          },
          (r) {
            Get.off(() => LoginView());
          },
        );
      }),
    );
  }

  Future getProductsByCategory({required String categoryID}) async {
    selectedNum.value == 0 ? selectCategory = '' : null;
    allProducts.value = <ProductModel>[];
    await runLoadingFutureFunction(
      function: ProductRepositories.getProductsByCategory(
        categoryId: categoryID,
      ).then((value) {
        value.fold(
          (l) {
            CustomToast.showMessage(
              message: l,
              messageType: MessageType.REJECTED,
            );
            update();
          },
          (r) {
            print('22222222222222222222');
            print(r);
            allProducts.addAll(r);
            update();
          },
        );
      }),
    );
  }

  @override
  void onInit() async{
   await Future.wait({getALlCategory(), getALlProducts()});
    // TODO: implement onInit
    super.onInit();
  }
}
