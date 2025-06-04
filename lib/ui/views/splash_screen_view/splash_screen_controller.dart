import 'package:get/get.dart';
import 'package:simple_e_commerce/core/utils/general_util.dart';
import 'package:simple_e_commerce/ui/views/admin/home_view_admin/home_view_admin.dart';
import 'package:simple_e_commerce/ui/views/auth/login_view/login_view.dart';
import 'package:simple_e_commerce/ui/views/customer/home/main_view.dart';

class SplashScreenController extends GetxController {
  Future initAppSplash() async {
    String role = myAppController.role;
    await Future.delayed(const Duration(seconds: 2)).then((value) {
      if (storage.getToken() == '' && role != "guest") {
        Get.off(() => LoginView());
      } else {
        if (role == "customer" || role == "guest") {
          Get.off(() => MainView());
        } else if (storage.getRole() == "admin" || role == "superAdmin") {
          Get.off(() => HomeViewAdmin());
        } else {
          Get.off(() => LoginView());
        }
      }
    });
    Get.delete<SplashScreenController>();
  }

  @override
  void onInit() async {
    await initAppSplash();
    super.onInit();
  }
}
