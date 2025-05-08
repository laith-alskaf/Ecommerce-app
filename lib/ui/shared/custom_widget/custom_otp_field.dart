import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:simple_e_commerce/ui/shared/colors.dart';

class CustomOtpField extends StatelessWidget {
  const CustomOtpField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      mainAxisAlignment: MainAxisAlignment.center,
      appContext: context,
      length: 6,
      obscuringCharacter: '*',
      controller: controller,
      obscureText: true,
      animationType: AnimationType.fade,
      keyboardType: TextInputType.number,
      boxShadows: const [],
      pinTheme: PinTheme(
        inactiveBorderWidth: 1.5.w,
        fieldOuterPadding: EdgeInsets.symmetric(horizontal: 5.w),
        errorBorderColor: Colors.red,
        shape: PinCodeFieldShape.box,
        activeColor: AppColors.mainColor,
        borderWidth: 0.2,
        activeFillColor: AppColors.whiteColor,
        inactiveColor: AppColors.mainColor,
        selectedColor: AppColors.whiteColor,
        inactiveFillColor: AppColors.whiteColor,
        selectedFillColor: AppColors.mainColor,
        borderRadius: BorderRadius.circular(14.r),
        fieldHeight: 60.w,
        fieldWidth: 60.w,
      ),
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      onCompleted: (v) {
        "Completed";
      },
      beforeTextPaste: (text) {
        "Allowing to paste $text";
        return true;
      },
      validator: (value) {
        if (value!.length < 6) {
          return 'please enter your code';
        }
        return null;
      },
    );
  }
}
