import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text.dart';
import 'package:simple_e_commerce/ui/views/auth/sign_up_view/sign_up_view_controller.dart';

class CustomRowInfo extends StatelessWidget {
  const CustomRowInfo({
    super.key,
    required this.title,
    this.suffixText,
    this.titleIcon,
    this.subTitle,
    required this.controller,
    required this.index,
  });

  final String title;
  final String? suffixText;
  final bool? titleIcon;
  final int index;
  final bool? subTitle;
  final SignUpViewController controller;

  @override
  Widget build(BuildContext context) {
    int checkSelectIndex = index;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GetBuilder<SignUpViewController>(
          builder: (c) {
            return Transform.flip(
                flipY: controller.expandedContainer[index] == true &&
                    checkSelectIndex == index
                    ? true
                    : false,
                child: Icon(
                  Icons.arrow_circle_down_outlined,
                  size: 32.w,
                ));
          },
        ),
        CustomText(
          text: title,
          textType:
              subTitle ?? false ? TextStyleType.bodyBig : TextStyleType.body,
          fontWeight: FontWeight.bold,
        )
      ],
    );
  }
}
