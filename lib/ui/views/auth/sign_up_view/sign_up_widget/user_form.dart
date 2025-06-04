import 'package:get/get.dart';
import 'package:simple_e_commerce/core/translation/app_translation.dart';
import 'package:simple_e_commerce/ui/shared/colors.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_row_info.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text_field.dart';
import 'package:simple_e_commerce/ui/shared/extension_sizebox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_e_commerce/ui/views/auth/sign_up_view/sign_up_view_controller.dart';

class UserForm extends StatelessWidget {
  const UserForm({super.key, required this.controller});

  final SignUpViewController controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpViewController>(
      builder: (c) {
        return Visibility(
          visible: controller.selectedRole == 'customer',
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            height: controller.expandedContainer[1] == false ? 70.h : 320.h,
            width: 1.sw,
            margin: EdgeInsets.symmetric(horizontal: 5.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(15.r),
              color: AppColors.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: AppColors.mainColor.withOpacity(0.5),
                  spreadRadius: 0.5,
                  blurRadius: 1,
                  offset: const Offset(0.5, 0.5),
                ),
              ],
            ),
            padding: EdgeInsetsDirectional.only(
              start: 30.w,
              end: 30.w,
              top: 25.h,
            ),
            child: ListView(
              shrinkWrap: true,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.clickToExpanded(index: 1);
                  },
                  child: CustomRowInfo(
                    index: 0,
                    controller: controller,
                    title: tr('User Information'),
                  ),
                ),
                Divider(
                  color: AppColors.blackColor,
                  height: 10.h,
                  thickness: 0.3,
                ),
                (10.h).ph,
                Visibility(
                  visible:
                      controller.selectedRole == 'customer' &&
                      controller.expandedContainer[1],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextFormField(
                            widthContainer: 180.w,
                            hintText: tr('First Name'),
                            controller: controller.firstNameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return tr('Input your first name');
                              }
                              return null;
                            },
                          ),
                          CustomTextFormField(
                            widthContainer: 180.w,
                            hintText: tr('Last Name'),
                            controller: controller.lastNameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return tr('Input your last name');
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
