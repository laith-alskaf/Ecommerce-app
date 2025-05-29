import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/ui/shared/colors.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_button.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text.dart';
import 'package:simple_e_commerce/ui/shared/extension_sizebox.dart';
import 'package:simple_e_commerce/ui/views/admin/dashboard_view/dashboard_controller.dart';

import '../../../core/enums/request_status.dart';

showAlertDelete({required String text, required Function ontap}) {
  DashboardController controller = Get.find();
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(35.r)),
      ),
      backgroundColor: AppColors.whiteColor,
      insetPadding: const EdgeInsets.only(),
      child: Container(
        width: 460.w,
        height: 208.h,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(02.r)),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 48.w,
                    height: 43.w,
                    child: SvgPicture.asset('assets/images/rejected-01.svg'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.h),
                    child: CustomText(
                      textType: TextStyleType.title,
                      fontSize: 26.sp,
                      text: 'Confirm Delete',
                      fontWeight: FontWeight.bold,
                      textColor: AppColors.secondColorMain,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  (50.w).pw,
                  Flexible(
                    flex: 8,
                    child: CustomText(
                      text: text,
                      textType: TextStyleType.bodyBig,
                      textColor: AppColors.secondColorMain,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              Padding(
                padding: EdgeInsetsDirectional.only(end: 8.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      buttonTypeEnum: ButtonTypeEnum.small,
                      backgroundColor: AppColors.whiteColor,
                      borderColor: AppColors.secondColorMain,
                      textColor: AppColors.mainColor,
                      onPressed: ontap,
                      text: 'Cancel',
                    ),
                    SizedBox(width: 15.w),
                    controller.status.value == RequestStatus.LOADING
                        ? SpinKitCircle(color: AppColors.mainColor, size: 50.w)
                        : CustomButton(
                          buttonTypeEnum: ButtonTypeEnum.small,
                          backgroundColor: AppColors.mainColor,
                          borderColor: AppColors.mainColor,
                          onPressed: ontap,
                          text: 'Ok',
                        ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

