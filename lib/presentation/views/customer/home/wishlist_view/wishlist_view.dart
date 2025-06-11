import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/data/models/api/product_model.dart';
import 'package:simple_e_commerce/core/enums/request_status.dart';
import 'package:simple_e_commerce/core/utils/colors.dart';
import 'package:simple_e_commerce/presentation/views/customer/home/product_details_view/product_details_view.dart';
import 'package:simple_e_commerce/presentation/views/customer/home/wishlist_view/wishlist_controller.dart';
import 'package:simple_e_commerce/presentation/views/customer/home/wishlist_view/wishlist_widget/wishlist_empty.dart';
import 'package:simple_e_commerce/presentation/views/customer/home/wishlist_view/wishlist_widget/wishlist_item_card.dart';
import 'package:simple_e_commerce/core/utils/extension_sizebox.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_loading_spinkit.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    WishlistController controller = Get.put(WishlistController());
    controller.onInit();
    return GetBuilder<WishlistController>(
      builder: (c) {
        return Scaffold(
          backgroundColor: AppColors.whiteColor,
          floatingActionButton:
              controller.wishlistItems.isEmpty
                  ? null
                  : GestureDetector(
                    onTap: () {
                      controller.removeAllFromWishlist();
                    },
                    child: Container(
                      width: 70.w,
                      height: 70.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.mainColor.withOpacity(0.6),
                      ),
                      child: Icon(
                        Icons.cleaning_services_outlined,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
          body:
              controller.status.value == RequestStatus.LOADING
                  ? showSpinKitLoading()
                  : controller.wishlistItems.isEmpty &&
                      controller.status.value == RequestStatus.DEFUALT
                  ? WishlistEmpty()
                  : ListView.separated(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 20.h,
                    ),
                    itemCount: controller.wishlistItems.length,
                    itemBuilder: (context, index) {
                      final ProductModel product =
                          controller.wishlistItems[index];
                      return WishlistItemCard(
                        onTapCard: () {
                          Get.to(
                            () => ProductDetailsView(productDetails: product),
                          );
                        },
                        product: product,
                        onRemoveFromWishlist: () {
                          controller.removeFromWishlist(id: product.id!);
                        },
                        onAddToCart: () {},
                      );
                    },
                    separatorBuilder:
                        (context, index) =>
                        (15.h).ph
                  ),
        );
      },
    );
  }
}
