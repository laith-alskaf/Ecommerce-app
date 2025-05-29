import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_e_commerce/core/data/models/api/product_model.dart';
import 'package:simple_e_commerce/ui/shared/colors.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_cached_image.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text.dart';

class WishlistItemCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onRemoveFromWishlist;
  final VoidCallback? onAddToCart;
  final Function()? onTapCard;

  const WishlistItemCard({
    super.key,
    required this.product,
    required this.onRemoveFromWishlist,
    this.onAddToCart,
    this.onTapCard,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapCard,
      child: Card(
        elevation: 3.0, // ظل خفيف للبطاقة
        margin: EdgeInsets.zero, // الـ ListView.separated سيهتم بالمسافات
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Container(
          padding: EdgeInsets.all(12.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomCachedImage(
                image:
                (product.images != null &&
                    product.images!.isNotEmpty)
                    ? product.images![0]
                    : 'https://via.placeholder.com/100x100/F0F0F0/AAAAAA?text=No+Image',
                widthCircularProgress: 20.w,
                heightCircularProgress: 20.w,
                borderRadius: BorderRadius.circular(8.r),
                heightImage: 90.w,
                widthImage: 90.w,
              ),
              SizedBox(width: 12.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: product.title ?? 'No Title',
                      textType: TextStyleType.bodyBig,
                      // أو subtitle
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      textColor: AppColors.blackColor.withOpacity(0.85),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6.h),

                    CustomText(
                      text:
                          product.price != null
                              ? '${product.price!.toStringAsFixed(2)} \$'
                              : 'N/A',
                      textType: TextStyleType.bodyBig,
                      // أو subtitle
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      textColor: AppColors.mainColor,
                    ),
                    SizedBox(height: 10.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (onAddToCart != null)
                          TextButton.icon(
                            onPressed: onAddToCart,
                            icon: Icon(
                              Icons.add_shopping_cart_rounded,
                              size: 20.sp,
                              color: AppColors.blueColor,
                            ),
                            label: CustomText(
                              textType: TextStyleType.custom,
                              text: "Add to Cart",
                              textColor: AppColors.blueColor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 5.h,
                              ),
                              tapTargetSize:
                                  MaterialTapTargetSize
                                      .shrinkWrap,
                            ),
                          ),
                        if (onAddToCart != null) SizedBox(width: 8.w),
                        IconButton(
                          icon: Icon(
                            Icons.delete_outline_rounded,
                            size: 22.sp,
                            color: AppColors.redcolor.withOpacity(0.8),
                          ),
                          onPressed: onRemoveFromWishlist,
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          tooltip: "Remove from wishlist",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
