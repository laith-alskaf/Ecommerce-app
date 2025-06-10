import 'package:flutter/material.dart';
import 'package:simple_e_commerce/core/utils/colors.dart';
import 'package:simple_e_commerce/presentation/views/admin/home_view_admin/home_view_admin_controller.dart';
import 'package:simple_e_commerce/presentation/views/admin/widget_drawer/widget_drawer.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text.dart';

// ignore: must_be_immutable
class HomeViewAdmin extends StatelessWidget {
  HomeViewAdmin({super.key});

  HomeViewAdminController controller = Get.put(HomeViewAdminController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: controller.scaffoldKey,
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          leading: IconButton(
            icon: const Icon(Icons.menu, color: AppColors.whiteColor),
            onPressed: () {
              controller.scaffoldKey.currentState?.openDrawer();
            },
          ),
          title: const CustomText(
            text: 'Admin',
            textType: TextStyleType.title,
            textColor: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.whiteColor,
        drawer: CustomDrawer(
          selectedItem: controller.selectedItem,
          onTap: (selectDrawer) {
            controller.handleSelectDrawer(selectDrawer: selectDrawer);
          },
        ),
        body: GetBuilder<HomeViewAdminController>(
          builder: (controller) {
            return controller.showingWidget;
          },
        ),
      ),
    );
  }
}
