import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/ui/shared/colors.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text.dart';
import 'package:simple_e_commerce/ui/views/home_view/home_view_controller.dart';
import 'package:simple_e_commerce/ui/views/home_view/home_view_widget/categories_section.dart';
import 'package:simple_e_commerce/ui/views/home_view/home_view_widget/products_section.dart';

// ignore: must_be_immutable
class HomeView extends StatelessWidget {
  HomeView({super.key});

  HomeViewController homeController = Get.put(HomeViewController());

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.wait([
          homeController.getALlProducts(),
          homeController.getALlCategory(),
        ]);
      },
      child: CustomScrollView(
        // controller: homeController.scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsetsDirectional.symmetric(vertical: 10.h),
              child: Row(
                children: [
                  CustomText(
                    text: 'Categories',
                    textColor: AppColors.mainColor,
                    fontWeight: FontWeight.bold,
                    textType: TextStyleType.title,
                    fontSize: 35.sp,
                    startPadding: 20.w,
                    topPadding: 20.w,
                    bottomPadding: 20.w,
                  ),
                ],
              ),
            ),
          ),
          CategoriesSection(homeController: homeController),
          SliverToBoxAdapter(
            child: CustomText(
              text: 'Products',
              textColor: AppColors.mainColor,
              fontWeight: FontWeight.bold,
              textType: TextStyleType.title,
              fontSize: 35.sp,
              startPadding: 20.w,
              topPadding: 20.w,
            ),
          ),
          ProductsSection(homeController: homeController),
        ],
      ),
    );
  }
}
