import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/ui/shared/colors.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_button.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text.dart';

showNotificationSnack({
  required title,
  required String body,
  Function? buttonHandler,
  String? buttonText,
}) {
  Get.rawSnackbar(
    title: title,
    message: body,
    duration: const Duration(seconds: 6),
    dismissDirection: DismissDirection.horizontal,
    borderColor: AppColors.mainColor,
    boxShadows: [
      BoxShadow(
        color: AppColors.mainColor.withOpacity(0.8),
        spreadRadius: 2,
        blurRadius: 4,
        offset: const Offset(0, 2),
      ),
    ],
    leftBarIndicatorColor: AppColors.mainColor,
    borderRadius: 15.r,
    mainButton: Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: CustomButton(
        onPressed: buttonHandler,
        text: buttonText ?? 'Ok'.tr,
        buttonTypeEnum: ButtonTypeEnum.small,
      ),
    ),
    snackPosition: SnackPosition.TOP,
    snackStyle: SnackStyle.FLOATING,
    margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
    forwardAnimationCurve: Curves.easeOutSine,
  );
}
