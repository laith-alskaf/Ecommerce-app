import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/state_manager.dart';
import 'package:simple_e_commerce/core/enums/request_status.dart';
import 'package:simple_e_commerce/core/utils/colors.dart';
import 'package:simple_e_commerce/presentation/views/admin/all_products_view_admin/home_view_widget/custom_categories_row.dart';
import 'package:simple_e_commerce/presentation/views/home_view/home_view_controller.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text.dart';

class CategoriesSection extends StatelessWidget {
  final HomeViewController homeController;

  const CategoriesSection({super.key, required this.homeController});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>
          homeController.allCategory.isEmpty &&
                  homeController.status.value == RequestStatus.LOADING
              ? SliverToBoxAdapter(
                child: Center(
                  child: SpinKitCircle(size: 80.w, color: AppColors.blueColor),
                ),
              )
              : homeController.allCategory.isEmpty &&
                  homeController.status.value == RequestStatus.DEFUALT
              ? SliverToBoxAdapter(
                child: Center(
                  child: CustomText(
                    text: 'Not found any Category',
                    textType: TextStyleType.title,
                  ),
                ),
              )
              : SliverToBoxAdapter(child: CustomCategoriesRow()),
    );
  }
}
