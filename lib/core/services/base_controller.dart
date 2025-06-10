import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/data/models/api/product_model.dart';
import 'package:simple_e_commerce/core/data/repositories/auth_repositories.dart';
import 'package:simple_e_commerce/core/data/repositories/product_repositories.dart';
import 'package:simple_e_commerce/core/data/repositories/wishlist_repositories.dart';
import 'package:simple_e_commerce/core/enums/message_type.dart';
import 'package:simple_e_commerce/core/enums/operation_type.dart';
import 'package:simple_e_commerce/core/enums/request_status.dart';
import 'package:simple_e_commerce/core/utils/general_util.dart';
import 'package:simple_e_commerce/presentation/views/auth/login_view/login_view.dart';
import 'package:simple_e_commerce/presentation/views/auth/sign_up_view/sign_up_main.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_show_snackbar.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_toast.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/show_Login_Required_Dialog.dart';
import 'package:simple_e_commerce/ui/shared/utils.dart';


class BaseController extends GetxController {
  Rx<RequestStatus> requestStatus = RequestStatus.DEFUALT.obs;
  RxList<ProductModel> allProducts = <ProductModel>[].obs;
  var status = RequestStatus.DEFUALT.obs;
  Rx<ProductModel?> productDetails = Rxn<ProductModel>();

  int currentPage = 1;
  final int pageSize = 10;
  bool hasMoreProducts = true;
  RxBool isLoadingMore = false.obs;

  set setRequestStatus(RequestStatus value) {
    status.value = value;
  }

  Future getALlProducts({int? page, int? limit}) async {
    allProducts.clear();
    await runLoadingFutureFunction(
      function: () async {
        await ProductRepositories.getProducts(
          page: page ?? currentPage,
          limit: limit ?? pageSize,
        ).then((value) {
          value.fold(
            (l) {
              CustomToast.showMessage(
                message: l,
                messageType: MessageType.REJECTED,
              );
            },
            (r) {
              allProducts.addAll(r.products);

              if (r.totalPages <= currentPage) {
                hasMoreProducts = false;
                currentPage=0;
              } else {
                currentPage++;
                hasMoreProducts = true;
              }
            },
          );
          update();
        });
      },
    );
    isLoadingMore.value = false;
  }

  Future addProductToWishlist({required String id}) async {
    await runLoadingFutureFunction(
      loginRequired: true,
      function: () async {
        await WishlistRepositories.addProduct(id: id).then((value) {
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
        });
      },
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
            storage.clearPreference();
            Get.off(() => LoginView());
          },
        );
      }),
    );
  }

  bool hasPermissionToUse() {
    String role = myAppController.role;
    if (role == 'guest') {
      // showLoginRequiredDialog(
      //   message:
      //       "To use this feature and access all app services, please log in or create a new account.",
      //   onLoginPressed: () {
      //     Get.back();
      //     storage.clearPreference();
      //     Get.offAll(() => LoginView());
      //   },
      //   onSignUpPressed: () {
      //     Get.back();
      //     storage.clearPreference();
      //     Get.offAll(() => SignUpMain());
      //   },
      // );
      return false;
    } else {
      return true;
    }
  }

  Future runLoadingFutureFunction({
    Future<void> Function()? function,
    OperationType? type = OperationType.NONE,
    bool loginRequired = false,
  }) async {
    if (loginRequired && hasPermissionToUse() != true) {
      return;
    }
    checkConnection(() async {
      setRequestStatus = RequestStatus.LOADING;
      update();
      // await operation();
      await function!().then((x) {
        setRequestStatus = RequestStatus.DEFUALT;
      });
      setRequestStatus = RequestStatus.DEFUALT;
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
