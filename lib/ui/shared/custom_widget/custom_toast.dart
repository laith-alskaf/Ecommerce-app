import 'package:bot_toast/bot_toast.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_e_commerce/core/enums/message_type.dart';
import 'package:simple_e_commerce/ui/shared/colors.dart';
import 'package:simple_e_commerce/ui/shared/extension_sizebox.dart';
import 'package:simple_e_commerce/ui/shared/utils.dart';

class CustomToast {
  static showMessage(
      {required String message, MessageType? messageType = MessageType.INFO}) {
    String imageName = 'info';
    Color shadowColor = AppColors.mainColor;
    switch (messageType) {
      case MessageType.REJECTED:
        imageName = 'rejected-01';
        shadowColor = AppColors.redcolor;
        break;
      case MessageType.SUCCESS:
        imageName = 'approved1-01';
        shadowColor = Colors.green;
        break;
      case MessageType.WARNING:
        imageName = 'warning';
        shadowColor = Colors.orange;
        break;
      default:
        break;
    }
    BotToast.showCustomText(
        duration: const Duration(seconds: 3),
        toastBuilder: (value) {
          return Container(
            margin: EdgeInsets.only(bottom: 10.h),
            padding: const EdgeInsets.only(top: 5,),
            width: screenWidth(1.5),
            decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: shadowColor.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0, 2),
                  )
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/images/$imageName.svg',
                  width: screenWidth(8),
                  height: screenWidth(8),
                ),
                15.ph,
                CustomText(
                  text:message,
                  textType: TextStyleType.subtitle,
                  fontWeight: FontWeight.w400,
                  startPadding: 20.w,
                  textColor: AppColors.blackColor,
                  endPadding: 20.w,
                  isTextAlign: TextAlign.center,
                ),
                15.ph,
              ],
            ),
          );
        });
  }
}
