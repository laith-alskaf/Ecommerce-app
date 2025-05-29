import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/data/models/api/user_model.dart';
import 'package:simple_e_commerce/core/enums/request_status.dart';
import 'package:simple_e_commerce/ui/shared/colors.dart';
import 'package:simple_e_commerce/ui/shared/extension_sizebox.dart';
import 'package:simple_e_commerce/ui/views/admin/dashboard_view/dashboard_controller.dart';
import 'package:simple_e_commerce/ui/views/admin/dashboard_view/my_products_view/my_products_view.dart';

import 'custom_widget_dashboard/custom_container_action.dart';

// ignore: must_be_immutable
class DashboardView extends StatelessWidget {
  const DashboardView({super.key, required this.userInfo});

  final UserModel userInfo;

  @override
  Widget build(BuildContext context) {
    DashboardController controller = Get.put(DashboardController());
    controller.setUserInfo(userInfo);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
      child: RefreshIndicator(
        child: ListView(
          children: [
            (10.h).ph,
            GetBuilder<DashboardController>(
              builder: (controller) {
                return controller.status.value == RequestStatus.LOADING
                    ? Padding(
                      padding: EdgeInsets.only(top: 0.35.sh),
                      child: SpinKitCircle(
                        color: AppColors.mainColor,
                        size: 80.w,
                      ),
                    )
                    : Wrap(
                      alignment: WrapAlignment.center,
                      runAlignment: WrapAlignment.start,
                      spacing: 30.w,
                      runSpacing: 30.w,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            Get.to(() => MyProductsView());
                          },
                          child: CustomContainerAction(
                            title: 'My Products',
                            createdNumber: controller.totalProducts.toString(),
                          ),
                        ),
                        CustomContainerAction(
                          title: 'Total Orders',
                          createdNumber: '20',
                        ),
                        CustomContainerAction(
                          title: 'Total Revenue',
                          createdNumber: '\$5000',
                        ),
                      ],
                    );
              },
            ),
          ],
        ),
        onRefresh: () async {
          controller.onInit();
        },
      ),
    );
  }
}
