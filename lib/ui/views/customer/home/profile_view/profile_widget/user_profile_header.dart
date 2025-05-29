import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_e_commerce/core/data/models/api/user_model.dart';
import 'package:simple_e_commerce/ui/shared/colors.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text.dart';
import 'package:simple_e_commerce/ui/shared/extension_sizebox.dart';
import 'package:simple_e_commerce/ui/views/customer/home/profile_view/profile_controller.dart';

Widget customUserProfileHeader(UserModel user, ProfileController controller) {
  String fullName = user.userName ?? ''.trim();
  if (fullName.isEmpty) {
    fullName = "N/A";
  }

  String email = user.email ?? 'N/A';
  String role = user.role ?? 'N/A';
  String avatarUrl = '';
  bool hasValidAvatar =
      avatarUrl.isNotEmpty && Uri.tryParse(avatarUrl)?.hasAbsolutePath == true;

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
        (18.h).ph,
        CustomText(
          text: fullName,
          textType: TextStyleType.title,
          textColor: AppColors.blackColor,
          isTextAlign: TextAlign.center,
        ),
        (6.h).ph,
        CustomText(
          text: email,
          textType: TextStyleType.bodyBig,
          textColor: AppColors.grayColor.withOpacity(0.9),
          isTextAlign: TextAlign.center,
          fontWeight: FontWeight.normal,
        ),
        (10.h).ph,
        if (role != 'N/A' && role.isNotEmpty)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: AppColors.secondColorMain.withOpacity(0.15),
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(
                color: AppColors.secondColorMain.withOpacity(0.3),
                width: 1.0,
              ),
            ),
            child: CustomText(
              text: "Role: $role",
              textType: TextStyleType.bodyBig,
              textColor: AppColors.secondColorMain,
              fontWeight: FontWeight.normal,
            ),
          ),
      ],
    ),
  );
}
