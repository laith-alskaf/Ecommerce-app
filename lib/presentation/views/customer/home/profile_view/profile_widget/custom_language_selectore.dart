import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/utils/colors.dart';
import 'package:simple_e_commerce/presentation/views/customer/home/profile_view/profile_controller.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text.dart';

Widget customLanguageSelector(ProfileController controller) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.w),
    child: Row(
      children: [
        Icon(
          Icons.language_rounded,
          size: 22.sp,
          color: AppColors.grayColor.withOpacity(0.8),
        ),
        SizedBox(width: 18.w),
        Expanded(
          child: CustomText(
            text: 'Language',
            textType: TextStyleType.body,
            textColor: AppColors.blackColor.withOpacity(0.8),
            fontWeight: FontWeight.normal,
          ),
        ),
        Obx(
          () => DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: controller.currentLangCode.value,
              icon: Icon(
                Icons.arrow_drop_down_rounded,
                color: AppColors.grayColor.withOpacity(0.7),
              ),
              elevation: 2,
              style: TextStyle(
                color: AppColors.blackColor.withOpacity(0.8),
                fontSize: 18.sp,
                fontFamily: 'YourAppFontFamily',
              ),
              dropdownColor: AppColors.whiteColor,
              items:
                  controller.supportedLanguages.map<DropdownMenuItem<String>>((
                    Map<String, String> lang,
                  ) {
                    return DropdownMenuItem<String>(
                      value: lang['code']!,
                      child: CustomText(
                        text: lang['name']!,
                        textType: TextStyleType.body,
                        fontWeight: FontWeight.normal,
                      ),
                    );
                  }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  controller.changeLanguage(newValue);
                }
              },
            ),
          ),
        ),
      ],
    ),
  );
}
