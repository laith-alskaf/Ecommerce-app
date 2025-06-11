import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/enums/bottom_navigation.dart';
import 'package:simple_e_commerce/core/enums/request_status.dart';
import 'package:simple_e_commerce/core/utils/colors.dart';
import 'package:simple_e_commerce/presentation/views/customer/home/profile_view/profile_controller.dart';
import 'package:simple_e_commerce/presentation/views/customer/home/profile_view/profile_widget/custom_language_selectore.dart';
import 'package:simple_e_commerce/presentation/views/customer/home/profile_view/profile_widget/custom_title_profile.dart';
import 'package:simple_e_commerce/presentation/views/customer/home/profile_view/profile_widget/list_divider.dart';
import 'package:simple_e_commerce/presentation/views/customer/home/profile_view/profile_widget/menu_profile_item.dart';
import 'package:simple_e_commerce/presentation/views/customer/home/profile_view/profile_widget/user_profile_header.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_app_bar.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_text.dart';
import 'package:simple_e_commerce/core/utils/extension_sizebox.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: customAppBar(
        title: BottomNavigationEnum.Profile.name,
        isMainView: false,
      ),
      body: Obx(() {
        final user = controller.currentUser.value;
        final status = controller.requestStatus.value;

        if (status == RequestStatus.LOADING && user == null) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.mainColor),
          );
        }

        return RefreshIndicator(
          onRefresh: () => controller.loadUserProfile(),
          color: AppColors.mainColor,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                customUserProfileHeader(user!, controller),

                (20.h).ph,

                customTitleProfile("App Settings"),
                customProfileMenuItem(
                  iconData: Icons.person_outline_rounded,
                  text: 'Edit Profile',
                  onTap: () => controller.editProfile(),
                ),
                customProfileMenuItem(
                  iconData: Icons.lock_outline_rounded,
                  text: 'Change Password',
                  onTap: () => controller.changePassword(),
                ),

                customListDivider(),

                customTitleProfile('Preferences'),
                customLanguageSelector(controller),

                customListDivider(),

                customTitleProfile('Support & Info'),
                customProfileMenuItem(
                  iconData: Icons.contact_support_outlined,
                  text: 'Contact Us',
                  onTap: () => controller.contactUs(),
                ),
                customProfileMenuItem(
                  iconData: Icons.info_outline_rounded,
                  text: 'About App',
                  onTap: () => controller.aboutApp(),
                ),

                customListDivider(),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 25.h,
                  ),
                  child: ElevatedButton.icon(
                    icon: Icon(
                      Icons.logout_rounded,
                      color: AppColors.whiteColor,
                      size: 25.w,
                    ),
                    label: CustomText(
                      textType: TextStyleType.bodyBig,
                      text: 'Logout',
                      textColor: AppColors.whiteColor,
                      fontWeight: FontWeight.w600,
                    ),
                    onPressed: () => controller.logout(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.redcolor.withOpacity(0.95),
                      minimumSize: Size(double.infinity, 50.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 2,
                    ),
                  ),
                ),
                (10.h).ph,
              ],
            ),
          ),
        );
      }),
    );
  }
}
