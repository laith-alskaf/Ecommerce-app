import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/data/models/api/user_model.dart';
import 'package:simple_e_commerce/core/enums/request_status.dart';
import 'package:simple_e_commerce/core/utils/general_util.dart';

class EditProfileController extends GetxController {
  final GlobalKey<FormState> editProfileFormKey = GlobalKey<FormState>(
    debugLabel: 'editProfileFormKey',
  );
  UserModel? userInfo;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController email = TextEditingController();

  Rx<RequestStatus> requestStatus = RequestStatus.DEFUALT.obs;
  Rx<UserModel?> currentUser = Rx<UserModel?>(null);

  Future<void> submitUpdateProfile() async {
    Get.back();
  }

  initField() {
    firstNameController.text = userInfo!.userName!.split(' ')[0];
    lastNameController.text = userInfo!.userName!.split(' ')[1];
    email.text = userInfo!.email!;
  }

  @override
  void onInit() {
    userInfo = storage.getUserinfo();
    initField();
    super.onInit();
  }
}
