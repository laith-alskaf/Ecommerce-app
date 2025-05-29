import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/data/models/api/user_model.dart';
import 'package:simple_e_commerce/core/enums/request_status.dart';
import 'package:simple_e_commerce/core/services/base_controller.dart';
import 'package:simple_e_commerce/core/utils/general_util.dart';
import 'package:simple_e_commerce/ui/views/customer/home/profile_view/change_pass/change_pass_view.dart';
import 'package:simple_e_commerce/ui/views/customer/home/profile_view/edit_profile_view/edit_profile_view.dart';

class ProfileController extends BaseController {
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  List<bool> isShowingPass = [false, false];
  Rx<RequestStatus> requestStatus = RequestStatus.DEFUALT.obs;
  RxString currentLangCode = Get.locale?.languageCode.obs ?? 'en'.obs;
  final List<Map<String, String>> supportedLanguages = [
    {'code': 'en', 'name': 'English'},
    {'code': 'ar', 'name': 'العربية'},
  ];
  UserModel? storedUser;

  editShowingPass({required int index}) {
    isShowingPass[index] = !isShowingPass[index];
    update();
  }

  Future<void> loadUserProfile() async {
    requestStatus.value = RequestStatus.LOADING;
    try {
      await Future.delayed(const Duration(milliseconds: 800));
      storedUser = storage.getUserinfo();
      currentUser.value = storedUser;
      requestStatus.value = RequestStatus.SUCCESS;
    } catch (e) {
      log(
        "Error loading user profile: $e",
        error: Error(),
        name: 'loadUserProfile',
      );
      requestStatus.value = RequestStatus.ERROR;
      currentUser.value = UserModel(
        userName: "Error",
        email: "N/A",
        role: "N/A",
      );
    }
    update();
  }

  void editProfile() {
    Get.to(() => EditProfileView());
  }

  void changePassword() {
    newPasswordController.clear();
    confirmNewPasswordController.clear();
    oldPassword.clear();
    isShowingPass = [false, false];
    Get.to(() => ChangePasswordView(email: storedUser!.email!));
  }

  void changeLanguage(String langCode) {
    // Locale newLocale = Locale(langCode);
    // Get.updateLocale(newLocale);
    // currentLangCode.value = langCode;
    // update();
  }

  void contactUs() {
    Get.defaultDialog(
      title: "Contact Us",
      middleText:
          "For support, please contact us at:\nEmail: @email\nPhone: @phone"
              .trParams({
                'email': "laithalskaf@gmail.com",
                'phone': "+963982055788",
              }),
      textConfirm: "tr_ok".tr,
      confirmTextColor: Colors.white,
      onConfirm: () => Get.back(),
    );
  }

  void aboutApp() {
    Get.defaultDialog(
      title: "About App",
      middleText: "App Name: Ecommerce\nVersion: @version\n© 2023 Laith"
          .trParams({'appName': "My E-Commerce App", 'version': "1.0.0"}),
      textConfirm: "OK",
      confirmTextColor: Colors.white,
      onConfirm: () => Get.back(),
    );
  }

  updatePassword() {
    Get.back();
  }

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }
}
