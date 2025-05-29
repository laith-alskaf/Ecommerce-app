import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/enums/drawer_enum.dart';
import 'package:simple_e_commerce/ui/shared/colors.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text.dart';

class CustomDrawer extends StatelessWidget {
  final Rx<DrawerEnum> selectedItem;
  final Function(DrawerEnum) onTap;

  const CustomDrawer({
    super.key,
    required this.selectedItem,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.mainColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[buildHeader(context), buildMenuItems(context)],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) => Container(
    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        children: [
          // const CircleAvatar(
          //   radius: 50,
          //   backgroundImage: AssetImage("assets/images/ic_splash.png"),
          // ),
          SizedBox(height: 20.h),
          CustomText(
            text: 'Admin Name',
            textColor: AppColors.whiteColor,
            textType: TextStyleType.title,
          ),
          const SizedBox(height: 4),
          const CustomText(
            text: 'admin@admin.com',
            textColor: AppColors.whiteColor,
            textType: TextStyleType.body,
          ),
        ],
      ),
    ),
  );

  Widget buildMenuItems(BuildContext context) => Container(
    padding: EdgeInsets.all(24.w),
    child: Wrap(
      runSpacing: 10.w,
      children: [
        drawerItem(
          title: 'Dashboard',
          icon: Icons.dashboard,
          drawerItemEnum: DrawerEnum.dashboard,
        ),
        drawerItem(
          title: 'Manage Products',
          icon: Icons.production_quantity_limits,
          drawerItemEnum: DrawerEnum.products,
        ),
        drawerItem(
          title: 'Manage Orders',
          icon: Icons.shopping_cart,
          drawerItemEnum: DrawerEnum.orders,
        ),
        drawerItem(
          title: 'Manage Customers',
          icon: Icons.people,
          drawerItemEnum: DrawerEnum.customers,
        ),
        drawerItem(
          title: "Manage Categories",
          icon: Icons.category,
          drawerItemEnum: DrawerEnum.categories,
        ),

        drawerItem(
          title: "Manage Notifications",
          icon: Icons.notifications,
          drawerItemEnum: DrawerEnum.notifications,
        ),

        drawerItem(
          title: 'Logout',
          icon: Icons.logout,
          drawerItemEnum: DrawerEnum.logout,
        ),
      ],
    ),
  );

  Widget drawerItem({
    required String title,
    required IconData icon,
    required DrawerEnum drawerItemEnum,
  }) {
    return Obx(
      () => ListTile(
        leading: Icon(icon, color: AppColors.whiteColor),
        title: CustomText(
          text: title,
          textColor: AppColors.whiteColor,
          textType: TextStyleType.body,
        ),
        onTap: () {
          onTap(drawerItemEnum);
          Get.back();
        },
        selected: selectedItem.value == drawerItemEnum,
        selectedColor: AppColors.mainColor,
        // selectedTileColor: AppColors.whiteColor,
        selectedTileColor: AppColors.blackColor.withOpacity(0.4),
      ),
    );
  }
}
