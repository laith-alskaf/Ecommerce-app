import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_e_commerce/core/utils/colors.dart';

Widget customListDivider({
  double? height,
  double? thickness,
  double? indent,
  double? endIndent,
  Color? color,
}) {
  return Divider(
    height: height ?? 25.h,
    thickness: thickness ?? 0.8,
    indent: indent ?? 20.w,
    endIndent: endIndent ?? 20.w,
    color: color ?? AppColors.grayColor.withOpacity(0.4),
  );
}
