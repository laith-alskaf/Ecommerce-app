import 'package:get/get.dart';
import 'package:simple_e_commerce/core/data/repositories/auth_repositories.dart';
import 'package:simple_e_commerce/core/enums/message_type.dart';
import 'package:simple_e_commerce/core/services/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:simple_e_commerce/core/utils/general_util.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_toast.dart';
import 'package:simple_e_commerce/ui/views/admin/home_view_admin/home_view_admin.dart';
import 'package:simple_e_commerce/ui/views/customer/home/main_view.dart';

class LoginViewController extends BaseController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showPass = false;

  Future<void> login() async {
    await runFullLoadingFutureFunction(
      function: UserRepository()
          .login(email: emailController.text, password: passwordController.text)
          .then((value) {
            value.fold(
              (l) {
                CustomToast.showMessage(
                  message: l,
                  messageType: MessageType.REJECTED,
                );
              },
              (r) async {
                CustomToast.showMessage(
                  message: r,
                  messageType: MessageType.SUCCESS,
                );
                if (storage.getRole() == "customer") {
                  await myAppController.subscribeToTopicNewProduct();
                  Get.off(() => MainView());
                } else if (storage.getRole() == "admin") {
                  Get.off(() => HomeViewAdmin());
                }
                Get.delete<LoginViewController>();
              },
            );
          }),
    );
  }
}
