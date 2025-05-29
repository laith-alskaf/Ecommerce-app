import 'package:simple_e_commerce/core/enums/connectivity_status.dart';
import 'package:simple_e_commerce/core/services/base_controller.dart';
import 'package:simple_e_commerce/core/utils/general_util.dart';
import 'package:get/get.dart';

class MyAppController extends BaseController {
  ConnectivityStatus connectivityStatus = ConnectivityStatus.ONLINE;

  // RxInt numProdInCart = cartServices.getCartCount().obs;
  RxBool isOnline = false.obs;

  set setConnectivityStatus(ConnectivityStatus value) {
    connectivityStatus = value;
  }

  void listenForConnectivityStatus() {
    ("Connection From MyAppController First initial $connectivityStatus");
    connectivityService.connectivityStatusController.stream.listen((event) {
      setConnectivityStatus = event;
      ("Connection From MyAppController Changed To $event");
      myAppController.isOnline.value =
          connectivityStatus == ConnectivityStatus.ONLINE ? true : false;
      // if (isOffline) {
      //   BotToast.closeAllLoading();
      //   showNoConnectionMessage();
      // } else {
      //   BotToast.closeAllLoading();
      //   showConnectionMessage();
      // }
    });
  }

  @override
  void onInit() async {
    listenForConnectivityStatus();
    super.onInit();
  }
}
