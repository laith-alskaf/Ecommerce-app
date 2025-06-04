import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/ui/shared/colors.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_button.dart';
import 'package:simple_e_commerce/ui/shared/utils.dart';
import 'package:simple_e_commerce/ui/views/home_view/home_view_controller.dart';

// ignore: must_be_immutable
class CustomCategoriesRow extends StatelessWidget {
  CustomCategoriesRow({super.key});

  HomeViewController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(homeController.allCategoryName.length, (index) {
          final textLength = homeController.allCategoryName[index].length;
          final buttonWidth = (textLength * (width * 0.03)) + width * 0.02;
          return Padding(
            padding: EdgeInsetsDirectional.only(
              start: 20.w,
              end:
                  homeController.allCategoryName.length == index + 1 ? 20.w : 0,
            ),
            child: CustomButton(
              buttonTypeEnum: ButtonTypeEnum.normal,
              width: buttonWidth > width * 0.15 ? buttonWidth : width * 0.19,
              backgroundColor:
                  homeController.selectedNum.value == index
                      ? homeController.clickButton.value
                      : AppColors.whiteColor,
              borderColor:
                  homeController.selectedNum.value == index
                      ? AppColors.whiteColor
                      : AppColors.colorBorder,
              text: homeController.allCategoryName[index],
              textColor:
                  homeController.selectedNum.value == index
                      ? AppColors.whiteColor
                      : AppColors.blackColor,
              onPressed: () {
                homeController.filterProductByCat(
                  index,
                  homeController.allCategoryName[index],
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
