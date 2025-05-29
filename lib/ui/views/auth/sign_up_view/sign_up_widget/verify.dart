import 'package:animate_do/animate_do.dart';
import 'package:simple_e_commerce/core/translation/app_translation.dart';
import 'package:simple_e_commerce/ui/shared/colors.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_button.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_otp_field.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text.dart';
import 'package:simple_e_commerce/ui/shared/extension_sizebox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpVerify extends StatelessWidget {
  const SignUpVerify({
    super.key,
    required this.controller,
    this.onPressedVerify,
    this.onPressedResend,
  });

  final TextEditingController controller;
  final Function? onPressedVerify;
  final Function()? onPressedResend;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (50.h).ph,
        CustomText(
          text: tr('Please Enter The 6 Digits Code sent to you'),
          textType: TextStyleType.bodyBig,
        ),
        (25.h).ph,
        CustomOtpField(controller: controller),
        (25.h).ph,
        GestureDetector(
          onTap: onPressedResend,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: tr('Resend'),
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
        CustomButton(
          width: 1.sw,
          height: 50.h,
          buttonTypeEnum: ButtonTypeEnum.normal,
          onPressed: onPressedVerify,
          text: tr('Verify'),
        ),
        (25.h).ph,
        CustomText(
          text: tr('You will be redirected to login page'),
          textType: TextStyleType.bodyBig,
          textColor: AppColors.grayColor,
        ),
      ],
    );
  }
}
