import 'package:animate_do/animate_do.dart';
import 'package:simple_e_commerce/core/translation/app_translation.dart';
import 'package:simple_e_commerce/core/utils/general_util.dart';
import 'package:simple_e_commerce/core/utils/string_urtil.dart';
import 'package:simple_e_commerce/ui/shared/colors.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_button.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text_field.dart';
import 'package:simple_e_commerce/ui/shared/extension_sizebox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/ui/views/auth/login_view/login_view.dart';
import 'package:simple_e_commerce/ui/views/auth/sign_up_view/sign_up_view_controller.dart';
import 'package:simple_e_commerce/ui/views/auth/sign_up_view/sign_up_widget/check_email.dart';
import 'package:simple_e_commerce/ui/views/auth/sign_up_view/sign_up_widget/custom_dilog.dart';
import 'package:simple_e_commerce/ui/views/auth/sign_up_view/sign_up_widget/verify.dart';

// ignore: must_be_immutable
class SignUpMain extends StatelessWidget {
  SignUpMain({super.key});

  SignUpViewController controller = Get.put(SignUpViewController());
  final GlobalKey<FormState> _formKey = GlobalKey(debugLabel: 'signScreenKey');

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Obx(
              () => SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: IntrinsicHeight(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        (0.05.sh).ph,
                        if (controller.currentIndex.value != 0)
                          FadeInDown(
                            delay: const Duration(milliseconds: 400),
                            duration: const Duration(milliseconds: 300),
                            child: SvgPicture.asset(
                              'assets/images/ic_${controller.imageSignUp[controller.currentIndex.value]}.svg',
                              width: 200.w,
                              height: 150.h,
                            ),
                          ),
                        if (controller.currentIndex.value == 0)
                          ZoomIn(
                            child: Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: CustomText(
                                text: tr('Let’s Create New Account'),
                                textType: TextStyleType.bodyBig,
                                textColor: AppColors.blackColor,
                                startPadding: 15.w,
                              ),
                            ),
                          ),
                        (20.h).ph,
                        ZoomIn(
                          delay: const Duration(milliseconds: 700),
                          duration: const Duration(milliseconds: 500),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              controller.imageSignUp.length,
                              (index) {
                                return Obx(() {
                                  return Container(
                                    margin: EdgeInsetsDirectional.only(
                                      end:
                                          index + 1 ==
                                                  controller.imageSignUp.length
                                              ? 0
                                              : 20.w,
                                    ),
                                    height: 10.h,
                                    width: 10.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        100.r,
                                      ),
                                      color:
                                          controller.currentIndex.value == index
                                              ? AppColors.mainColor
                                              : AppColors.backgroundColor,
                                    ),
                                  );
                                });
                              },
                            ),
                          ),
                        ),
                        (20.h).ph,
                        if (controller.currentIndex.value == 0) ...[
                          Row(
                            children: [
                              FadeInLeft(
                                delay: const Duration(milliseconds: 700),
                                duration: const Duration(milliseconds: 200),
                                child: CustomTextFormField(
                                  widthContainer: 215.w,
                                  hintText: tr('First Name'),
                                  controller: controller.firstNameController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return tr('Input your first name');
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const Spacer(),
                              FadeInLeft(
                                delay: const Duration(milliseconds: 700),
                                duration: const Duration(milliseconds: 200),
                                child: CustomTextFormField(
                                  widthContainer: 215.w,
                                  hintText: tr('Last Name'),
                                  controller: controller.lastNameController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return tr('Input your last name');
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          (25.h).ph,
                          FadeInLeft(
                            delay: const Duration(milliseconds: 900),
                            duration: const Duration(milliseconds: 200),
                            child: CustomTextFormField(
                              hintText: tr('Email'),
                              keyboardType: TextInputType.emailAddress,
                              controller: controller.emailController,
                              validator: (value) {
                                if (value!.isEmpty ||
                                    !StringUtil.isEmail(value)) {
                                  return tr('please check your email');
                                }
                                return null;
                              },
                            ),
                          ),
                          (25.h).ph,
                          FadeInLeft(
                            delay: const Duration(milliseconds: 1100),
                            duration: const Duration(milliseconds: 200),
                            child: GetBuilder<SignUpViewController>(
                              builder: (c) {
                                return CustomTextFormField(
                                  suffixWidget: InkWell(
                                    onTap: () {
                                      controller.showPass =
                                          !controller.showPass;
                                      controller.update();
                                    },
                                    child: Icon(
                                      controller.showPass == true
                                          ? Icons.remove_red_eye
                                          : Icons.visibility_off_outlined,
                                      color: AppColors.mainColor,
                                    ),
                                  ),
                                  obscureText: !controller.showPass,
                                  controller: controller.passwordController,
                                  hintText: tr('Password'),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return tr('please check your password');
                                    }
                                    if (value.length <= 7) {
                                      return tr('please input more than 7');
                                    }
                                    return null;
                                  },
                                );
                              },
                            ),
                          ),
                          (25.h).ph,
                          FadeInLeft(
                            delay: const Duration(milliseconds: 1100),
                            duration: const Duration(milliseconds: 200),
                            child: GetBuilder<SignUpViewController>(
                              builder: (c) {
                                return CustomTextFormField(
                                  obscureText: !controller.showPassConfirm,
                                  suffixWidget: InkWell(
                                    onTap: () {
                                      controller.showPassConfirm =
                                          !controller.showPassConfirm;
                                      controller.update();
                                    },
                                    child: Icon(
                                      controller.showPassConfirm == true
                                          ? Icons.remove_red_eye
                                          : Icons.visibility_off_outlined,
                                      color: AppColors.mainColor,
                                    ),
                                  ),
                                  controller: controller.confirmController,
                                  hintText: tr('Confirm Password'),
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        controller.passwordController.text !=
                                            controller.confirmController.text) {
                                      return tr(
                                        'please check your confirm password',
                                      );
                                    }
                                    return null;
                                  },
                                );
                              },
                            ),
                          ),
                          (10.h).ph,
                          GetBuilder<SignUpViewController>(
                            builder: (c) {
                              return Row(
                                children: [
                                  Radio(
                                    value: "customer",
                                    groupValue: controller.selectedRole,
                                    activeColor: AppColors.mainColor,
                                    onChanged: (value) {
                                      controller.selectedRole = value!;
                                      controller.update();
                                    },
                                  ),
                                  const Text(
                                    "User",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  (20.w).pw,
                                  Radio(
                                    value: "admin",
                                    activeColor: AppColors.mainColor,
                                    groupValue: controller.selectedRole,
                                    onChanged: (value) {
                                      controller.selectedRole = value!;
                                      controller.update();
                                    },
                                  ),
                                  const Text(
                                    "Admin",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  (20.w).pw,

                                  Radio(
                                    value: "superAdmin",
                                    groupValue: controller.selectedRole,
                                    activeColor: AppColors.mainColor,
                                    onChanged: (value) {
                                      controller.selectedRole = value!;
                                      controller.update();
                                    },
                                  ),
                                  const Text(
                                    "superAdmin",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              );
                            },
                          ),
                          (25.h).ph,
                          FadeInLeft(
                            delay: const Duration(milliseconds: 1900),
                            duration: const Duration(milliseconds: 200),
                            child: CustomButton(
                              width: 1.sw,
                              height: 50.h,
                              buttonTypeEnum: ButtonTypeEnum.normal,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  showCheckEmailDialog(
                                    email: controller.emailController.text,
                                  );
                                }
                              },
                              text: tr('Next'),
                            ),
                          ),
                          (25.h).ph,
                          ZoomIn(
                            delay: const Duration(milliseconds: 1900),
                            duration: const Duration(milliseconds: 200),
                            child: CustomText(
                              isTextAlign: TextAlign.center,
                              text: tr('Already have account'),
                              textType: TextStyleType.small,
                            ),
                          ),
                          (10.h).ph,
                          ZoomIn(
                            delay: const Duration(milliseconds: 1900),
                            duration: const Duration(milliseconds: 200),
                            child: InkWell(
                              onTap: () {
                                Get.offAll(
                                  () => LoginView(),
                                  transition: Transition.zoom,
                                  duration: const Duration(milliseconds: 350),
                                );
                              },
                              child: CustomText(
                                isTextAlign: TextAlign.center,
                                text: tr('key_login'),
                                textType: TextStyleType.bodyBig,
                                textColor: AppColors.mainColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          (35.h).ph,
                        ],
                        if (controller.currentIndex.value == 1) ...[
                          SignUpCheckEmail(controller: controller),
                        ],
                        if (controller.currentIndex.value == 2) ...[
                          SignUpVerify(
                            onPressedVerify: () {
                              controller.sendCode();
                            },
                            onPressedResend: () {
                              controller.verify();
                            },
                            controller: controller.verifyCodeController,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      onPopInvoked: (pop) {
        if (controller.currentIndex.value != 0) {
          controller.currentIndex.value = controller.currentIndex.value - 1;
        } else {
          Get.offAll(
            () => LoginView(),
            transition: Transition.zoom,
            duration: const Duration(milliseconds: 350),
          );
        }
      },
    );
  }
}
