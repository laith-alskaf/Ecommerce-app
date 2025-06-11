import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/enums/request_status.dart';
import 'package:simple_e_commerce/core/utils/colors.dart';
import 'package:simple_e_commerce/presentation/views/admin/dashboard_view/dashboard_controller.dart';
import 'package:simple_e_commerce/presentation/views/admin/dashboard_view/my_products_view/dialog_add_item.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_grid.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_text.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_text_field.dart';
import 'package:simple_e_commerce/core/utils/extension_sizebox.dart';
import 'package:simple_e_commerce/core/utils/utils.dart';

class MyProductsView extends StatelessWidget {
  const MyProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardController controller = Get.find();
    return SafeArea(
      child: Scaffold(
        floatingActionButton: GestureDetector(
          onTap: () {
            controller.initFieldAddProduct();
            showDialogAddItem(controller: controller);
          },
          child: Container(
            height: 80.w,
            width: 80.w,
            decoration: BoxDecoration(
              color: AppColors.mainColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(50.r),
            ),
            child: Icon(Icons.add_outlined, size: 40.w),
          ),
        ),
        backgroundColor: AppColors.whiteColor,
        body: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'My Products',
                  textColor: AppColors.mainColor,
                  fontWeight: FontWeight.bold,
                  textType: TextStyleType.title,
                  fontSize: 35.sp,
                  startPadding: 20.w,
                  topPadding: 20.w,
                  bottomPadding: 20.w,
                ),
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
                        controller.getALlProductsMine();
                      } else {
                        controller.searchProducts(
                          title: controller.searchController.text,
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: 10.h),
              ],
            ),
            GetBuilder<DashboardController>(
              builder: (c) {
                return controller.status.value == RequestStatus.LOADING
                    ? Padding(
                      padding: EdgeInsets.only(top: 0.3.sh),
                      child: Center(
                        child: SpinKitCircle(
                          color: AppColors.blueColor,
                          size: 80.w,
                        ),
                      ),
                    )
                    : controller.productsMine.isEmpty
                    ? Padding(
                      padding: EdgeInsets.only(top: 0.3.sh),
                      child: Center(
                        child: CustomText(
                          text: 'Not found any product',
                          textType: TextStyleType.title,
                        ),
                      ),
                    )
                    : SizedBox(
                      height: 0.85.sh,
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.only(bottom: 100.h),
                        child: Wrap(
                          alignment: WrapAlignment.spaceEvenly,
                          runSpacing: screenHeight(20),
                          children: List.generate(
                            controller.productsMine.length,
                            (index) {
                              return CustomGrid(
                                product: controller.productsMine[index],
                                onTapDelete: () {
                                  controller.deleteProduct(
                                    product: controller.productsMine[index],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
