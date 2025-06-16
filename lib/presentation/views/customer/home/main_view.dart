import 'dart:developer';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/app/my_app_cubit.dart';
import 'package:simple_e_commerce/core/utils/general_util.dart';
import 'package:simple_e_commerce/core/utils/colors.dart';
import 'package:simple_e_commerce/presentation/controllers/main/main_cubit.dart';
import 'package:simple_e_commerce/presentation/views/auth/login_view/login_view.dart';
import 'package:simple_e_commerce/presentation/views/auth/sign_up_view/sign_up_main.dart';
import 'package:simple_e_commerce/presentation/views/customer/home/products_view/products_view.dart';
import 'package:simple_e_commerce/presentation/views/customer/home/wishlist_view/wishlist_view.dart';
import 'package:simple_e_commerce/presentation/views/home_view/home_view.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_app_bar.dart';
import 'package:simple_e_commerce/presentation/widgets/show_login_required_dialog.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    final controller = context.read<MainCubit>();

    return MultiBlocListener(
      listeners: [
        BlocListener<MyAppCubit, MyAppState>(
          listener: (context, state) {
            log('1213131313');
            if (state is HasNotPermission) {
              showLoginRequiredDialog(
                context: context,
                message:
                    "To use this feature and access all app services, please log in or create a new account.",
                onLoginPressed: () {
                  Get.back();
                  storage.clearPreference();
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (_) => LoginPageWrapper()));
                },
                onSignUpPressed: () {
                  Get.back();
                  storage.clearPreference();
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => SignUpMainWrapper()),
                  );
                },
              );
            }
          },
        ),
        BlocListener<MainCubit, MainState>(listener: (context, state) {}),
      ],
      child: SafeArea(
        child: Scaffold(
          extendBody: true,
          backgroundColor: AppColors.whiteColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: BlocSelector<MainCubit, MainState, String>(
              selector: (state) {
                return state.selected.name;
              },
              builder: (context, state) {
                return customAppBar(title: state, isMainView: true);
              },
            ),
          ),
          resizeToAvoidBottomInset: false,
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller.pageController,
            children: [ProductsView(), HomeView(), const WishlistView()],
          ),
          bottomNavigationBar: BlocBuilder<MainCubit, MainState>(
            builder: (context, state) {
              return BottomBarInspiredOutside(
                height: 45.h,
                items: controller.items,
                backgroundColor: Colors.white,
                color: AppColors.mainColor,
                colorSelected: AppColors.whiteColor,
                indexSelected: state.currentIndex,
                onTap: (int index) {
                  controller.handleBottomNavigationTap(
                    tappedIndex: index,
                    context: context,
                  );
                },
                itemStyle: ItemStyle.circle,
                chipStyle: ChipStyle(
                  background: AppColors.mainColor,
                  notchSmoothness: NotchSmoothness.smoothEdge,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
