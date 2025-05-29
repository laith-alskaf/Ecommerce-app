import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/enums/bottom_navigation.dart';
import 'package:simple_e_commerce/core/enums/request_status.dart'; // مسارك
import 'package:simple_e_commerce/ui/shared/colors.dart'; // مسارك
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_app_bar.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text.dart'; // مسارك
import 'package:simple_e_commerce/core/data/models/api/user_model.dart';
import 'package:simple_e_commerce/ui/views/customer/home/profile_view/profile_controller.dart'; // مسارك

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: customAppBar(
        title: BottomNavigationEnum.Profile.obs,
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
                _buildUserProfileHeader(user!, controller),
                SizedBox(height: 20.h),
                _buildSectionTitle("App Settings"),
                _buildProfileMenuItem(
                  iconData: Icons.person_outline_rounded,
                  text: 'Edit Profile',
                  onTap: () => controller.editProfile(),
                ),
                _buildProfileMenuItem(
                  iconData: Icons.lock_outline_rounded,
                  text: 'Change Password',
                  onTap: () => controller.changePassword(),
                ),
                _buildListDivider(),

                _buildSectionTitle('Preferences'),
                _buildLanguageSelector(controller),
                _buildListDivider(),

                _buildSectionTitle('Support & Info'),
                _buildProfileMenuItem(
                  iconData: Icons.contact_support_outlined,
                  text: 'Contact Us',
                  onTap: () => controller.contactUs(),
                ),
                _buildProfileMenuItem(
                  iconData: Icons.info_outline_rounded,
                  text: 'About App',
                  onTap: () => controller.aboutApp(),
                ),
                _buildListDivider(),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 25.h,
                  ),
                  child: ElevatedButton.icon(
                    icon: Icon(
                      Icons.logout_rounded,
                      color: AppColors.whiteColor,
                      size: 20.sp,
                    ),
                    label: CustomText(
                      textType: TextStyleType.custom,
                      text: 'Logout',
                      textColor: AppColors.whiteColor,
                      fontSize: 16.sp,
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
                SizedBox(height: 10.h),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildUserProfileHeader(UserModel user, ProfileController controller) {
    String fullName = user.userName ?? ''.trim();
    if (fullName.isEmpty) {
      fullName = "N/A";
    }

    String email = user.email ?? 'N/A';
    String role = user.role ?? 'N/A';
    String avatarUrl = '';
    bool hasValidAvatar =
        avatarUrl.isNotEmpty &&
        Uri.tryParse(avatarUrl)?.hasAbsolutePath == true;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 62.r,
            backgroundColor: AppColors.mainColor.withOpacity(0.15),
            child: CircleAvatar(
              radius: 56.r,
              backgroundColor: AppColors.grayColor.withOpacity(0.05),
              backgroundImage:
                  hasValidAvatar ? CachedNetworkImageProvider(avatarUrl) : null,
              child:
                  !hasValidAvatar
                      ? Icon(
                        Icons.person_sharp,
                        size: 60.r,
                        color: AppColors.mainColor.withOpacity(0.6),
                      )
                      : null,
            ),
          ),
          SizedBox(height: 18.h),
          CustomText(
            text: fullName,
            textType: TextStyleType.body,
            fontSize: 23.sp,
            fontWeight: FontWeight.bold,
            textColor: AppColors.blackColor.withOpacity(0.9),
            isTextAlign: TextAlign.center,
          ),
          SizedBox(height: 6.h),
          CustomText(
            text: email,
            textType: TextStyleType.bodyBig,
            fontSize: 15.sp,
            textColor: AppColors.grayColor.withOpacity(0.9),
            isTextAlign: TextAlign.center,
          ),
          SizedBox(height: 10.h),
          if (role != 'N/A' && role.isNotEmpty)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppColors.secondColorMain.withOpacity(0.15),
                borderRadius: BorderRadius.circular(25.r),
                border: Border.all(
                  color: AppColors.secondColorMain.withOpacity(0.3),
                  width: 1.0,
                ),
              ),
              child: CustomText(
                text: "Role: $role",
                textType: TextStyleType.title,
                fontSize: 13.sp,
                textColor: AppColors.secondColorMain,
                fontWeight: FontWeight.w600,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProfileMenuItem({
    required IconData iconData,
    required String text,
    required VoidCallback onTap,
    Color? iconColor,
    Color? textColor,
    Widget? trailing,
  }) {
    return Material(
      color: AppColors.whiteColor,
      child: InkWell(
        onTap: onTap,
        splashColor: AppColors.mainColor.withOpacity(0.1),
        highlightColor: AppColors.mainColor.withOpacity(0.05),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          child: Row(
            children: [
              Icon(
                iconData,
                size: 22.sp,
                color: iconColor ?? AppColors.grayColor.withOpacity(0.8),
              ),
              SizedBox(width: 18.w),
              Expanded(
                child: CustomText(
                  text: text,
                  textType: TextStyleType.bodyBig,
                  fontSize: 15.sp,
                  textColor: textColor ?? AppColors.blackColor.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (trailing != null)
                trailing
              else
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16.sp,
                  color: AppColors.grayColor.withOpacity(0.7),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListDivider({
    double? height,
    double? thickness,
    double? indent,
    double? endIndent,
    Color? color,
  }) {
    return Divider(
      height: height ?? 25.h,
      thickness: thickness ?? 0.8,
      indent: indent ?? 20.w,
      endIndent: endIndent ?? 20.w,
      color: color ?? AppColors.grayColor.withOpacity(0.25),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(
        top: 15.h,
        bottom: 8.h,
        left: 22.w,
        right: 22.w,
      ),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: CustomText(
          text: title,
          textType: TextStyleType.subtitle,
          fontSize: 14.sp,
          textColor: AppColors.mainColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildLanguageSelector(ProfileController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          Icon(
            Icons.language_rounded,
            size: 22.sp,
            color: AppColors.grayColor.withOpacity(0.8),
          ),
          SizedBox(width: 18.w),
          Expanded(
            child: CustomText(
              text: 'Language',
              textType: TextStyleType.bodyBig,
              fontSize: 15.sp,
              textColor: AppColors.blackColor.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
          Obx(
            () => DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: controller.currentLangCode.value,
                icon: Icon(
                  Icons.arrow_drop_down_rounded,
                  color: AppColors.grayColor.withOpacity(0.7),
                ),
                elevation: 2,
                style: TextStyle(
                  color: AppColors.blackColor.withOpacity(0.8),
                  fontSize: 15.sp,
                  fontFamily:
                      'YourAppFontFamily',
                ),
                dropdownColor: AppColors.whiteColor,
                items:
                    controller.supportedLanguages.map<
                      DropdownMenuItem<String>
                    >((Map<String, String> lang) {
                      return DropdownMenuItem<String>(
                        value: lang['code']!,
                        child: CustomText(
                          text: lang['name']!,
                          textType: TextStyleType.body,
                          fontSize: 15.sp,
                        ),
                      );
                    }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    controller.changeLanguage(newValue);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
