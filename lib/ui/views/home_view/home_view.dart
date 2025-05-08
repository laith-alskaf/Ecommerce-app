import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/enums/request_status.dart';
import 'package:simple_e_commerce/ui/shared/colors.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_grid.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text.dart';
import 'package:simple_e_commerce/ui/shared/utils.dart';
import 'package:simple_e_commerce/ui/views/home_view/home_view_controller.dart';
import 'package:simple_e_commerce/ui/views/home_view/home_view_widget/custom_categories_row.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

HomeViewController homeController = Get.put(HomeViewController());

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: RefreshIndicator(
          onRefresh: () async {
            await Future.wait([
              homeController.getALlProducts(),
              homeController.getALlCategory(),
            ]);
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsetsDirectional.symmetric(vertical: 10.h),
                  child: CustomText(
                    text: 'Categories',
                    textColor: AppColors.mainColor,
                    fontWeight: FontWeight.bold,
                    textType: TextStyleType.title,
                    fontSize: 35.sp,
                    startPadding: 20.w,
                    topPadding: 20.w,
                    bottomPadding: 20.w,
                  ),
                ),
              ),
              Obx(
                () =>
                    homeController.status.value == RequestStatus.LOADING &&
                            homeController.allCategory.isEmpty
                        ? SliverToBoxAdapter(
                          child: Center(
                            child: SpinKitCircle(
                              size: 80.w,
                              color: AppColors.blueColor,
                            ),
                          ),
                        )
                        : homeController.allCategory.isEmpty
                        ? SliverToBoxAdapter(
                          child: Center(
                            child: CustomText(
                              text: 'Not found any Category',
                              textType: TextStyleType.title,
                            ),
                          ),
                        )
                        : SliverToBoxAdapter(child: CustomCategoriesRow()),
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Products',
                      textColor: AppColors.mainColor,
                      fontWeight: FontWeight.bold,
                      textType: TextStyleType.title,
                      fontSize: 35.sp,
                      startPadding: 20.w,
                      topPadding: 20.w,
                    ),
                  ],
                ),
              ),
              Obx(
                () =>
                    homeController.status.value == RequestStatus.LOADING
                        ? SliverFillRemaining(
                          hasScrollBody: false,
                          child: Center(
                            child: SpinKitCircle(
                              color: AppColors.blueColor,
                              size: 80.w,
                            ),
                          ),
                        )
                        : homeController.allProducts.isEmpty
                        ? SliverFillRemaining(
                          hasScrollBody: false,
                          child: Center(
                            child: CustomText(
                              text: 'Not found any product',
                              textType: TextStyleType.title,
                            ),
                          ),
                        )
                        : SliverToBoxAdapter(
                          child: SizedBox(
                            height: 0.75.sh,
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.symmetric(vertical: 20.h),
                              child: Wrap(
                                alignment: WrapAlignment.spaceEvenly,
                                runSpacing: screenHeight(20),
                                children: List.generate(
                                  homeController.allProducts.length,
                                  (index) {
                                    return CustomGrid(
                                      allProducts: homeController.allProducts,
                                      index: index,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
