import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/data/repositories/user_repositories.dart';
import 'package:simple_e_commerce/core/enums/message_type.dart';
import 'package:simple_e_commerce/core/services/base_controller.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_toast.dart';
import 'package:simple_e_commerce/ui/views/auth/forget_password_view/reset_password_view/reset_password_view.dart';
import 'package:simple_e_commerce/ui/views/auth/forget_password_view/verify_view/verify_view.dart';
import 'package:simple_e_commerce/ui/views/auth/login_view/login_view.dart';

class ForgePasswordController extends BaseController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController verifyCodeController = TextEditingController();

  Future<void> forget() async {
    await runFullLoadingFutureFunction(
      function: UserRepository().verifyEmail(email: emailController.text).then((
        value,
      ) {
        value.fold(
          (l) {
            CustomToast.showMessage(
              message: l,
              messageType: MessageType.REJECTED,
            );
          },
          (r) {
            CustomToast.showMessage(
              message: 'the code have been sent',
              messageType: MessageType.SUCCESS,
            );
            Get.to(() => VerifyForgetPassView());
          },
        );
      }),
    );
  }

  Future<void> sendCode() async {
    await runFullLoadingFutureFunction(
      function: UserRepository().sendCode(code: verifyCodeController.text).then(
        (value) {
          value.fold(
            (l) {
              CustomToast.showMessage(
                message: l,
                messageType: MessageType.REJECTED,
              );
            },
            (r) {
              CustomToast.showMessage(
                message: r,
                messageType: MessageType.SUCCESS,
              );
              Get.to(() => ResetPasswordView());
            },
          );
        },
      ),
    );
  }

  Future<void> resetPassword() async {
    await runFullLoadingFutureFunction(
      function: UserRepository()
          .resetPassword(
            newPassword: confirmPasswordController.text,
            email: emailController.text,
          )
          .then((value) {
            value.fold(
              (l) {
                CustomToast.showMessage(
                  message: l,
                  messageType: MessageType.REJECTED,
                );
              },
              (r) {
                CustomToast.showMessage(
                  message: r,
                  messageType: MessageType.SUCCESS,
                );
                emailController.clear();
                passwordController.clear();
                confirmPasswordController.clear();
                confirmPasswordController.clear();
                Get.off(() => LoginView());
              },
            );
          }),
    );
  }
}
