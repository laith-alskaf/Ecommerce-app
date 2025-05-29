import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/data/models/api/user_model.dart';
import 'package:simple_e_commerce/core/enums/drawer_enum.dart';
import 'package:simple_e_commerce/core/services/base_controller.dart';
import 'package:simple_e_commerce/core/utils/general_util.dart';
import 'package:simple_e_commerce/ui/views/admin/all_products_view_admin/all_products_view.dart';
import 'package:simple_e_commerce/ui/views/admin/dashboard_view/dashboard_view.dart';

class HomeViewAdminController extends BaseController {
  Rx<DrawerEnum> selectedItem = DrawerEnum.products.obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Widget showingWidget = AllProductsView();
  late UserModel userInfo;

  handleSelectDrawer({required DrawerEnum selectDrawer}) async {
    switch (selectDrawer) {
      case DrawerEnum.dashboard:
        selectedItem.value = DrawerEnum.dashboard;
        showingWidget = DashboardView(userInfo: userInfo);
      case DrawerEnum.categories:
        selectedItem.value = DrawerEnum.categories;
      case DrawerEnum.products:
        selectedItem.value = DrawerEnum.products;
        showingWidget = AllProductsView();
      case DrawerEnum.orders:
        selectedItem.value = DrawerEnum.orders;
      case DrawerEnum.customers:
        selectedItem.value = DrawerEnum.customers;
      case DrawerEnum.notifications:
        selectedItem.value = DrawerEnum.notifications;
      case DrawerEnum.logout:
        selectedItem.value = DrawerEnum.logout;
        await logout();
    }
    update();
  }

  @override
  void onInit() {
    userInfo = storage.getUserinfo();

    super.onInit();
  }
}
