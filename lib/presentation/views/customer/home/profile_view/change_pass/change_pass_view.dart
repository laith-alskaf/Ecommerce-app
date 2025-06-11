import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/enums/request_status.dart';
import 'package:simple_e_commerce/core/translation/app_translation.dart';
import 'package:simple_e_commerce/core/utils/colors.dart';
import 'package:simple_e_commerce/presentation/views/customer/home/profile_view/profile_controller.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_button.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_text_field.dart';
import 'package:simple_e_commerce/core/utils/extension_sizebox.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_text.dart';

class ChangePasswordView extends StatelessWidget {
  ChangePasswordView({super.key, required this.email});

  final String email;
  final GlobalKey<FormState> _formKeyForget = GlobalKey(
    debugLabel: 'changePassScreenKey',
  );

  @override
  Widget build(BuildContext context) {
    ProfileController controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: "Change Password",
          textType: TextStyleType.subtitle,
          textColor: AppColors.whiteColor,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: AppColors.mainColor,
        elevation: 0.8,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.whiteColor,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
        child: Form(
          key: _formKeyForget,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (20.h).ph,
              CustomText(
                text:
                    'Update your account password. For security, choose a strong password that you haven\'t used before.',
                textType: TextStyleType.subtitle,
                heightText: 1.5,
                textColor: AppColors.blackColor,
                fontWeight: FontWeight.normal,
              ),
              (30.h).ph,
              CustomText(
                text: 'Old Password', // "Current Password"
                textType: TextStyleType.bodyBig,
                textColor: AppColors.blackColor.withOpacity(0.7),
                fontWeight: FontWeight.normal,
              ),
              (8.h).ph,
              CustomTextFormField(
                hintText: '',
                controller: controller.oldPassword,
                colorBorder: AppColors.mainColor,
                validator: (value) {
                  if (value!.isEmpty) {
                    return tr('please check your old password');
                  }
                  if (value.length <= 7) {
                    return tr('please input more than 7');
                  }
                  return null;
                },
              ),
              (20.h).ph,
              CustomText(
                text: 'New Password',
                textType: TextStyleType.bodyBig,
                textColor: AppColors.blackColor.withOpacity(0.7),
                fontWeight: FontWeight.normal,
              ),
              (8.h).ph,
              GetBuilder<ProfileController>(
                builder: (c) {
                  return CustomTextFormField(
                    suffixWidget: InkWell(
                      onTap: () {
                        controller.editShowingPass(index: 0);
                      },
                      child: Icon(
                        controller.isShowingPass[0] == true
                            ? Icons.remove_red_eye
                            : Icons.visibility_off_outlined,
                        color: AppColors.mainColor,
                      ),
                    ),
                    obscureText: controller.isShowingPass[0],
                    hintText: '',
                    colorBorder: AppColors.mainColor,
                    controller: controller.newPasswordController,
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
              (20.h).ph,
              CustomText(
                text: 'Confirm Password',
                textType: TextStyleType.bodyBig,
                textColor: AppColors.blackColor.withOpacity(0.7),
                fontWeight: FontWeight.normal,
              ),
              (8.h).ph,
              GetBuilder<ProfileController>(
                builder: (c) {
                  return CustomTextFormField(
                    suffixWidget: InkWell(
                      onTap: () {
                        controller.editShowingPass(index: 1);
                      },
                      child: Icon(
                        controller.isShowingPass[1] == true
                            ? Icons.remove_red_eye
                            : Icons.visibility_off_outlined,
                        color: AppColors.mainColor,
                      ),
                    ),
                    obscureText: controller.isShowingPass[1],
                    hintText: '',
                    colorBorder: AppColors.mainColor,
                    controller: controller.confirmNewPasswordController,
                    validator: (value) {
                      if (value!.isEmpty ||
                          controller.newPasswordController.text !=
                              controller.confirmNewPasswordController.text) {
                        return tr('please check your confirm password');
                      }
                      return null;
                    },
                  );
                },
              ),
              (20.h).ph,
              CustomButton(
                width: 1.sw,
                height: 50.h,
                onPressed:
                    controller.requestStatus.value == RequestStatus.LOADING
                        ? null
                        : () async {
                          if (_formKeyForget.currentState!.validate()) {
                            controller.updatePassword();
                          }
                        },

                text: 'Update Password',
                fontWeight: FontWeight.bold,
                buttonTypeEnum: ButtonTypeEnum.normal,
                child:
                    controller.requestStatus.value == RequestStatus.LOADING
                        ? SpinKitChasingDots(
                          color: AppColors.whiteColor,
                          size: 40.w,
                        )
                        : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
