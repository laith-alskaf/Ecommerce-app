import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_e_commerce/core/translation/app_translation.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/ui/shared/colors.dart';
import 'package:simple_e_commerce/ui/views/splash_screen_view/splash_screen_controller.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashScreenController(), permanent: false);

    return Scaffold(
      backgroundColor: AppColors.whiteColor, // Or your brand color
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // Vertically center
            crossAxisAlignment: CrossAxisAlignment.center,
            // Horizontally center
            children: [
              Expanded(
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/ic_splash.svg',
                    width: 220.w,
                    color: AppColors.mainColor,
                  ),
                ),
              ),
              SizedBox(height: 40.h), // Consistent spacing
              SpinKitThreeBounce(color: AppColors.mainColor),
              SizedBox(height: 20.h), // Consistent spacing
              CustomText(
                text: tr('Welcome!'),
                // Shorter message
                textType: TextStyleType.title,
                isTextAlign: TextAlign.center,
                fontWeight: FontWeight.bold,
                textColor: AppColors.mainColor,
                startPadding: 0.w,
                //Remove the padding if it is in the column.
                endPadding: 0.w,
              ),
              SizedBox(height: 20.h), // Consistent spacing
              CustomText(
                text: tr('Loading...'),
                // Shorter message
                textType: TextStyleType.body,
                isTextAlign: TextAlign.center,
                fontWeight: FontWeight.normal,
                textColor: AppColors.grayColor,
                startPadding: 0.w,
                //Remove the padding if it is in the column.
                endPadding: 0.w,
              ),
              SizedBox(height: 130.h), // Consistent spacing
            ],
          ),
        ),
      ),
    );
  }
}
