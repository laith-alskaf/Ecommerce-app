import 'package:flutter/material.dart';
import 'package:simple_e_commerce/core/utils/general_util.dart';
import 'package:simple_e_commerce/core/utils/colors.dart';

enum TextStyleType {
  title, // 30px  // title home views
  subtitle, // 25px // profile name
  bodyBig, // 20px
  body, // 18px    // menu
  small, // 16px  // default
  custom, // default TextStyle
}

class CustomText extends StatelessWidget {
  const CustomText(
      {super.key,
      required this.text,
      this.textColor,
      this.fontSize,
      this.fontWeight,
      this.isDecoration = false,
      this.isTextAlign,
      this.heightText,
      this.bottomPadding,
      this.startPadding,
      this.endPadding,
      this.topPadding,
      this.isTextDirection,
      required this.textType,
      this.textDecoration,
      this.maxLines,
      this.overflow,
      this.decorationColor});

  final String text;
  final double? fontSize;
  final Color? textColor;
  final Color? decorationColor;
  final bool isDecoration;
  final TextAlign? isTextAlign;
  final FontWeight? fontWeight;
  final TextStyleType textType;
  final double? heightText;
  final TextOverflow? overflow;
  final double? bottomPadding;
  final int? maxLines;
  final double? startPadding;
  final double? endPadding;
  final double? topPadding;
  final TextDirection? isTextDirection;
  final TextDecoration? textDecoration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
          bottom: bottomPadding ?? 0,
          end: endPadding ?? 0,
          start: startPadding ?? 0,
          top: topPadding ?? 0),
      child: Text(
        text,
        textAlign: isTextAlign,
        overflow: overflow ?? TextOverflow.visible,
        softWrap: true,
        style: getTextStyle(),
      ),
    );
  }

  TextStyle getTextStyle() {
    switch (textType) {
      case TextStyleType.title:
        return TextStyle(
          fontFamily: 'Cairo',
          height: heightText ?? 1.2,
          overflow: overflow,
          decoration: textDecoration,
          decorationColor: decorationColor ?? textColor,
          color: textColor ?? AppColors.textColor,
          fontSize: fontSize ?? sizeTextTitle,
          fontWeight: fontWeight,
        );

      case TextStyleType.subtitle:
        return TextStyle(
          fontFamily: 'Cairo',
          height: heightText ?? 1.2,
          overflow: overflow,
          decoration: textDecoration,
          decorationColor: decorationColor ?? textColor,
          color: textColor ?? AppColors.textColor,
          fontSize: fontSize ?? sizeTextSupHeader,
          fontWeight: fontWeight,
        );

      case TextStyleType.bodyBig:
        return TextStyle(
          fontFamily: 'Cairo',
          height: heightText ?? 1.2,
          decoration: textDecoration,
          color: textColor ?? AppColors.textColor,
          fontSize: fontSize ?? sizeTextBodyBig,
          overflow: overflow,
          decorationColor: decorationColor ?? textColor,
          fontWeight: fontWeight ?? FontWeight.bold,
        );

      case TextStyleType.body:
        return TextStyle(
            fontFamily: 'Cairo',
            height: heightText ?? 1,
            decoration: textDecoration,
            color: textColor ?? AppColors.textColor,
            fontSize: fontSize ?? sizeTextBody,
            decorationColor: decorationColor ?? textColor,
            overflow: overflow,
            fontWeight: fontWeight ?? FontWeight.bold);

      case TextStyleType.small:
        return TextStyle(
          fontFamily: 'Cairo',
          height: heightText ?? 1,
          decoration: textDecoration,
          overflow: overflow,
          decorationColor: decorationColor ?? textColor,
          color: textColor ?? AppColors.textColor,
          fontSize: fontSize ?? defaultSizeSmall,
          fontWeight: fontWeight,
        );

      case TextStyleType.custom:
        return TextStyle(
          fontFamily: 'Cairo',
          height: heightText ?? 1.2,
          decoration: textDecoration,
          decorationColor: decorationColor ?? textColor,
          color: textColor ?? AppColors.textColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
        );
    }
  }
}
