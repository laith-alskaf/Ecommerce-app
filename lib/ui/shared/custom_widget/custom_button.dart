import 'package:simple_e_commerce/ui/shared/colors.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ButtonTypeEnum {
  big, //   Apply,  // 362 width
  medium, //  Share the app link  // 170 width
  normal, // English // Send an SMS  // 145 width
  small, //  Next   // 120 width
  custom,
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    this.backgroundColor,
    required this.text,
    this.textColor,
    this.borderColor,
    this.paddingElevatedVertical,
    this.paddingElevatedHorizontal,
    this.sizeOfText,
    required this.buttonTypeEnum,
    this.textDecoration,
    this.textStyleType,
    this.borderRadius,
    this.fontWeight,
    this.width,
    this.height,
    this.child, this.fontSize,
  });

  final Function? onPressed;
  final Color? backgroundColor;
  final String text;
  final Color? textColor;
  final double? sizeOfText;
  final double? borderRadius;
  final double? fontSize;
  final double? width;
  final double? height;
  final ButtonTypeEnum buttonTypeEnum;
  final Color? borderColor;
  final TextDecoration? textDecoration;
  final FontWeight? fontWeight;
  final Widget? child;
  final TextStyleType? textStyleType;
  final double? paddingElevatedVertical;
  final double? paddingElevatedHorizontal;

  Map<String, dynamic> chooseButtonType() {
    switch (buttonTypeEnum) {
      case ButtonTypeEnum.big:
        return {
          "width": width ?? 362.w, // Apply
          "height": height ?? 64.h,
          "backgroundColor": AppColors.mainColor,
          "textColor": textColor ?? AppColors.whiteColor,
          "borderColor": AppColors.mainColor,
          "borderRadius": 13.0.r,
          "fontWeight": FontWeight.bold,
          'textDecoration': TextDecoration.none,
          "textStyleType": TextStyleType.bodyBig
        };
      case ButtonTypeEnum.medium: // Share the app link
        return {
          "width": width ?? 170.w,
          "height": height ?? 42.h,
          "backgroundColor": AppColors.mainColor,
          "textColor": textColor ?? AppColors.whiteColor,
          "borderColor": AppColors.mainColor,
          "fontWeight": FontWeight.normal,
          "textStyleType": TextStyleType.small
        };

      case ButtonTypeEnum.normal: // Send an SMS
        return {
          "width": width ?? 141.w,
          "height": height ?? 42.h,
          "backgroundColor": AppColors.mainColor,
          "textColor": textColor ?? AppColors.whiteColor,
          "borderColor": AppColors.mainColor,
          "fontWeight": FontWeight.normal,
          "textStyleType": TextStyleType.body
        };

      case ButtonTypeEnum.small: // delete // Next
        return {
          "width": width ?? 120.w,
          "height": height ?? 36.h,
          "backgroundColor": AppColors.mainColor,
          "textColor": textColor ?? AppColors.whiteColor,
          "borderColor": AppColors.mainColor,
          "fontWeight": FontWeight.normal,
          'textDecoration': TextDecoration.none,
          "textStyleType": TextStyleType.bodyBig
        };

      case ButtonTypeEnum.custom:
        return {
          "width": width,
          "height": height,
          "backgroundColor": backgroundColor,
          "textColor": textColor,
          "borderColor": borderColor,
          "fontSize": sizeOfText,
          "fontWeight": FontWeight.bold,
          'textDecoration': textDecoration,
          "textStyleType": textStyleType
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> enumResult = chooseButtonType();
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: paddingElevatedHorizontal ?? 0,
          vertical: paddingElevatedVertical ?? 0),
      child: SizedBox(
        height: height ?? enumResult['height'],
        width: enumResult['width'],
        child: ElevatedButton(
          onPressed: () {
            if (onPressed != null) onPressed!();
          },
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(0),
              fixedSize: Size(width ?? enumResult['width'] ?? 22,
                  height ?? enumResult['height'] ?? 42.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    borderRadius ?? enumResult['borderRadius'] ?? 15.0.r),
              ),
              elevation: 0,
              backgroundColor: backgroundColor ??
                  enumResult['backgroundColor'] ??
                  AppColors.whiteColor,
              side: BorderSide(
                width: 1.0,
                color: borderColor ??
                    enumResult['borderColor'] ??
                    AppColors.mainColor,
              )),
          child: child ??
              CustomText(
                isTextAlign: TextAlign.center,
                textType: textStyleType ??
                    enumResult['textStyleType'] ??
                    TextStyleType.small,
                textDecoration: textDecoration ??
                    enumResult['textDecoration'] ??
                    TextDecoration.none,
                text: text,

                fontSize: fontSize,
                textColor: enumResult['textColor'],
                fontWeight:
                fontWeight ?? enumResult['fontWeight'] ?? FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
