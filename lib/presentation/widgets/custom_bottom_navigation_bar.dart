//
// // file: ui/shared/custom_widget/custom_bottom_navigation_bar.dart
//
// import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
// import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart'; // قد لا يكون هذا ضروريًا إذا كان BottomBarInspiredOutside مُصدّرًا بشكل صحيح
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:simple_e_commerce/app/my_app_cubit.dart';
// import 'package:simple_e_commerce/core/utils/colors.dart';
// import 'package:simple_e_commerce/core/utils/general_util.dart';
// import 'package:simple_e_commerce/presentation/controllers/main/main_cubit.dart';
// import 'package:simple_e_commerce/presentation/views/auth/login_view/login_view.dart';
// import 'package:simple_e_commerce/presentation/views/auth/sign_up_view/sign_up_main.dart';
// import 'package:simple_e_commerce/ui/shared/custom_widget/show_Login_Required_Dialog.dart';
//
// class CustomBottomNavigationBar extends StatelessWidget {
//   const CustomBottomNavigationBar({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // الوصول إلى Cubits
//     final controller = context.watch<MainCubit>(); // .watch لإعادة البناء عند تغيير الحالة
//
//     return BlocConsumer<MainCubit, MainState>(
//       listener: (context, state) {
//         if (state is HasNotPermission) {
//           showLoginRequiredDialog(
//             message:
//             "To use this feature and access all app services, please log in or create a new account.",
//             onLoginPressed: () {
//               Get.back();
//               storage.clearPreference();
//               Navigator.of(
//                 context,
//               ).push(MaterialPageRoute(builder: (_) => LoginPageWrapper()));
//             },
//             onSignUpPressed: () {
//               Get.back();
//               storage.clearPreference();
//               Navigator.of(context).push(
//                 MaterialPageRoute(builder: (_) => SignUpMainWrapper()),
//               );
//             },
//           );
//         }
//       },
//       listenWhen: (context, state) {
//         return state.currentIndex;
//       },
//       builder: (context, state) {
//         return BottomBarInspiredOutside(
//           height: 45.h,
//           items: controller.items,
//           backgroundColor: Colors.white,
//           color: AppColors.mainColor,
//           colorSelected: AppColors.whiteColor,
//           indexSelected: state,
//           onTap: (int index) {
//             if (index != 2 &&
//                 context.read<MyAppCubit>().hasPermissionToUse()) {
//               controller.animateToPage(controller.screens[index], index);
//             } else {
//               // controller.currentIndex = 1;
//               // controller.animateToPage(controller.screens[1], 1);
//               print('222222222222222222222');
//             }
//           },
//           itemStyle: ItemStyle.circle,
//           chipStyle: ChipStyle(
//             background: AppColors.mainColor,
//             notchSmoothness: NotchSmoothness.smoothEdge,
//           ),
//         );
//       },
//     );
//   }
// }