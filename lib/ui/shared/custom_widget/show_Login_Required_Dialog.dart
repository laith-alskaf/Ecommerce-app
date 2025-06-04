import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/ui/shared/colors.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_button.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text.dart';
import 'package:simple_e_commerce/ui/shared/extension_sizebox.dart';

Future<void> showLoginRequiredDialog({
  String title = "Login Required",
  String message =
      "To use this feature and access all app services, please log in or create a new account.",
  String loginButtonText = "Login",
  String signUpButtonText = "Sign Up",
  String cancelButtonText = "Later",
  VoidCallback? onLoginPressed,
  VoidCallback? onSignUpPressed,
  VoidCallback? onCancelPressed,
}) async {
  await Get.dialog(
    transitionDuration: Duration(milliseconds: 300),
    Dialog(
      insetPadding: EdgeInsets.all(20),
      backgroundColor: AppColors.whiteColor,
      child: IntrinsicHeight(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              CustomText(
                text: title,
                textType: TextStyleType.subtitle,
                isTextAlign: TextAlign.center,
                fontWeight: FontWeight.bold,
              ),
              (20.h).ph,
              CustomText(
                text: message,
                isTextAlign: TextAlign.start,
                textType: TextStyleType.bodyBig,
                fontWeight: FontWeight.bold,
              ),
              (20.h).ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    text: loginButtonText,
                    buttonTypeEnum: ButtonTypeEnum.small,
                    onPressed: onLoginPressed,
                  ),
                  (20.w).pw,
                  CustomButton(
                    text: signUpButtonText,
                    buttonTypeEnum: ButtonTypeEnum.small,
                    onPressed: onSignUpPressed,
                    backgroundColor: AppColors.whiteColor,
                    textColor: AppColors.blackColor,
                  ),
                ],
              ),
              TextButton(
                onPressed:
                    onCancelPressed ??
                    () {
                      Get.back(); // Just close the dialog
                    },
                child: CustomText(
                  text: cancelButtonText,
                  textType: TextStyleType.bodyBig,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
