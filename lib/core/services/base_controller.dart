import 'package:bot_toast/bot_toast.dart';
import 'package:simple_e_commerce/core/data/models/api/product_model.dart';
import 'package:simple_e_commerce/core/data/repositories/product_repositories.dart';
import 'package:simple_e_commerce/core/enums/message_type.dart';
import 'package:simple_e_commerce/core/utils/general_util.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/enums/operation_type.dart';
import 'package:simple_e_commerce/core/enums/request_status.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_toast.dart';

import '../../ui/shared/utils.dart';

class BaseController extends GetxController {
  Rx<RequestStatus> requestStatus = RequestStatus.DEFUALT.obs;
  RxList<ProductModel> allProducts = <ProductModel>[].obs;
  var status = RequestStatus.DEFUALT.obs;

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
      await function;
      Future.delayed(Duration(microseconds: 500), () {
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

  @override
  void onInit() async {
    super.onInit();
    await getALlProducts();
  }
}
