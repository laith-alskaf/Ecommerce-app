import 'package:get/get.dart';
import 'package:simple_e_commerce/core/enums/connectivity_status.dart';
import 'package:simple_e_commerce/core/services/base_controller.dart';
import 'package:simple_e_commerce/core/utils/general_util.dart';

class MyAppController extends BaseController {
  late String role;
  ConnectivityStatus connectivityStatus = ConnectivityStatus.ONLINE;
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
    });
  }

  initAppRout() {
    role = storage.getRole();
  }

  @override
  void onInit() async {
    super.onInit();
    initAppRout();
    listenForConnectivityStatus();
  }
}
