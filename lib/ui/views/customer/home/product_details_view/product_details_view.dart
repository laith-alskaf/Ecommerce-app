import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/data/models/api/product_model.dart';
import 'package:simple_e_commerce/ui/shared/colors.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_button.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_cached_image.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text.dart';
import 'package:simple_e_commerce/ui/shared/extension_sizebox.dart';
import 'package:simple_e_commerce/ui/shared/utils.dart';
import 'package:simple_e_commerce/ui/views/customer/home/product_details_view/product_details_controller.dart';
import 'package:simple_e_commerce/ui/views/customer/home/product_details_view/product_details_widget/custom_title.dart';

class ProductDetailsView extends StatelessWidget {
  ProductDetailsView({super.key, required this.productDetails});

  final ProductModel productDetails;

  @override
  Widget build(BuildContext context) {
    ProductDetailsController controller = Get.put(ProductDetailsController());
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        width: double.infinity,
        height: screenWidth(5),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.mainColor,
              spreadRadius: 0.5,
              blurRadius: 2,
              offset: Offset(0.5, 0.5),
            ),
          ],
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(screenWidth(20)),
            topLeft: Radius.circular(screenWidth(20)),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth(20)),
          child: Obx(
            () => Row(
              children: [
                CustomButton(
                  buttonTypeEnum: ButtonTypeEnum.custom,
                  text: 'Add To Cart',
                  // textSize: screenWidth(19),
                  textColor: AppColors.whiteColor,
                  width: screenWidth(2.5),
                  backgroundColor: AppColors.mainColor,
                  height: screenWidth(10),
                  onPressed: () {
                    // controller.addToCart();
                  },
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    // if (controller.countProduct.value != 0) {
                    //   controller.changeCount(incress: false);
                    // }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: screenWidth(10),
                    height: screenWidth(10),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                    child: CustomText(
                      textType: TextStyleType.body,
                      text: '-',
                      textColor: AppColors.whiteColor,
                    ),
                  ),
                ),
                (screenWidth(40)).pw,
                CustomText(
                  textType: TextStyleType.body,
                  text: controller.countProduct.value.toString(),
                ),
                (screenWidth(40)).pw,
                GestureDetector(
                  onTap: () {
                    // controller.changeCount(incress: true);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: screenWidth(10),
                    height: screenWidth(10),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                    child: CustomText(
                      textType: TextStyleType.body,
                      text: '+',
                      textColor: AppColors.whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: AppColors.whiteColor),
          onPressed: () => Get.back(),
        ),
        title: CustomText(
          text: productDetails.title ?? 'Product Details',
          textType: TextStyleType.subtitle,
          textColor: AppColors.whiteColor,
          fontWeight: FontWeight.w600,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          Obx(
            () => IconButton(
              icon: Icon(
                controller.isProductFavorite.value
                    ? Icons.favorite
                    : Icons.favorite_border,
                color:
                    controller.isProductFavorite.value
                        ? AppColors.redcolor
                        : AppColors.whiteColor,
                size: 26.sp,
              ),
              onPressed: () {
                controller.toggleFavoriteStatus(productDetails);
              },
            ),
          ),
          SizedBox(width: 10.w),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'product_image_${productDetails.id}_main',
              child: Container(
                height: 280.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(25.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: CustomCachedImage(
                  image:
                      (productDetails.images != null &&
                              productDetails.images!.isNotEmpty)
                          ? productDetails.images![0]
                          : 'https://via.placeholder.com/100x100/F0F0F0/AAAAAA?text=No+Image',
                  widthCircularProgress: 30.w,
                  heightCircularProgress: 30.w,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(25.r),
                  ),
                ),
              ),
            ),
            (20.h).ph,
            CustomTitle(title: 'Description:'),
            CustomText(
              text:
                  productDetails.description?.isNotEmpty == true
                      ? productDetails.description!
                      : 'No description available for this product.',
              textType: TextStyleType.body,
              textColor: AppColors.grayColor.withOpacity(0.9),
              heightText: 1.6,
            ),
            (20.h).ph,
            CustomTitle(title: 'Category:'),

            //TODO You Should add category name in response
            Container(
              margin: EdgeInsets.only(left: 20.w),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppColors.mainColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: AppColors.mainColor.withOpacity(0.3),
                  width: 0.8,
                ),
              ),
              child: CustomText(
                text: "Not specified",
                textType: TextStyleType.bodyBig,
                fontSize: 15.sp,
                textColor: AppColors.mainColor.withOpacity(0.9),
                fontWeight: FontWeight.w500,
              ),
            ),
            (20.h).ph,
            CustomTitle(title: 'Price:'),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                CustomText(
                  startPadding: 20.w,
                  text:
                      productDetails.price != null
                          ? productDetails.price!.toStringAsFixed(2)
                          : 'Price N/A',
                  textType: TextStyleType.subtitle,
                  fontWeight: FontWeight.bold,
                  textColor: AppColors.mainColor.withOpacity(0.8),
                ),
                SizedBox(width: 5.w),
                CustomText(
                  bottomPadding: 4.h,
                  text: '\$',
                  textType: TextStyleType.small,
                  fontWeight: FontWeight.w600,
                  textColor: AppColors.mainColor.withOpacity(0.8),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
