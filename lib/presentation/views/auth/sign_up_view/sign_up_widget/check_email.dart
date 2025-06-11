import 'package:simple_e_commerce/core/translation/app_translation.dart';
import 'package:simple_e_commerce/core/utils/colors.dart';
import 'package:simple_e_commerce/presentation/controllers/auth/signup/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_button.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_text.dart';
import 'package:simple_e_commerce/core/utils/extension_sizebox.dart';

class SignUpCheckEmail extends StatelessWidget {
  const SignUpCheckEmail({super.key, required this.controller});

  final SignUpCubit controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (160.h).ph,
        CustomText(
          text: tr('Please Check Your Inbox for The Verification Email'),
          isTextAlign: TextAlign.center,
          textType: TextStyleType.title,
          fontWeight: FontWeight.normal,
        ),
        (15.h).ph,
         CustomText(
              text: controller.email,
              textType: TextStyleType.body,
              textColor: AppColors.mainColor,
            ),
        (25.h).ph,
        CustomButton(
          width: 1.sw,
          height: 50.h,
          buttonTypeEnum: ButtonTypeEnum.normal,
          onPressed: () {
            controller.currentIndex++;
          },
          text: tr('Next'),
        ),
        (25.h).ph,
        GestureDetector(
          onTap: () {},
          child: CustomText(
            text: tr('Didn\'t Receive Email ?'),
            isTextAlign: TextAlign.center,
            textType: TextStyleType.bodyBig,
            textColor: AppColors.blackColor,
            fontWeight: FontWeight.normal,
          ),
        ),
        (25.h).ph,
        GestureDetector(
          onTap: () {
            controller.verify();
          },
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
      ],
    );
  }
}
