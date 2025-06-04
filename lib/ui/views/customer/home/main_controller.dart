import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/enums/bottom_navigation.dart';
import 'package:simple_e_commerce/core/utils/general_util.dart';

class MainController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final drawerKey = GlobalKey<DrawerControllerState>();
  RxInt lengthList = 0.obs;
  int currentIndex = 1;
  var selected = BottomNavigationEnum.Home.obs;
  PageController pageViewController = PageController(initialPage: 1);
  List screens = [
    BottomNavigationEnum.Products,
    BottomNavigationEnum.Home,
    BottomNavigationEnum.CartView,
  ];
  List<TabItem> items = [
    TabItem(icon: Icons.search_sharp, title: 'Products'),
    TabItem(
      icon: Icons.home,
      title: 'Home',
    ),
    TabItem(icon: Icons.favorite_border, title: 'Wishlist'),
  ];

  void animatedToPage(selectedEnum, pageNumber) {
    pageNumber;

    pageViewController.animateToPage(
      pageNumber,
      duration: const Duration(microseconds: 500),
      curve: Curves.easeInCirc,
    );
    selected.value = selectedEnum;
    update();
  }

  Future initNotification() async {
    if (storage.getRole() == 'customer') {
      await notificationService.subscribeToTopicNewProduct(
        subscribeToTopic: 'new_product',
      );
    }
  }

  @override
  void onReady() async {
    super.onReady();
    await initNotification();
  }
}
