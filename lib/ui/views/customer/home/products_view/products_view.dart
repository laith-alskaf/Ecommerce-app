import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/enums/request_status.dart';
import 'package:simple_e_commerce/ui/shared/colors.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_grid.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text_field.dart';
import 'package:simple_e_commerce/ui/shared/extension_sizebox.dart';
import 'package:simple_e_commerce/ui/shared/utils.dart';
import 'package:simple_e_commerce/ui/views/customer/home/products_view/products_view_controller.dart';

class ProductsView extends StatelessWidget {
  ProductsView({super.key});

  final ProductsViewController controller = Get.put(ProductsViewController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: RefreshIndicator(
          onRefresh: () async {
            await controller.getALlProducts();
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    (20.h).ph,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: CustomTextFormField(
                        heightContainer: 60.h,
                        hintText: 'Write here product title for search',
                        controller: controller.searchController,
                        colorBorder: AppColors.mainColor,
                        suffixIcon: 'ic_search',
                        suffixOnTap: () {
                          if (controller.searchController.text.isEmpty) {
                            controller.getALlProducts().then((v) {
                              controller.filteredProducts.clear();
                              controller.filteredProducts =
                                  controller.allProducts;
                            });
                          } else {
                            controller.getProducts(
                              title: controller.searchController.text,
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
              Obx(
                () =>
                    controller.status.value == RequestStatus.LOADING
                        ? SliverFillRemaining(
                          hasScrollBody: false,
                          child: Center(
                            child: SpinKitCircle(
                              color: AppColors.blueColor,
                              size: 60.w,
                            ),
                          ),
                        )
                        : controller.filteredProducts.isEmpty
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
                            height: 0.85.sh,
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.symmetric(vertical: 20.h),
                              child: Wrap(
                                alignment: WrapAlignment.spaceEvenly,
                                runSpacing: screenHeight(20),
                                children: List.generate(
                                  controller.filteredProducts.length,
                                  (index) {
                                    return CustomGrid(
                                      allProducts: controller.filteredProducts,
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
