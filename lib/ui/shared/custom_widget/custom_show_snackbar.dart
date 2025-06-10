import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/utils/colors.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text.dart';

showSnackBar({required String title}) {
  Get.snackbar('', '',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 1,milliseconds: 500),
      padding: EdgeInsets.only(top: 10.h),
      borderRadius: 15.r,
      backgroundColor: AppColors.mainColor.withOpacity(0.7),
      titleText: Center(
        child: CustomText(
          text: title,
          textType: TextStyleType.bodyBig,
          fontSize: 23.sp,
          textColor: AppColors.whiteColor,
        ),
      ));
}
