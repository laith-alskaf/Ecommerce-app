import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_e_commerce/core/utils/colors.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text.dart';

Widget customTitleProfile(String title) {
  return Align(
    alignment: AlignmentDirectional.centerStart,
    child: CustomText(
      startPadding: 20.w,
      text: title,
      textType: TextStyleType.bodyBig,
      textColor: AppColors.mainColor,
      fontWeight: FontWeight.normal,
    ),
  );
}
