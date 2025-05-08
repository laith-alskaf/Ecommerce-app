import 'package:animate_do/animate_do.dart';
import 'package:simple_e_commerce/core/translation/app_translation.dart';
import 'package:simple_e_commerce/core/utils/general_util.dart';
import 'package:simple_e_commerce/ui/shared/colors.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_button.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_otp_field.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text.dart';
import 'package:simple_e_commerce/ui/shared/extension_sizebox.dart';
import 'package:simple_e_commerce/ui/views/auth/forget_password_view/forget_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class VerifyForgetPassView extends StatelessWidget {
  VerifyForgetPassView({
    super.key,
  });

  ForgePasswordController controller = Get.find();
  final GlobalKey<FormState> _formKeyVerifyForget = GlobalKey(
    debugLabel: 'verifyForgetKey',
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Form(
              key: _formKeyVerifyForget,
              child: Column(
                children: [
                  (0.05.sh).ph,
                  SvgPicture.asset('assets/images/ic_right.svg'),
                  (70.h).ph,
                  ZoomIn(
                    delay: const Duration(milliseconds: 400),
                    duration: const Duration(milliseconds: 300),
                    child: CustomText(
                        text: tr("Please Enter The 6 Digits Code sent to you"),
                        textType: TextStyleType.bodyBig),
                  ),
                  (25.h).ph,
                  CustomOtpField(
                    controller: controller.verifyCodeController,
                  ),
                  (25.h).ph,
                  GestureDetector(
                    onTap: () {
                      controller.forget();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: 'Resend',
                          isTextAlign: TextAlign.center,
                          textType: TextStyleType.bodyBig,
                          textColor: AppColors.mainColor,
                        ),
                        (10.w).pw,
                        SvgPicture.asset('assets/images/referach.svg'),
                      ],
                    ),
                  ),
                  (25.h).ph,
                  ZoomIn(
                    delay: const Duration(milliseconds: 400),
                    duration: const Duration(milliseconds: 300),
                    child: CustomButton(
                      width: 1.sw,
                      height: 50.h,
                      buttonTypeEnum: ButtonTypeEnum.normal,
                      onPressed: () async {
                        if (_formKeyVerifyForget.currentState!.validate()) {
                          await controller.sendCode();
                        }
                      },
                      text: 'Verify',
                    ),
                  ),
                  (25.h).ph,
                  ZoomIn(
                    delay: const Duration(milliseconds: 400),
                    duration: const Duration(milliseconds: 300),
                    child: CustomText(
                      text: tr("You will be redirected to login page"),
                      textType: TextStyleType.bodyBig,
                      textColor: AppColors.grayColor,
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
