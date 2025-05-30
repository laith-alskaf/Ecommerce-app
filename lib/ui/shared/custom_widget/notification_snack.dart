import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/ui/shared/colors.dart';

showNotificationSnack(String title, String body,
    {Function? buttonHandler, String? buttonText}) {
  Get.rawSnackbar(
    titleText: Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 28.sp,
          color: AppColors.mainColor,
        ),
      ),
    ),
    messageText: Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Text(
        body,
        style: TextStyle(
          color: AppColors.whiteColor,
        ),
      ),
    ),
    backgroundColor: AppColors.mainColor,
    duration: const Duration(seconds: 6),
    dismissDirection: DismissDirection.horizontal,
    leftBarIndicatorColor: AppColors.blackColor,
    mainButton: Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: ElevatedButton(
          onPressed: () {
            Get.closeCurrentSnackbar();
            if (buttonHandler != null) {
              buttonHandler();
            }
          },
          child: Text(
            buttonText ?? 'ok'.tr,
            style: TextStyle(
              color: AppColors.whiteColor,
            ),
          )),
    ),
    snackPosition: SnackPosition.TOP,
    snackStyle: SnackStyle.FLOATING,
    margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
    padding: EdgeInsets.zero,
    forwardAnimationCurve: Curves.easeOutSine,
  );
}