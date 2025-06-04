import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_e_commerce/core/enums/request_status.dart';
import 'package:simple_e_commerce/ui/shared/colors.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_button.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_grid.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_loading_spinkit.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text.dart';
import 'package:simple_e_commerce/ui/shared/extension_sizebox.dart';
import 'package:simple_e_commerce/ui/shared/utils.dart';
import 'package:simple_e_commerce/ui/views/customer/home/product_details_view/product_details_view.dart';
import 'package:simple_e_commerce/ui/views/home_view/home_view_controller.dart';
import 'package:get/get.dart';

class ProductsSection extends StatelessWidget {
  final HomeViewController homeController;

  const ProductsSection({super.key, required this.homeController});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>
          homeController.allProducts.isEmpty &&
                  homeController.status.value == RequestStatus.LOADING
              ? SliverFillRemaining(
                hasScrollBody: false,
                child: Column(children: [(0.25.sh).ph, showSpinKitLoading()]),
              )
              : homeController.allProducts.isEmpty &&
                  homeController.status.value == RequestStatus.DEFUALT
              ? SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    CustomText(
                      topPadding: 0.25.sh,
                      text: 'Not found any product',
                      textType: TextStyleType.title,
                    ),
                    (10.h).ph,
                    CustomButton(
                      text: 'Retry'.tr,
                      buttonTypeEnum: ButtonTypeEnum.normal,
                      onPressed: () async {
                        await homeController.getALlProducts();
                      },
                    ),
                  ],
                ),
              )
              : SliverToBoxAdapter(
                child: SizedBox(
                  height: 0.68.sh,
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
                                      homeController.allProducts[index],
                                ),
                              );
                            },
                            child: CustomGrid(
                              onFavoriteTap: () async {
                                await homeController.addProductToWishlist(
                                  id: homeController.allProducts[index].id!,
                                );
                              },
                              product: homeController.allProducts[index],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
    );
  }
}
