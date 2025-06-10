import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/translation/app_translation.dart';
import 'package:simple_e_commerce/core/utils/string_urtil.dart';
import 'package:simple_e_commerce/core/utils/colors.dart';
import 'package:simple_e_commerce/presentation/views/auth/forget_password_view/forget_password_controller.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_button.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text_field.dart';
import 'package:simple_e_commerce/ui/shared/extension_sizebox.dart';
import '../../../../core/utils/general_util.dart';

class ForgetPasswordView extends StatelessWidget {
  ForgetPasswordView({super.key});

  final ForgePasswordController controller = Get.put(ForgePasswordController());
  final GlobalKey<FormState> _formKeyForget = GlobalKey(
    debugLabel: 'forgetScreenKey',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Form(
          key: _formKeyForget,
          child: Column(
            children: [
              (0.1.sh).ph,
              CustomText(
                text: tr("Forget Password"),
                textType: TextStyleType.title,
                textColor: AppColors.mainColor,
                fontWeight: FontWeight.bold,
              ),
              (30.h).ph,
              CustomText(
                text: tr(
                  "Don’t worry it happens please enter your email address",
                ),
                textType: TextStyleType.subtitle,
                textColor: AppColors.blackColor.withOpacity(0.6),
              ),
              (80.h).ph,
              CustomTextFormField(
                hintText: tr("Email"),
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty || !StringUtil.isEmail(value)) {
                    return tr("please check your email");
                  }
                  return null;
                },
              ),
              (40.h).ph,
              CustomButton(
                width: 1.sw,
                height: 50.h,
                onPressed: () async {
                  if (_formKeyForget.currentState!.validate()) {
                    await controller.forget();
                  }
                },
                text: tr("Reset Password"),
                buttonTypeEnum: ButtonTypeEnum.normal,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
