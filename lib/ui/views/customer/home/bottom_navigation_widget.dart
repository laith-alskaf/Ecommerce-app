import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/enums/bottom_navigation.dart';
import 'package:simple_e_commerce/core/utils/general_util.dart';
import 'package:simple_e_commerce/ui/shared/colors.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({
    super.key,
    required this.bottomNavigationEnum,
    required this.onTap,
  });

  final BottomNavigationEnum bottomNavigationEnum;
  final Function(BottomNavigationEnum, int) onTap;

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          color: Colors.white,
          width: 1.sw,
          height: 0.07.sh,
          alignment: Alignment.bottomCenter,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 1.sw * 0.025,
              horizontal: 1.sw * 0.15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                navItem(
                  imageName: 'products',
                  isSelected:
                      widget.bottomNavigationEnum ==
                      BottomNavigationEnum.ALLPROUDUCTS,
                  onTap: () {
                    widget.onTap(BottomNavigationEnum.ALLPROUDUCTS, 0);
                  },
                ),
                navItem(
                  imageName: 'home',
                  isSelected:
                      widget.bottomNavigationEnum ==
                      BottomNavigationEnum.HOMEVIEW,
                  onTap: () {
                    widget.onTap(BottomNavigationEnum.HOMEVIEW, 1);
                  },
                ),
                Stack(
                  children: [
                    SizedBox(
                      child: navItem(
                        imageName: 'cart',
                        isSelected:
                            widget.bottomNavigationEnum ==
                            BottomNavigationEnum.CARTVIEW,
                        onTap: () {
                          widget.onTap(BottomNavigationEnum.CARTVIEW, 2);
                        },
                      ),
                    ),
                    Obx(
                      () =>
                          myAppController.numProdInCart.value != 0
                              ? Positioned(
                                right: 10.w,
                                bottom: 100.w,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.redcolor,
                                    borderRadius: BorderRadius.circular(35.r),
                                  ),
                                  padding: EdgeInsets.all(10.w),
                                  child: CustomText(
                                    textType: TextStyleType.bodyBig,
                                    text: "${myAppController.numProdInCart}",
                                    textColor: AppColors.whiteColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                              : const SizedBox(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget navItem({
    required String imageName,
    required bool isSelected,
    required Function onTap,
  }) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: SizedBox(
        width: 1.sw * 0.1,
        height: 1.sh * 0.042,
        child: SvgPicture.asset(
          'assets/images/$imageName.svg',
          color: isSelected ? AppColors.blueColor : AppColors.blackColor,
          width: 1.sw,
        ),
      ),
    );
  }
}
