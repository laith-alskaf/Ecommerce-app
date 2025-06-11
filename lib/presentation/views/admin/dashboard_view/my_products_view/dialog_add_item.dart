import 'dart:io';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/enums/file_type.dart';
import 'package:simple_e_commerce/core/enums/request_status.dart';
import 'package:simple_e_commerce/core/utils/colors.dart';
import 'package:simple_e_commerce/presentation/views/admin/all_products_view_admin/all_products_view_controller.dart';
import 'package:simple_e_commerce/presentation/views/admin/dashboard_view/dashboard_controller.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_button.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_show_snackbar.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_text.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_text_field.dart';
import 'package:simple_e_commerce/presentation/widgets/static_custom_drop.dart';
import 'package:simple_e_commerce/core/utils/extension_sizebox.dart';

showDialogAddItem({required DashboardController controller}) {
  AllProductsViewController allProductsViewController = Get.find();
  Get.dialog(
    Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 0.1.sw),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(35.r)),
      ),
      child: IntrinsicHeight(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.w),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(20),
          ),
          // width: 400.w,
          child: IntrinsicHeight(
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CustomText(
                      text: "Input information about Product",
                      textType: TextStyleType.subtitle,
                      textColor: AppColors.mainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.sp,
                    ),
                  ),
                  (20.h).ph,
                  CustomText(
                    bottomPadding: 10.h,
                    text: "Title *",
                    textType: TextStyleType.body,
                    textColor: AppColors.mainColor,
                    fontWeight: FontWeight.normal,
                  ),
                  CustomTextFormField(
                    hintText: 'Product Name *',
                    controller: controller.titleController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please input your product name';
                      }
                      return null;
                    },
                  ),
                  (20.h).ph,
                  CustomText(
                    bottomPadding: 10.h,
                    text: "Description *",
                    textType: TextStyleType.body,
                    textColor: AppColors.mainColor,
                    fontWeight: FontWeight.normal,
                  ),
                  CustomTextFormField(
                    hintText: 'Product Description',
                    keyboardType: TextInputType.text,
                    controller: controller.descriptionController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please input your product description';
                      }
                      return null;
                    },
                  ),
                  (20.h).ph,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              bottomPadding: 10.h,
                              text: "Price *",
                              textType: TextStyleType.body,
                              textColor: AppColors.mainColor,
                              fontWeight: FontWeight.normal,
                            ),
                            CustomTextFormField(
                              borderRadius: 20.r,
                              hintText: 'Product Price',
                              controller: controller.priceController,
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please input your product price';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      (20.w).pw,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              bottomPadding: 10.h,
                              text: "Stock Quantity *",
                              textType: TextStyleType.body,
                              textColor: AppColors.mainColor,
                              fontWeight: FontWeight.normal,
                            ),
                            CustomTextFormField(
                              borderRadius: 20.r,
                              hintText: 'Product stock Quantity',
                              controller: controller.stockQuantityController,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please input your product stock Quantity';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  (20.h).ph,
                  CustomText(
                    bottomPadding: 10.h,
                    text: "Category *",
                    textType: TextStyleType.body,
                    textColor: AppColors.mainColor,
                    fontWeight: FontWeight.normal,
                  ),
                  GetBuilder<DashboardController>(
                    builder: (c) {
                      if (allProductsViewController.allCategory.isEmpty) {
                        return Center(
                          child: CircularProgressIndicator(),
                        ); // Example
                      }
                      return StaticCustomDrop(
                        text: 'Category Name',
                        itemList: allProductsViewController.allCategoryName,
                        height: 50.h,
                        value: controller.categoryController,
                        onChanged: (String? y) {
                          controller.categoryController = y!;
                          controller.update();
                        },
                        width: 0.8.sw,
                      );
                    },
                  ),
                  (20.h).ph,
                  GestureDetector(
                    onTap: () async {
                      await controller.pickImage(FileTypeEnum.gallery).then((
                        s,
                      ) {
                        controller.update();
                      });
                    },
                    child: Container(
                      height: 50.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(15.r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.mainColor.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            startPadding: 20.w,
                            text: 'Click to upload image',
                            textType: TextStyleType.body,
                            fontWeight: FontWeight.normal,
                          ),
                          const Spacer(),
                          GetBuilder<DashboardController>(
                            builder: (c) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30.r),
                                  ),
                                ),
                                width: 80.w,
                                height: 60.h,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20.r),
                                  ),
                                  child:
                                      controller.imageRecipe == ''
                                          ? Icon(
                                            Icons.image,
                                            size: 50.w,
                                            color: AppColors.mainColor,
                                          )
                                          : Image(
                                            image: FileImage(
                                              File(controller.imageRecipe),
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  (20.h).ph,
                  GetBuilder<DashboardController>(
                    builder: (c) {
                      return controller.status.value == RequestStatus.LOADING
                          ? SpinKitCircle(
                            color: AppColors.mainColor,
                            size: 50.w,
                          )
                          : Center(
                            child: CustomButton(
                              text: 'Add',
                              buttonTypeEnum: ButtonTypeEnum.normal,
                              width: 200.w,
                              onPressed: () {
                                if (controller.formKey.currentState!
                                        .validate() &&
                                    controller.imageRecipe != '') {
                                  Get.closeAllSnackbars();
                                  controller.addProduct();
                                } else {
                                  Get.closeAllSnackbars();
                                  showSnackBar(
                                    title: 'Please fill in the blank fields',
                                  );
                                }
                              },
                            ),
                          );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
