import 'package:simple_e_commerce/core/translation/app_translation.dart';
import 'package:simple_e_commerce/core/utils/general_util.dart';
import 'package:simple_e_commerce/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/presentation/views/auth/forget_password_view/forget_password_controller.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_button.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_text.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_text_field.dart';
import 'package:simple_e_commerce/core/utils/extension_sizebox.dart';

class ResetPasswordView extends StatelessWidget {
  ResetPasswordView({super.key});

  final ForgePasswordController controller = Get.find();

  final GlobalKey<FormState> _formKeyReset = GlobalKey(
    debugLabel: 'resetScreenKey',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Form(
          key: _formKeyReset,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (0.1.sh).ph,
              Center(
                child: CustomText(
                  text: tr("Reset Your Password"),
                  textType: TextStyleType.title,
                  textColor: AppColors.mainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              (80.h).ph,
              CustomText(
                text: tr("Password"),
                textType: TextStyleType.bodyBig,
                textColor: AppColors.blackColor,
              ),
              (5.h).ph,
              CustomTextFormField(
                hintText: "Password",
                controller: controller.passwordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return tr('please check your password');
                  }
                  if (value.length <= 7) {
                    return tr('please input more than 7');
                  }
                  return null;
                },
              ),
              (20.h).ph,
              CustomText(
                text: tr("Confirm Password"),
                textType: TextStyleType.bodyBig,
                textColor: AppColors.blackColor,
              ),
              (5.h).ph,
              CustomTextFormField(
                hintText: tr("Confirm Password"),
                controller: controller.confirmPasswordController,
                validator: (value) {
                  if (value!.isEmpty ||
                      controller.passwordController.text !=
                          controller.confirmPasswordController.text) {
                    return tr('please check your confirm password');
                  }
                  return null;
                },
              ),
              (40.h).ph,
              CustomButton(
                width: 1.sw,
                height: 50.h,
                onPressed: () async {
                  if (_formKeyReset.currentState!.validate()) {
                    await controller.resetPassword();
                  }
                },
                text: tr("Reset Password"),
                buttonTypeEnum: ButtonTypeEnum.normal,
              ),
              (40.h).ph,
              Center(
                child: CustomText(
                  text: tr("You will be redirected to login page"),
                  textType: TextStyleType.body,
                  textColor: AppColors.blackColor.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
