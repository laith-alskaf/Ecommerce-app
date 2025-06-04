import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/utils/general_util.dart';
import 'package:simple_e_commerce/ui/shared/colors.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_app_bar.dart';
import 'package:simple_e_commerce/ui/views/customer/home/main_controller.dart';
import 'package:simple_e_commerce/ui/views/customer/home/products_view/products_view.dart';
import 'package:simple_e_commerce/ui/views/customer/home/wishlist_view/wishlist_view.dart';
import 'package:simple_e_commerce/ui/views/home_view/home_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  MainController controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        backgroundColor: AppColors.whiteColor,
        appBar: customAppBar(title: controller.selected, isMainView: true),
        resizeToAvoidBottomInset: false,
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.pageViewController,
          children: [ProductsView(), HomeView(), const WishlistView()],
        ),
        bottomNavigationBar: GetBuilder<MainController>(
          builder: (c) {
            return BottomBarInspiredOutside(
              height: 45.h,
              items: controller.items,
              backgroundColor: Colors.white,
              color: AppColors.mainColor,
              colorSelected: AppColors.whiteColor,
              indexSelected: controller.currentIndex,
              onTap: (int index) {
                if (index == 2 && !myAppController.hasPermissionToUse()) {
                  controller.currentIndex = 1;
                  controller.animatedToPage(controller.screens[1], 1);
                } else {
                  controller.currentIndex = index;
                  controller.animatedToPage(controller.screens[index], index);
                }
              },
              itemStyle: ItemStyle.circle,
              chipStyle: ChipStyle(
                background: AppColors.mainColor,
                notchSmoothness: NotchSmoothness.smoothEdge,
              ),
            );
          },
        ),
      ),
    );
  }
}
