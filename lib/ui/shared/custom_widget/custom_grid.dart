import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_e_commerce/core/data/models/api/product_model.dart';
import 'package:simple_e_commerce/ui/shared/colors.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text.dart';
import 'package:simple_e_commerce/ui/shared/extension_sizebox.dart';
import 'package:simple_e_commerce/ui/shared/utils.dart';

class CustomGrid extends StatelessWidget {
  CustomGrid({super.key, required this.allProducts, required this.index});

  List<ProductModel> allProducts = <ProductModel>[];
  int index = -1;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: InkWell(
        onTap: () {
          // Get.to(()=>ProductdetailsView( product: allProducts[index],));
        },
        child: Container(
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              (10.h).ph,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Center(
                  child: Image.network(
                    "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
                    height: 80.h,
                    fit: BoxFit.contain,
                    width: screenWidth(1),
                  ),
                ),
              ),
              (10.h).ph,
              CustomText(
                text: allProducts[index].title.toString(),
                textColor: AppColors.blackColor,
                isTextAlign: TextAlign.left,
                fontSize: screenWidth(28),
                textType: TextStyleType.custom,
                endPadding: screenWidth(30),
                fontWeight: FontWeight.bold,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: 'Price : ',
                    textType: TextStyleType.custom,
                    startPadding: 10.w,
                    fontWeight: FontWeight.bold,
                    endPadding: screenWidth(27),
                    textColor: AppColors.blueColor,
                    bottomPadding: 10.h,
                    fontSize: screenWidth(24),
                  ),
                  CustomText(
                    textType: TextStyleType.custom,
                    text: allProducts[index].price.toString(),
                    textColor: AppColors.blackColor,
                    bottomPadding: 10.h,
                    fontSize: screenWidth(24),
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
