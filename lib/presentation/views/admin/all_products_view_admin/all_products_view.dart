import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/enums/request_status.dart';
import 'package:simple_e_commerce/core/utils/colors.dart';
import 'package:simple_e_commerce/presentation/views/admin/all_products_view_admin/all_products_view_controller.dart';
import 'package:simple_e_commerce/presentation/views/admin/all_products_view_admin/home_view_widget/custom_categories_row.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_grid.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_text.dart';
import 'package:simple_e_commerce/core/utils/utils.dart';

// ignore: must_be_immutable
class AllProductsView extends StatelessWidget {
  AllProductsView({super.key});

  AllProductsViewController homeController = Get.put(
    AllProductsViewController(),
  );

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
          GetBuilder<AllProductsViewController>(
            builder: (c) {
              return homeController.allCategory.isEmpty &&
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
                  : SliverToBoxAdapter(child: CustomCategoriesRow());
            },
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
          GetBuilder<AllProductsViewController>(
            builder: (c) {
              return homeController.allProducts.isEmpty &&
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
                      height: 0.75.sh,
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.only(bottom: 35.h, top: 15.h),
                        child: Wrap(
                          alignment: WrapAlignment.spaceEvenly,
                          runSpacing: screenHeight(20),
                          children: List.generate(
                            homeController.allProducts.length,
                            (index) {
                              return CustomGrid(
                                product: homeController.allProducts[index],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  );
            },
          ),
        ],
      ),
    );
  }
}
