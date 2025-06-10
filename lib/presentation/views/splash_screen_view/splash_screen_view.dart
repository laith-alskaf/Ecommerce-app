import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_e_commerce/app/di/service_locator.dart';
import 'package:simple_e_commerce/app/my_app_cubit.dart';
import 'package:simple_e_commerce/core/data/repositories/storage_repositories.dart';
import 'package:simple_e_commerce/core/translation/app_translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/utils/colors.dart';
import 'package:simple_e_commerce/presentation/views/admin/home_view_admin/home_view_admin.dart';
import 'package:simple_e_commerce/presentation/views/auth/login_view/login_view.dart';
import 'package:simple_e_commerce/presentation/views/customer/home/main_view.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({super.key});

  Future initAppSplash(BuildContext context) async {
    String role = context.read<MyAppCubit>().role;
    log(role);
    await Future.delayed(const Duration(seconds: 2)).then((value) {
      if (sl<SharedPreferenceRepositories>().getToken() == '' &&
          role != "guest") {
        Get.off(() => LoginPageWrapper());
      } else {
        if (role == "customer" || role == "guest") {
          Get.off(() => MainView());
        } else if (role == "admin" || role == "superAdmin") {
          Get.off(() => HomeViewAdmin());
        } else {
          Get.off(() => LoginPageWrapper());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    initAppSplash(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
              SizedBox(height: 40.h),
              SpinKitThreeBounce(color: AppColors.mainColor),
              SizedBox(height: 20.h),
              CustomText(
                text: tr('Welcome!'),
                textType: TextStyleType.title,
                isTextAlign: TextAlign.center,
                fontWeight: FontWeight.bold,
                textColor: AppColors.mainColor,
                startPadding: 0.w,
                endPadding: 0.w,
              ),
              SizedBox(height: 20.h),
              CustomText(
                text: tr('Loading...'),
                textType: TextStyleType.body,
                isTextAlign: TextAlign.center,
                fontWeight: FontWeight.normal,
                textColor: AppColors.grayColor,
                startPadding: 0.w,
                endPadding: 0.w,
              ),
              SizedBox(height: 130.h),
            ],
          ),
        ),
      ),
    );
  }
}
