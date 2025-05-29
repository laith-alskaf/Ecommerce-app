import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_e_commerce/ui/shared/colors.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text.dart';

class CustomContainerAction extends StatelessWidget {
  const CustomContainerAction({
    super.key,
    required this.title,
    required this.createdNumber,
  });

  final String title;
  final String createdNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30.h),
      width: 200.w,
      height: 180.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(35.r)),
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.mainColor.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3),
          ), // changes position of shadow
        ],
      ),
      child: Column(
        children: [
          CustomText(
            text: title,
            textType: TextStyleType.subtitle,
            textColor: AppColors.mainColor,
          ),
          Spacer(),
          CustomText(text: createdNumber, textType: TextStyleType.bodyBig),
        ],
      ),
    );
  }
}
