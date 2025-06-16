import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_e_commerce/app/di/service_locator.dart';
import 'package:simple_e_commerce/app/my_app_cubit.dart';
import 'package:simple_e_commerce/core/data/repositories/storage_repositories.dart';
import 'package:simple_e_commerce/core/translation/app_translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/utils/colors.dart';
import 'package:simple_e_commerce/presentation/views/admin/home_view_admin/home_view_admin.dart';
import 'package:simple_e_commerce/presentation/views/auth/login_view/login_view.dart';
import 'package:simple_e_commerce/presentation/views/customer/home/main_view.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_text.dart';

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
      backgroundColor: AppColors.mainColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/logo.svg', width: 250.w),
              SizedBox(height: 20.h),
              CustomText(
                text: tr('Thawbuk'),
                textType: TextStyleType.custom,
                fontWeight: FontWeight.bold,
                textColor: AppColors.whiteColor,
                fontSize: 60.sp,
              ),
              SizedBox(height: 10.h),
              CustomText(
                text: tr('Your style starts here'),
                textType: TextStyleType.title,
                textColor: AppColors.whiteColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
