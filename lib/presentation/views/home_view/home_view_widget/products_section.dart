import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_e_commerce/app/di/service_locator.dart';
import 'package:simple_e_commerce/core/enums/request_status.dart';
import 'package:simple_e_commerce/presentation/controllers/products/products_cubit.dart';
import 'package:simple_e_commerce/presentation/controllers/products/products_state.dart';
import 'package:simple_e_commerce/presentation/views/customer/home/product_details_view/product_details_view.dart';
import 'package:simple_e_commerce/presentation/views/home_view/home_view_controller.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_button.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_grid.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_loading_spinkit.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_text.dart';
import 'package:simple_e_commerce/core/utils/extension_sizebox.dart';
import 'package:simple_e_commerce/core/utils/utils.dart';

class ProductsSection extends StatelessWidget {
  const ProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final productsCubit = sl<ProductsCubit>();
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state is ProductsLoading || state is ProductsInitial) {
          return SizedBox(height: 100, child: showSpinKitLoading());
        } else if (state is ProductsLoaded) {
          if (state.products.isEmpty || state is ProductsError) {
            return Column(
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
                    await productsCubit.fetchProducts();
                  },
                ),
              ],
            );
          }
          return SizedBox(
            height: 0.68.sh,
            child: SingleChildScrollView(
              controller: productsCubit.scrollController,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Wrap(
                alignment: WrapAlignment.spaceEvenly,
                runSpacing: screenHeight(20),
                children: List.generate(state.products.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(
                        () => ProductDetailsView(
                          productDetails: state.products[index],
                        ),
                      );
                    },
                    child: CustomGrid(
                      onFavoriteTap: () async {
                        // await productsCubit.addProductToWishlist(
                        //   id: productsCubit.products[index].id!,
                        // );
                      },
                      product: state.products[index],
                    ),
                  );
                }),
              ),
            ),
          );
        } else if (state is ProductsError) {
          return SizedBox(
            height: 100,
            child: Center(child: Text("Error: ${state.message}")),
          );
        }
        return const SizedBox(height: 100);
      },
    );
  }
}
