import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/ui/views/customer/home/bottom_navigation_widget.dart';
import 'package:simple_e_commerce/ui/views/customer/home/cart_view/cart_view.dart';
import 'package:simple_e_commerce/ui/views/customer/home/main_controller.dart';
import 'package:simple_e_commerce/ui/views/customer/home/products_view/products_view.dart';
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageViewController,
        children: [ProductsView(), const HomeView(), const CartView()],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationWidget(
          bottomNavigationEnum: controller.selected.value,
          onTap: (selectedEnum, pageNumber) {
            controller.animatedToPage(selectedEnum, pageNumber);
          },
        ),
      ),
    );
  }
}
