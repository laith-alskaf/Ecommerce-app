import 'package:get/get.dart';
import 'package:simple_e_commerce/core/utils/general_util.dart';
import 'package:simple_e_commerce/ui/views/admin/home_view_admin/home_view_admin.dart';
import 'package:simple_e_commerce/ui/views/auth/login_view/login_view.dart';
import 'package:simple_e_commerce/ui/views/customer/home/main_view.dart';

class SplashScreenController extends GetxController {
  Future initAppSplash() async {
    await Future.delayed(const Duration(seconds: 1)).then((value) {
      if (storage.getToken() == '') {
        Get.off(() => LoginView());
      } else {
        if (storage.getRole() == "customer") {
          Get.off(() => MainView());
        } else if (storage.getRole() == "admin"||storage.getRole() == "superAdmin") {
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
