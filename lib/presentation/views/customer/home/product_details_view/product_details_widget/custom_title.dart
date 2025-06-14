import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_e_commerce/core/utils/colors.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_text.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return CustomText(
      textType: TextStyleType.subtitle,
      text: title,
      fontWeight: FontWeight.bold,
      textColor: AppColors.mainColor,
      bottomPadding: 10.h,
    );
  }
}
