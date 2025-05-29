import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_e_commerce/ui/shared/colors.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text.dart';
import 'package:simple_e_commerce/ui/shared/extension_sizebox.dart';

Widget customProfileMenuItem({
  required IconData iconData,
  required String text,
  required VoidCallback onTap,
  Color? iconColor,
  Color? textColor,
  Widget? trailing,
}) {
  return Material(
    color: AppColors.whiteColor,
    child: InkWell(
      onTap: onTap,
      splashColor: AppColors.mainColor.withOpacity(0.1),
      highlightColor: AppColors.mainColor.withOpacity(0.05),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        child: Row(
          children: [
            Icon(
              iconData,
              size: 25.w,
              color: iconColor ?? AppColors.grayColor.withOpacity(0.8),
            ),
            (15.w).pw,
            Expanded(
              child: CustomText(
                text: text,
                textType: TextStyleType.body,
                textColor: textColor ?? AppColors.blackColor.withOpacity(0.8),
                fontWeight: FontWeight.normal,
              ),
            ),
            if (trailing != null)
              trailing
            else
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20.w,
                color: AppColors.grayColor.withOpacity(0.7),
              ),
          ],
        ),
      ),
    ),
  );
}
