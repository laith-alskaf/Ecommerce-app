import 'package:flutter/material.dart';
import 'package:simple_e_commerce/core/utils/general_util.dart';
import 'package:simple_e_commerce/core/utils/colors.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/presentation/views/customer/home/profile_view/profile_view.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_text.dart';

PreferredSizeWidget customAppBar({
  required String title,
  required bool isMainView,
}) => AppBar(
  title:  CustomText(
    text: title,
    textType: TextStyleType.subtitle,
    textColor: AppColors.whiteColor,
    fontWeight: FontWeight.w600,
  ),
  backgroundColor: AppColors.mainColor,
  elevation: 0.8,
  centerTitle: true,
  leading:
      Navigator.canPop(Get.context!)
          ? IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.whiteColor,
            ),
            onPressed: () => Get.back(),
          )
          : null,
  actions:
      isMainView == false
          ? null
          : [
            IconButton(
              icon: Icon(
                Icons.person_outline_rounded,
                color: AppColors.whiteColor,
              ),
              onPressed: ()async {
                if (myAppController.hasPermissionToUse()) {
                  Get.to(() => ProfileView());
                }
              },
            ),
          ],
);
