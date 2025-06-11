import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_e_commerce/core/utils/colors.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_button.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_text.dart';
import 'package:simple_e_commerce/core/utils/extension_sizebox.dart';

Future<void> showLoginRequiredDialog({
  required BuildContext context,
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
  await showDialog(
    context: context,
    // barrierDismissible: false,
    builder:
        (context) => Dialog(
          insetPadding: EdgeInsets.all(20),
          backgroundColor: AppColors.whiteColor,
          child: IntrinsicHeight(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                        onPressed: () {
                          Navigator.of(context).pop();
                          if (onLoginPressed != null) onLoginPressed();
                        },
                      ),
                      (20.w).pw,
                      CustomButton(
                        text: signUpButtonText,
                        buttonTypeEnum: ButtonTypeEnum.small,
                        onPressed: () {
                          Navigator.of(context).pop();
                          if (onSignUpPressed != null) onSignUpPressed();
                        },
                        backgroundColor: AppColors.whiteColor,
                        textColor: AppColors.blackColor,
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (onCancelPressed != null) onCancelPressed();
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
