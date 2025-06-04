import 'package:animate_do/animate_do.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/translation/app_translation.dart';
import 'package:simple_e_commerce/ui/shared/colors.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_button.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_row_info.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text_field.dart';
import 'package:simple_e_commerce/ui/shared/extension_sizebox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_e_commerce/ui/views/auth/sign_up_view/sign_up_view_controller.dart';

class CompanyForm extends StatelessWidget {
  const CompanyForm({super.key, required this.controller});

  final SignUpViewController controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpViewController>(
      builder: (c) {
        return Visibility(
          visible: controller.selectedRole=='admin',
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            height: controller.expandedContainer[0] == false ? 70.h : 320.h,
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
                    controller.clickToExpanded(index: 0);
                  },
                  child: CustomRowInfo(
                    index: 0,
                    controller: controller,
                    title: tr('Company Details'),
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
                      controller.selectedRole == 'admin' &&
                      controller.expandedContainer[0],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: tr('Company Name'),
                        isTextAlign: TextAlign.center,
                        textType: TextStyleType.bodyBig,
                        fontWeight: FontWeight.normal,
                      ),
                      (10.h).ph,
                      CustomTextFormField(
                        hintText: tr('Nike'),
                        controller: controller.companyNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return tr('please check your company name');
                          }
                          return null;
                        },
                      ),
                      (15.h).ph,
                      CustomText(
                        text: tr('Company Description'),
                        isTextAlign: TextAlign.center,
                        textType: TextStyleType.bodyBig,
                        fontWeight: FontWeight.normal,
                      ),
                      (10.h).ph,
                      CustomTextFormField(
                        hintText: '',
                        controller: controller.companyDescriptionController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return tr('please check your company description');
                          }
                          return null;
                        },
                      ),
                      (15.h).ph,
                      CustomText(
                        text: tr('Company Address'),
                        isTextAlign: TextAlign.center,
                        textType: TextStyleType.bodyBig,
                        fontWeight: FontWeight.normal,
                      ),
                      (10.h).ph,
                      CustomTextFormField(
                        hintText: '',
                        controller: controller.companyAddressController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return tr('please check your company address');
                          }
                          return null;
                        },
                      ),
                      (10.h).ph,
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
