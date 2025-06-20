import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/data/models/api/category_model.dart';
import 'package:simple_e_commerce/core/data/repositories/auth_repositories.dart';
import 'package:simple_e_commerce/core/data/repositories/category_repositories.dart';
import 'package:simple_e_commerce/core/data/repositories/product_repositories.dart';
import 'package:simple_e_commerce/core/enums/message_type.dart';
import 'package:simple_e_commerce/core/services/base_controller.dart';
import 'package:simple_e_commerce/core/utils/colors.dart';
import 'package:simple_e_commerce/domain/entities/product_entity.dart';
import 'package:simple_e_commerce/presentation/views/auth/login_view/login_view.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_toast.dart';

class HomeViewController extends BaseController {
  Rx<Color> clickButton = AppColors.mainColor.obs;
  RxInt selectedNum = 0.obs;
  RxList<String> allCategoryName = <String>[].obs;
  RxList<CategoryModel> allCategory = <CategoryModel>[].obs;
  String selectCategory = '';
  final ScrollController scrollController = ScrollController();
  RxInt selectedNumProductType = 0.obs;

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

  void setupScrollListener() async {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent * 0.9 &&
        hasMoreProducts &&
        !isLoadingMore.value) {
      isLoadingMore.value = true;
      await getALlProducts();
    }
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
            (r) {
              allCategoryName.add('All');
              for (var value in r) {
                allCategoryName.add(value.name!);
              }
              allCategory.addAll(r);
            },
          );
          update();
        });
      },
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
    allProducts.value = <ProductEntity>[];
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
              update();
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
    scrollController.addListener(setupScrollListener);
    await Future.wait({getALlCategory(), getALlProducts()});
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
