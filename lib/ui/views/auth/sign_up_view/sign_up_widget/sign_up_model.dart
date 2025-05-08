// import 'package:animate_do/animate_do.dart';
// import 'package:simple_e_commerce/core/translation/app_translation.dart';
// import 'package:simple_e_commerce/ui/shared/custom_widget/custom_button.dart';
// import 'package:simple_e_commerce/ui/shared/custom_widget/custom_text_field.dart';
// import 'package:simple_e_commerce/ui/shared/extension_sizebox.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:simple_e_commerce/ui/views/sign_up_view/sign_up_view_controller.dart';
// import 'package:simple_e_commerce/ui/views/sign_up_view/sign_up_widget/custom_dilog.dart';
//
// // ignore: must_be_immutable
// class SignUpModel extends StatelessWidget {
//   final GlobalKey<FormState> fromKey;
//
//   SignUpModel({super.key, required this.fromKey});
//
//   SignUpViewController controller = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         FadeInLeft(
//           delay: const Duration(milliseconds: 1300),
//           duration: const Duration(milliseconds: 200),
//           child: CustomTextFormField(
//             hintText: tr('Car Brand And Model'),
//             controller: controller.carModelController,
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return tr('Should be not empty');
//               }
//               return null;
//             },
//           ),
//         ),
//         (25.h).ph,
//         FadeInLeft(
//           delay: const Duration(milliseconds: 1500),
//           duration: const Duration(milliseconds: 200),
//           child: CustomTextFormField(
//             hintText: tr('Car Number'),
//             keyboardType: TextInputType.number,
//             validator: (value) {
//               if (value!.isEmpty || value.length <= 4) {
//                 return tr('Should be more than 4 numbers');
//               }
//
//               return null;
//             },
//             controller: controller.carNumberController,
//           ),
//         ),
//         // (25.h).ph,
//         // FadeInLeft(
//         //   delay: const Duration(milliseconds: 1700),
//         //   duration: const Duration(milliseconds: 200),
//         //   child: CustomDropMenu(
//         //       validator: (value) {
//         //         if (value == null) {
//         //           return 'Please select Type';
//         //         } else {
//         //           controller.carType.value = value;
//         //         }
//         //         return null;
//         //       },
//         //       hint: tr('car type'),
//         //       items: controller.listCarType,
//         //       onSaved: (value) {
//         //         controller.carType.value = value!;
//         //       },
//         //       onChanged: (value) {
//         //         controller.carType.value = value!;
//         //         return ;
//         //       }),
//         // ),
//         (25.h).ph,
//         FadeInLeft(
//           delay: const Duration(milliseconds: 1900),
//           duration: const Duration(milliseconds: 200),
//           child: CustomButton(
//             width: 1.sw,
//             height: 50.h,
//             buttonTypeEnum: ButtonTypeEnum.normal,
//             onPressed: () {
//               if (fromKey.currentState!.validate()) {
//                 showCheckEmailDialog(email: controller.emailController.text);
//               }
//             },
//             text: tr('Next'),
//           ),
//         ),
//       ],
//     );
//   }
// }
