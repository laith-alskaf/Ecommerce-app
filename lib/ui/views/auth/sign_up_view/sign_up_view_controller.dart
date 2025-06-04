import 'package:simple_e_commerce/core/data/repositories/auth_repositories.dart';
import 'package:simple_e_commerce/core/enums/message_type.dart';
import 'package:simple_e_commerce/core/services/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_toast.dart';
import 'package:simple_e_commerce/ui/views/auth/login_view/login_view.dart';

class SignUpViewController extends BaseController {
  String selectedRole = 'customer';
  RxInt currentIndex = 0.obs;
  List<String> imageSignUp = ['verfiy', 'emailcheck', 'right'];
  bool showPass = false;
  bool showPassConfirm = false;
  late String email;
  List<bool> expandedContainer = [false, false];
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController verifyCodeController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyAddressController = TextEditingController();
  TextEditingController companyDescriptionController = TextEditingController();

  Future<void> register() async {
    await runFullLoadingFutureFunction(
      function: UserRepository()
          .register(
            email: emailController.text,
            password: passwordController.text,
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            role: selectedRole,
          )
          .then((value) {
            value.fold(
              (l) {
                Get.back();
                CustomToast.showMessage(
                  message: l,
                  messageType: MessageType.REJECTED,
                );
              },
              (r) async {
                Get.back();
                email = emailController.text;
                CustomToast.showMessage(
                  message: r,
                  messageType: MessageType.SUCCESS,
                );
                currentIndex.value++;
                // await verify();
                update();
              },
            );
          }),
    );
  }

  Future<void> verify() async {
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
              message: r,
              messageType: MessageType.SUCCESS,
            );
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
              Get.off(() => LoginView());
            },
          );
        },
      ),
    );
  }

  clickToExpanded({required int index}) {
    expandedContainer[index] = !expandedContainer[index];
    update();
  }

  Future selectRole({required String role}) async {
    selectedRole = role;
    expandedContainer[0] = false;
    expandedContainer[1] = false;
    update();
    await Future.delayed(Duration(milliseconds: 300), () {
      if (role == 'admin') {
        expandedContainer[0] = true;
      } else {
        expandedContainer[1] = true;
      }

      update();
    });
  }
}
