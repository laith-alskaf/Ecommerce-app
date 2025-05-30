import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/ui/shared/colors.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_app_bar.dart';
import 'package:simple_e_commerce/ui/views/customer/home/bottom_navigation_widget.dart';
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
        backgroundColor: AppColors.whiteColor,
        appBar: customAppBar(title: controller.selected,isMainView: true),
        resizeToAvoidBottomInset: false,
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.pageViewController,
          children: [ProductsView(), HomeView(), const WishlistView()],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationWidget(
            bottomNavigationEnum: controller.selected.value,
            onTap: (selectedEnum, pageNumber) {
              controller.animatedToPage(selectedEnum, pageNumber);
            },
          ),
        ),
      ),
    );
  }
}
