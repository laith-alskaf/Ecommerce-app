import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/enums/bottom_navigation.dart';
import 'package:simple_e_commerce/ui/shared/colors.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text.dart';
import 'package:simple_e_commerce/ui/views/customer/home/main_controller.dart';

class WishlistEmpty extends StatelessWidget {
  const WishlistEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_outline_rounded,
              size: 85.sp,
              color: AppColors.grayColor.withOpacity(0.6),
            ),
            SizedBox(height: 25.h),

            CustomText(
              text: "Your Wishlist is Waiting!",
              textType: TextStyleType.title,
              textColor: AppColors.blackColor.withOpacity(0.85),
              fontWeight: FontWeight.bold,
              isTextAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),

            CustomText(
              text:
                  "Tap the heart on any product to save it here. Your favorite items will appear once you've added them.",
              textType: TextStyleType.bodyBig,
              textColor: AppColors.grayColor.withOpacity(0.9),
              isTextAlign: TextAlign.center,
              maxLines: 3,
              heightText: 1.4,
            ),
            SizedBox(height: 35.h),
            ElevatedButton.icon(
              onPressed: () {
                if (Get.isRegistered<MainController>()) {
                  final mainController = Get.find<MainController>();
                  mainController.animatedToPage(BottomNavigationEnum.Home, 1);
                }
              },
              icon: Icon(
                Icons.explore_outlined,
                size: 22.sp,
                color: AppColors.whiteColor,
              ),
              label: CustomText(
                textType: TextStyleType.body,
                text: "Explore Products",
                textColor: AppColors.whiteColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.mainColor,
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.r),
                ),
                elevation: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
