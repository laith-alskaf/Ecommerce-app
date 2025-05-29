import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/enums/request_status.dart';
import 'package:simple_e_commerce/ui/shared/colors.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_grid.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_loading_spinkit.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text.dart';
import 'package:simple_e_commerce/ui/shared/extension_sizebox.dart';
import 'package:simple_e_commerce/ui/shared/utils.dart';
import 'package:simple_e_commerce/ui/views/customer/home/product_details_view/product_details_view.dart';
import 'package:simple_e_commerce/ui/views/home_view/home_view_controller.dart';
import 'package:simple_e_commerce/ui/views/home_view/home_view_widget/custom_categories_row.dart';

// ignore: must_be_immutable
class HomeView extends StatelessWidget {
  HomeView({super.key});

  HomeViewController homeController = Get.put(HomeViewController());

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
              Obx(
                () =>
                    homeController.allCategory.isEmpty &&
                            homeController.status.value == RequestStatus.LOADING
                        ? SliverToBoxAdapter(
                          child: Center(
                            child: SpinKitCircle(
                              size: 80.w,
                              color: AppColors.blueColor,
                            ),
                          ),
                        )
                        : homeController.allCategory.isEmpty &&
                            homeController.status.value == RequestStatus.DEFUALT
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
                    homeController.allProducts.isEmpty &&
                            homeController.status.value == RequestStatus.LOADING
                        ? SliverFillRemaining(
                          hasScrollBody: false,
                          child: showSpinKitLoading(),
                        )
                        : homeController.allProducts.isEmpty &&
                            homeController.status.value == RequestStatus.DEFUALT
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
                            height: 0.65.sh,
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.symmetric(vertical: 20.h),
                              child: Wrap(
                                alignment: WrapAlignment.spaceEvenly,
                                runSpacing: screenHeight(20),
                                children: List.generate(
                                  homeController.allProducts.length,
                                  (index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.to(
                                          () => ProductDetailsView(
                                            productDetails:
                                                homeController
                                                    .allProducts[index],
                                          ),
                                        );
                                      },
                                      child: CustomGrid(
                                        onFavoriteTap: () async {
                                          await homeController
                                              .addProductToWishlist(
                                                id:
                                                    homeController
                                                        .allProducts[index]
                                                        .id!,
                                              );
                                        },
                                        product:
                                            homeController.allProducts[index],
                                      ),
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
