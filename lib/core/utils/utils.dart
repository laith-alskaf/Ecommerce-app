import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/enums/message_type.dart';
import 'package:simple_e_commerce/core/utils/colors.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_toast.dart';

double screenWidth(percent) {
  return Get.size.width / percent;
}

double screenHeight(percent) {
  return Get.size.width / percent;
}

double get width => Get.size.width;

double get height => Get.size.height;

//___________________________________________________________________________
void customLoader() => BotToast.showCustomLoading(
  toastBuilder: (context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.circular(10),
      ),
      width: screenWidth(4),
      height: screenHeight(4),
      child: SpinKitCircle(color: AppColors.whiteColor, size: screenWidth(8)),
    );
  },
);
//___________________________________________________________
void showNoConnectionMessage() {
  CustomToast.showMessage(
    message: 'Please check internet connection',
    messageType: MessageType.WARNING,
  );
}

//_____________________________________________________________
void showConnectionMessage() {
  CustomToast.showMessage(
    message: 'Internet Connected',
    messageType: MessageType.WARNING,
  );
}
