import 'dart:developer';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_e_commerce/app/di/service_locator.dart';
import 'package:simple_e_commerce/app/my_app_cubit.dart';
import 'package:simple_e_commerce/core/data/repositories/storage_repositories.dart';
import 'package:simple_e_commerce/core/enums/bottom_navigation.dart';
import 'package:simple_e_commerce/core/utils/general_util.dart';
import 'dart:math' as math;

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  final PageController pageController;
  final List<TabItem> items = [
    TabItem(icon: Icons.search_sharp, title: 'Products'),
    TabItem(icon: Icons.home, title: 'Home'),
    TabItem(icon: Icons.favorite_border, title: 'Wishlist'),
  ];
  final List<BottomNavigationEnum> screens = [
    BottomNavigationEnum.Products,
    BottomNavigationEnum.Home,
    BottomNavigationEnum.CartView,
  ];
  final random = math.Random();

  MainCubit()
    : pageController = PageController(initialPage: 1),
      super(
        const MainState(
          currentIndex: 1,
          selected: BottomNavigationEnum.Home,
          timeStamp: 0,
        ),
      ) {
    initNotification();
  }

  Future initNotification() async {
    String role = sl<SharedPreferenceRepositories>().getRole();
    if (role == 'customer') {
      await notificationService.subscribeToTopicNewProduct(
        subscribeToTopic: 'new_product',
      );
    }
  }

  void animateToPage(BottomNavigationEnum selectedEnum, int pageNumber) {
    pageController.animateToPage(
      pageNumber,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastLinearToSlowEaseIn,
    );
    emit(
      state.copyWith(
        currentIndex: pageNumber,
        selected: selectedEnum,
        timeStamp: random.nextInt(100),
      ),
    );
  }

  void handleBottomNavigationTap({
    required int tappedIndex,
    required BuildContext context,
  }) {
    log(pageController.page.toString());
    if (tappedIndex != 2 && state.currentIndex != tappedIndex) {
      animateToPage(screens[tappedIndex], tappedIndex);
    } else if (tappedIndex == 2 &&
        !context.read<MyAppCubit>().hasPermissionToUse()) {
      emit(
        state.copyWith(
          currentIndex: state.currentIndex,
          selected: state.selected,
          timeStamp: random.nextInt(100),
        ),
      );
    }
  }
}
