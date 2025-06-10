import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/utils/colors.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text.dart';

class StaticCustomDrop extends StatelessWidget {
  final List<String> itemList;
  final double? width;
  final double? textSize;
  final double? height;
  final String text;
  final String? value;
  final Function(String?)? onChanged;

  const StaticCustomDrop({
    super.key,
    required this.itemList,
    this.width,
    this.height,
    this.textSize,
    required this.text,
    this.onChanged,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        onMenuStateChange: (_) {},
        value: value,
        buttonStyleData: ButtonStyleData(
          height: 60.h,
          width: 1.sw,
          padding: const EdgeInsetsDirectional.only(start: 14, end: 14),
          decoration: BoxDecoration(
            boxShadow: const [],
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: AppColors.mainColor),
            color: AppColors.whiteColor,
          ),
          elevation: 2,
        ),
        selectedItemBuilder: (s) {
          return itemList.map<DropdownMenuItem<String>>((element) {
            return DropdownMenuItem<String>(
              value: element,
              child: CustomText(
                text: element.tr,
                textType: TextStyleType.bodyBig,
                fontWeight: FontWeight.normal,
              ),
            );
          }).toList();
        },
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        hint: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: textSize ?? 18.sp,
            color: Colors.black.withOpacity(0.8),
          ),
        ),
        items:
            itemList.map<DropdownMenuItem<String>>((element) {
              return DropdownMenuItem<String>(
                value: element,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      element.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20.sp,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Container(
                      width: 1.sw,
                      height: 1.h,
                      color: AppColors.blackColor.withOpacity(0.6),
                    ),
                  ],
                ),
              );
            }).toList(),
        iconStyleData: IconStyleData(
          icon: Icon(
            Icons.arrow_drop_down_rounded,
            color: AppColors.mainColor,
            size: 30,
          ),
          iconSize: 50.r,
        ),
        isExpanded: true,
        onChanged: onChanged,
      ),
    );
  }
}
