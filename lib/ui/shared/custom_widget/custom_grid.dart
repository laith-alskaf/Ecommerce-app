import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_e_commerce/core/data/models/api/product_model.dart';
import 'package:simple_e_commerce/core/utils/colors.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_cached_image.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/show_alert_snackbar.dart';
import 'package:simple_e_commerce/ui/shared/utils.dart';

// ignore: must_be_immutable
class CustomGrid extends StatelessWidget {
  const CustomGrid({
    super.key,
    required this.product,
    this.onTapDelete,
    this.onFavoriteTap,
    this.isFavorite = false,
  });

  final ProductModel product;
  final Function? onTapDelete;
  final Function()? onFavoriteTap;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: screenHeight(7),
        maxWidth: screenWidth(2.2),
        minWidth: screenWidth(2.2),
        maxHeight: screenHeight(2.6),
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.all(Radius.circular(screenWidth(30))),
        border: Border.all(
          color: AppColors.colorBorder,
          width: screenWidth(150),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 6,
            child: Stack(
              children: [
                Hero(
                  tag: 'product_image_${product.id}_main',
                  child: CustomCachedImage(
                    image:
                        product.images != null && product.images!.isNotEmpty
                            ? product.images![0]
                            : 'https://via.placeholder.com/200x200/F0F0F0/AAAAAA?text=No+Image',
                    widthCircularProgress: 25.w,
                    heightCircularProgress: 25.w,
                  ),
                ),

                if (onTapDelete != null)
                  Positioned(
                    top: 5.w,
                    left: 5.w,
                    child: Material(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20.r),
                      child: InkWell(
                        onTap: () {
                          showAlertDelete(
                            text:
                                'Are you sure you want to delete this product?',
                            ontap: onTapDelete!,
                          );
                        },
                        borderRadius: BorderRadius.circular(20.r),
                        child: Padding(
                          padding: EdgeInsets.all(6.w),
                          child: Icon(
                            Icons.delete_outline,
                            color: Colors.white,
                            size: 18.sp,
                          ),
                        ),
                      ),
                    ),
                  ),

                if (onFavoriteTap != null)
                  Positioned(
                    top: 5.w,
                    right: 5.w,
                    child: Material(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20.r),
                      child: InkWell(
                        onTap: onFavoriteTap,
                        borderRadius: BorderRadius.circular(20.r),
                        child: Padding(
                          padding: EdgeInsets.all(6.w),
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.redAccent : Colors.white,
                            size: 18.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: product.title ?? 'Untitled Product',
                    textColor: AppColors.blackColor.withOpacity(0.85),
                    textType: TextStyleType.body,
                    fontWeight: FontWeight.w600,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  CustomText(
                    text: product.price != null ? '${product.price} \$' : 'N/A',
                    textColor: AppColors.mainColor,
                    textType: TextStyleType.body,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
