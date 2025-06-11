import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/translation/app_translation.dart';
import 'package:simple_e_commerce/core/utils/general_util.dart';
import 'package:simple_e_commerce/core/utils/string_urtil.dart';
import 'package:simple_e_commerce/core/utils/colors.dart';
import 'package:simple_e_commerce/presentation/views/customer/home/profile_view/edit_profile_view/edit_profile_controller.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_button.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_text.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_text_field.dart';
import 'package:simple_e_commerce/core/utils/extension_sizebox.dart';

// ignore: must_be_immutable
class EditProfileView extends StatelessWidget {
  EditProfileView({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey(debugLabel: 'signScreenKey');

  @override
  Widget build(BuildContext context) {
    EditProfileController controller = Get.put(EditProfileController());

    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: "Edit Profile",
          textType: TextStyleType.subtitle,
          textColor: AppColors.whiteColor,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: AppColors.mainColor,
        elevation: 0.8,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.whiteColor,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: IntrinsicHeight(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  (20.h).ph,
                  // SvgPicture.asset(
                  //   'assets/images/ic_${controller.imageSignUp[controller.currentIndex.value]}.svg',
                  //   width: 200.w,
                  //   height: 150.h,
                  // ),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: CustomText(
                      text: 'Edit Your profile info',
                      textType: TextStyleType.bodyBig,
                      textColor: AppColors.blackColor,
                      fontWeight: FontWeight.normal,
                    ),
                  ),

                  (20.h).ph,
                  Row(
                    children: [
                      CustomTextFormField(
                        widthContainer: 215.w,
                        hintTextColor: AppColors.blackColor,
                        hintText: '',
                        controller: controller.firstNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return tr('Input your first name');
                          }
                          return null;
                        },
                      ),
                      const Spacer(),
                      CustomTextFormField(
                        hintTextColor: AppColors.blackColor,
                        widthContainer: 215.w,
                        hintText: '',
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
                  (25.h).ph,
                  CustomTextFormField(
                    hintTextColor: AppColors.blackColor,
                    hintText: '',
                    keyboardType: TextInputType.emailAddress,
                    controller: controller.email,
                    validator: (value) {
                      if (value!.isEmpty || !StringUtil.isEmail(value)) {
                        return tr('please check your email');
                      }
                      return null;
                    },
                  ),

                  (25.h).ph,
                  CustomButton(
                    width: 1.sw,
                    height: 50.h,
                    buttonTypeEnum: ButtonTypeEnum.normal,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        controller.submitUpdateProfile();
                      }
                    },
                    text: tr('Submit'),
                    fontWeight: FontWeight.bold,
                  ),

                  (35.h).ph,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
