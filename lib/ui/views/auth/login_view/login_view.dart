import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/translation/app_translation.dart';
import 'package:simple_e_commerce/core/utils/general_util.dart';
import 'package:simple_e_commerce/core/utils/string_urtil.dart';
import 'package:simple_e_commerce/ui/shared/colors.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_button.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text_field.dart';
import 'package:simple_e_commerce/ui/shared/extension_sizebox.dart';
import 'package:simple_e_commerce/ui/views/auth/forget_password_view/forget_password_view.dart';
import 'package:simple_e_commerce/ui/views/auth/login_view/login_view_controller.dart';
import 'package:simple_e_commerce/ui/views/auth/sign_up_view/sign_up_main.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final GlobalKey<FormState> _formKey1 = GlobalKey(
    debugLabel: 'loginScreenKey',
  );

  @override
  Widget build(BuildContext context) {
    LoginViewController controller = Get.put(LoginViewController());

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.whiteColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Form(
            key: _formKey1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                (0.1.sh).ph,
                SvgPicture.asset(
                  'assets/images/ic_splash.svg',
                  width: 120.w,
                  color: AppColors.mainColor,
                ),
                (10.h).ph,
                CustomText(
                  isTextAlign: TextAlign.center,
                  text: 'EsyShop',
                  textType: TextStyleType.title,
                  fontWeight: FontWeight.bold,
                  textColor: AppColors.textColor2,
                ),
                (80.h).ph,
                CustomText(
                  text: tr('Welcome'),
                  textType: TextStyleType.title,
                  fontWeight: FontWeight.bold,
                  textColor: AppColors.blackColor,
                ),
                (15.h).ph,
                CustomText(
                  text: tr('Login to your account'),
                  textType: TextStyleType.bodyBig,
                  fontWeight: FontWeight.normal,
                  textColor: AppColors.blackColor,
                  startPadding: 15.w,
                ),
                (10.h).ph,
                CustomTextFormField(
                  hintText: tr('Email'),
                  controller: controller.emailController,
                  validator: (value) {
                    if (value!.isEmpty || !StringUtil.isEmail(value)) {
                      return tr('please check your email');
                    }
                    return null;
                  },
                ),
                (25.h).ph,
                GetBuilder<LoginViewController>(
                  builder: (c) {
                    return CustomTextFormField(
                      suffixWidget: InkWell(
                        onTap: () {
                          controller.showPass = !controller.showPass;
                          controller.update();
                        },
                        child: Icon(
                          controller.showPass == true
                              ? Icons.remove_red_eye
                              : Icons.visibility_off_outlined,
                          color: AppColors.mainColor,
                        ),
                      ),
                      hintText: tr('Password'),
                      obscureText: !controller.showPass,
                      controller: controller.passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return tr('please check your password');
                        }

                        return null;
                      },
                    );
                  },
                ),
                (10.h).ph,
                InkWell(
                  onTap: () {
                    Get.to(
                      () => ForgetPasswordView(),
                      transition: Transition.leftToRightWithFade,
                      duration: const Duration(milliseconds: 350),
                    );
                  },
                  child: CustomText(
                    isTextAlign: TextAlign.right,
                    text: tr('Forget Password'),
                    textType: TextStyleType.small,
                    textColor: AppColors.mainColor,
                  ),
                ),
                (25.h).ph,
                CustomButton(
                  width: 1.sw,
                  height: 50.h,
                  buttonTypeEnum: ButtonTypeEnum.normal,
                  onPressed: () async {
                    if (_formKey1.currentState!.validate()) {
                      await controller.login();
                    }
                  },
                  text: tr('key_login'),
                ),
                const Spacer(),
                CustomText(
                  isTextAlign: TextAlign.center,
                  text: tr('you don\'t have an account yet'),
                  textType: TextStyleType.small,
                ),
                (10.h).ph,
                InkWell(
                  onTap: () {
                    Get.to(
                      () => SignUpMain(),
                      transition: Transition.leftToRightWithFade,
                      duration: const Duration(milliseconds: 350),
                    );
                  },
                  child: CustomText(
                    isTextAlign: TextAlign.center,
                    text: tr('Create One'),
                    textType: TextStyleType.bodyBig,
                    textColor: AppColors.mainColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                (35.h).ph,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
