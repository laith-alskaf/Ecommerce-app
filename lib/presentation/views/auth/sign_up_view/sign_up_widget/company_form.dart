import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_e_commerce/core/translation/app_translation.dart';
import 'package:simple_e_commerce/core/utils/colors.dart';
import 'package:simple_e_commerce/presentation/controllers/auth/signup/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_row_info.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_text.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_text_field.dart';
import 'package:simple_e_commerce/core/utils/extension_sizebox.dart';

class CompanyForm extends StatelessWidget {
  const CompanyForm({super.key, required this.controller});

  final SignUpCubit controller;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SignUpCubit, SignUpState, bool>(
      selector: (state) => state.expandedList[1],
      builder: (context, state) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          height: state == false ? 70.h : 320.h,
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
                visible: state,
                // controller.selectedRole == 'admin' &&
                // controller.expandedContainer[1],
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
        );
      },
    );
  }
}
