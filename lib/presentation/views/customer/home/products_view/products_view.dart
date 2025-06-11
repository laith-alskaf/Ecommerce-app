import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/app/di/service_locator.dart';
import 'package:simple_e_commerce/core/enums/request_status.dart';
import 'package:simple_e_commerce/core/utils/colors.dart';
import 'package:simple_e_commerce/presentation/controllers/products/products_cubit.dart';
import 'package:simple_e_commerce/presentation/views/customer/home/product_details_view/product_details_view.dart';
import 'package:simple_e_commerce/presentation/views/customer/home/products_view/products_view_controller.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_grid.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_text.dart';
import 'package:simple_e_commerce/core/utils/extension_sizebox.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_text_field.dart';
import 'package:simple_e_commerce/core/utils/utils.dart';

class ProductsPageWrapper extends StatelessWidget {
  const ProductsPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProductsCubit>(),
      child: ProductsView(),
    );
  }
}

class ProductsView extends StatelessWidget {
   ProductsView({super.key});

  final ProductsViewController controller = Get.put(ProductsViewController());

  @override
  Widget build(BuildContext context) {
    // final controller = context.read<ProductsCubit>();
    return RefreshIndicator(
      onRefresh: () async {
        controller.searchController.clear();
        await controller.getALlProducts();
      },
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (10.h).ph,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: CustomTextFormField(
                    heightContainer: 60.h,
                    hintText: 'Write here product title for search',
                    controller: controller.searchController,
                    colorBorder: AppColors.mainColor,
                    prefixIcon: 'ic_search',
                    prefixOnTap: () {
                      if (controller.searchController.text.isEmpty) {
                        controller.getALlProducts().then((v) {
                          controller.filteredProducts.clear();
                          controller.filteredProducts = controller.allProducts;
                        });
                      } else {
                        controller.searchProducts(
                          title: controller.searchController.text,
                        );
                      }
                    },
                  ),
                ),
                (10.h).ph,
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
                        height: 0.75.sh,
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.only(bottom: 100.h),
                          child: Wrap(
                            alignment: WrapAlignment.spaceEvenly,
                            runSpacing: screenHeight(20),
                            children: List.generate(
                              controller.filteredProducts.length,
                              (index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      () => ProductDetailsView(
                                        productDetails:
                                            controller.filteredProducts[index],
                                      ),
                                    );
                                  },
                                  child: CustomGrid(
                                    onFavoriteTap: () async {
                                      await controller.addProductToWishlist(
                                        id: controller.allProducts[index].id!,
                                      );
                                    },
                                    product: controller.filteredProducts[index],
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
    );
  }
}
