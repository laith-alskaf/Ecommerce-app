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
import 'package:simple_e_commerce/ui/views/auth/sign_up_view/sign_up_widget/company_form.dart';
import 'package:simple_e_commerce/ui/views/auth/sign_up_view/sign_up_widget/custom_dilog.dart';
import 'package:simple_e_commerce/ui/views/auth/sign_up_view/sign_up_widget/user_form.dart';
import 'package:simple_e_commerce/ui/views/auth/sign_up_view/sign_up_widget/verify.dart';

// ignore: must_be_immutable
class SignUpMain extends StatelessWidget {
  SignUpMain({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey(debugLabel: 'signScreenKey');

  @override
  Widget build(BuildContext context) {
    SignUpViewController controller = Get.put(SignUpViewController());

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
                          SvgPicture.asset(
                            'assets/images/ic_${controller.imageSignUp[controller.currentIndex.value]}.svg',
                            width: 200.w,
                            height: 150.h,
                          ),
                        if (controller.currentIndex.value == 0)
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: CustomText(
                              text: tr('Let’s Create New Account'),
                              textType: TextStyleType.bodyBig,
                              textColor: AppColors.blackColor,
                              startPadding: 15.w,
                            ),
                          ),

                        (20.h).ph,
                        Row(
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
                                    borderRadius: BorderRadius.circular(100.r),
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
                        (20.h).ph,
                        GetBuilder<SignUpViewController>(
                          builder: (c) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    icon: Icon(Icons.person_outline),
                                    label: Text('User'.tr),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                      controller.selectedRole == 'customer'
                                          ? Theme.of(context).primaryColor
                                          : Colors.grey[300],
                                      foregroundColor:
                                      controller.selectedRole == 'customer'
                                          ? Colors.white
                                          : Colors.black,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 12.h,
                                      ),
                                    ),
                                    onPressed: () async{
                                      await  controller.selectRole(role: 'customer');
                                    },
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: ElevatedButton.icon(
                                    icon: Icon(Icons.business_outlined),
                                    label: Text('Company'.tr),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                      controller.selectedRole == 'admin'
                                          ? Theme.of(context).primaryColor
                                          : Colors.grey[300],
                                      foregroundColor:
                                      controller.selectedRole == 'admin'
                                          ? Colors.white
                                          : Colors.black,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 12.h,
                                      ),
                                    ),
                                    onPressed: ()async {
                                      await controller.selectRole(role: 'admin');
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        (20.h).ph,
                        if (controller.currentIndex.value == 0) ...[
                          CustomTextFormField(
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
                          (25.h).ph,
                          GetBuilder<SignUpViewController>(
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
                          (25.h).ph,
                          GetBuilder<SignUpViewController>(
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
                          (10.h).ph,
                          CompanyForm(controller: controller),
                          UserForm(controller: controller),
                          (25.h).ph,
                          CustomButton(
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
                          (25.h).ph,
                          CustomText(
                            isTextAlign: TextAlign.center,
                            text: tr('Already have account'),
                            textType: TextStyleType.small,
                          ),
                          (10.h).ph,
                          InkWell(
                            onTap: () {
                              Get.offAll(
                                () => LoginView(),
                                transition: Transition.rightToLeftWithFade,
                                duration: const Duration(milliseconds: 350),
                              );
                            },
                            child: CustomText(
                              isTextAlign: TextAlign.center,
                              text: 'Login'.tr,
                              textType: TextStyleType.bodyBig,
                              textColor: AppColors.mainColor,
                              fontWeight: FontWeight.bold,
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
            transition: Transition.rightToLeftWithFade,
            duration: const Duration(milliseconds: 350),
          );
        }
      },
    );
  }
}
