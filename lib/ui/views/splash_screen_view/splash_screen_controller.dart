import 'package:get/get.dart';
import 'package:simple_e_commerce/core/utils/general_util.dart';
import 'package:simple_e_commerce/ui/views/auth/login_view/login_view.dart';
import 'package:simple_e_commerce/ui/views/customer/home/main_view.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 1)).then((value) {
      if (storage.getToken() == '') {
        Get.off(() => LoginView());
      } else {
        Get.off(() => MainView());
        // if (storage.getRole == "user") {
        //   Get.off(() => MainView(currentIndex: 2,));
        //
        // } else if (storage.getRole == "admin") {
        //   Get.off(() => AdminDashboardView());
        // } else {
        //   Get.off(() => LoginView());
        // }
      }
    });
    super.onInit();
  }
}
