import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/enums/bottom_navigation.dart';
import 'package:simple_e_commerce/core/services/background_message_handler_service.dart';
import 'package:simple_e_commerce/core/utils/general_util.dart';

class MainController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final drawerKey = GlobalKey<DrawerControllerState>();
  RxInt lengthList = 0.obs;
  RxInt currentIndex = 1.obs;
  var selected = BottomNavigationEnum.Home.obs;
  PageController pageViewController = PageController(initialPage: 1);

  void animatedToPage(selectedEnum, pageNumber) {
    pageNumber;

    pageViewController.animateToPage(
      pageNumber,
      duration: const Duration(microseconds: 500),
      curve: Curves.easeInCirc,
    );

    selected.value = selectedEnum;
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
