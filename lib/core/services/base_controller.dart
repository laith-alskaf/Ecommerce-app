import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:simple_e_commerce/core/data/models/api/product_model.dart';
import 'package:simple_e_commerce/core/data/repositories/product_repositories.dart';
import 'package:simple_e_commerce/core/data/repositories/auth_repositories.dart';
import 'package:simple_e_commerce/core/data/repositories/wishlist_repositories.dart';
import 'package:simple_e_commerce/core/enums/message_type.dart';
import 'package:simple_e_commerce/core/utils/general_util.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/enums/operation_type.dart';
import 'package:simple_e_commerce/core/enums/request_status.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_show_snackbar.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_toast.dart';
import 'package:simple_e_commerce/ui/views/auth/login_view/login_view.dart';
import 'package:simple_e_commerce/ui/views/customer/home/product_details_view/product_details_view.dart';

import '../../ui/shared/utils.dart';

class BaseController extends GetxController {
  Rx<RequestStatus> requestStatus = RequestStatus.DEFUALT.obs;
  RxList<ProductModel> allProducts = <ProductModel>[].obs;
  var status = RequestStatus.DEFUALT.obs;
  Rx<ProductModel?> productDetails = Rxn<ProductModel>();

  set setRequestStatus(RequestStatus value) {
    status.value = value;
  }

  Future getALlProducts({int? page, int? limit}) async {
    allProducts.clear();
    await runLoadingFutureFunction(
      function: ProductRepositories.getProducts(
        page: page ?? 1,
        limit: limit ?? 10,
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
      }),
    );
  }

  Future addProductToWishlist({required String id}) async {
    await runLoadingFutureFunction(
      function: WishlistRepositories.addProduct(id: id).then((value) {
        value.fold(
          (l) {
            CustomToast.showMessage(
              message: l,
              messageType: MessageType.REJECTED,
            );
            update();
          },
          (r) {
            showSnackBar(title: r);
          },
        );
      }),
    );
  }

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

  Future runLoadingFutureFunction({
    required Future function,
    OperationType? type = OperationType.NONE,
  }) async {
    checkConnection(() async {
      setRequestStatus = RequestStatus.LOADING;
      update();
      await function.then((x) {
        setRequestStatus = RequestStatus.DEFUALT;
      });
    });
  }

  // Future runFutuerFunction({required Future function}) async {
  //   checkConnection(() async {
  //     await function;
  //   });
  // }
  //
  // Future runLoadingFutureFunction({
  //   required Future function,
  //   OperationType? type = OperationType.NONE,
  // }) async {
  //   checkConnection(() async {
  //     setRequestStatus = RequestStatus.LOADING;
  //     setOperationType(type!.name.toString(), type);
  //     await function;
  //     setRequestStatus = RequestStatus.DEFUALT;
  //     setOperationType(type.name.toString(), OperationType.NONE);
  //   });
  // }

  Future runFullLoadingFutureFunction({required Future function}) async {
    checkConnection(() async {
      customLoader();

      await function;

      BotToast.closeAllLoading();
    });
  }
}
