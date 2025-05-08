import 'package:simple_e_commerce/core/utils/general_util.dart';
import 'package:simple_e_commerce/ui/shared/colors.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_button.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/ui/views/auth/sign_up_view/sign_up_view_controller.dart';

showCheckEmailDialog({required String email}) {
  SignUpViewController controller = Get.find();
  showDialog(
    barrierDismissible: true,
    context: Get.context!,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.only(),
        content: IntrinsicHeight(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(20),
            ),
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                children: [
                  SizedBox(height: 40.h),
                  SvgPicture.asset(
                    "assets/images/ic_email.svg",
                    height: 50.h,
                    width: 50.h,
                  ),
                  SizedBox(height: 40.h),
                  CustomText(
                    text: "Are you sure this is your email?",
                    textType: TextStyleType.bodyBig,
                    textColor: AppColors.blackColor.withOpacity(0.6),
                  ),
                  SizedBox(height: 10.h),
                  CustomText(
                    text: email,
                    textType: TextStyleType.subtitle,
                    textColor: AppColors.mainColor,
                  ),
                  SizedBox(height: 30.h),
                  CustomButton(
                    width: MediaQuery.of(context).size.width,
                    height: 50.h,
                    text: "confirm",
                    buttonTypeEnum: ButtonTypeEnum.normal,
                    onPressed: () async {
                      controller.register();
                    },
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
