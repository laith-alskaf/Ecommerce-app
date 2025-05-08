import 'package:animate_do/animate_do.dart';
import 'package:simple_e_commerce/core/translation/app_translation.dart';
import 'package:simple_e_commerce/ui/shared/colors.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_button.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text.dart';
import 'package:simple_e_commerce/ui/shared/extension_sizebox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/ui/views/auth/sign_up_view/sign_up_view_controller.dart';

class SignUpCheckEmail extends StatelessWidget {
  const SignUpCheckEmail({super.key, required this.controller});

  final SignUpViewController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (160.h).ph,
        ZoomIn(
          delay: const Duration(milliseconds: 400),
          duration: const Duration(milliseconds: 300),
          child: CustomText(
            text: tr('Please Check Your Inbox for The Verification Email'),
            isTextAlign: TextAlign.center,
            textType: TextStyleType.title,
            fontWeight: FontWeight.normal,
          ),
        ),
        (15.h).ph,
        ZoomIn(
            delay: const Duration(milliseconds: 400),
            duration: const Duration(milliseconds: 300),
            child: GetBuilder<SignUpViewController>(
              builder: (s) {
                return CustomText(
                  text: controller.email,
                  textType: TextStyleType.body,
                  textColor: AppColors.mainColor,
                );
              },
            )),
        (25.h).ph,
        ZoomIn(
          delay: const Duration(milliseconds: 400),
          duration: const Duration(milliseconds: 300),
          child: CustomButton(
            width: 1.sw,
            height: 50.h,
            buttonTypeEnum: ButtonTypeEnum.normal,
            onPressed: () {
              controller.currentIndex.value++;
            },
            text: tr('Next'),
          ),
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
