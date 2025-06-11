import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import BlocProvider
import 'package:get/get.dart';
import 'package:simple_e_commerce/app/di/service_locator.dart'; // Import Service Locator (sl)
import 'package:simple_e_commerce/presentation/controllers/category/categories_cubit.dart';
import 'package:simple_e_commerce/presentation/views/home_view/home_view_widget/categories_list_widget.dart';
import 'package:simple_e_commerce/core/utils/colors.dart';
import 'package:simple_e_commerce/presentation/views/home_view/home_view_controller.dart';
import 'package:simple_e_commerce/presentation/views/home_view/home_view_widget/products_section.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_text.dart';


// ignore: must_be_immutable
class HomeView extends StatelessWidget {
  HomeView({super.key});

  // HomeViewController is still used for products
  HomeViewController homeController = Get.put(HomeViewController());

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        // Trigger product refresh and also categories cubit refresh
        final categoriesCubit = BlocProvider.of<CategoriesCubit>(context, listen: false);
        await Future.wait([
          homeController.getALlProducts(),
          categoriesCubit.fetchCategories(), // Refresh categories via Cubit
        ]);
      },
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsetsDirectional.symmetric(vertical: 10.h),
              child: Row(
                children: [
                  CustomText(
                    text: 'Categories',
                    textColor: AppColors.mainColor,
                    fontWeight: FontWeight.bold,
                    textType: TextStyleType.title,
                    fontSize: 35.sp,
                    startPadding: 20.w,
                    topPadding: 20.w,
                    bottomPadding: 20.w,
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter( // Wrap BlocProvider in SliverToBoxAdapter
            child: BlocProvider(
              create: (context) => sl<CategoriesCubit>()..fetchCategories(),
              child: CategoriesListWidget(
                onCategoryTap: (categoryId, categoryName) {
                  // Handle category tap, e.g., navigate to products of this category
                  print('Tapped category: $categoryName (ID: $categoryId)');
                  // Example: Get.to(() => ProductsByCategoryView(categoryId: categoryId, categoryName: categoryName));
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: CustomText(
              text: 'Products',
              textColor: AppColors.mainColor,
              fontWeight: FontWeight.bold,
              textType: TextStyleType.title,
              fontSize: 35.sp,
              startPadding: 20.w,
              topPadding: 20.w,
            ),
          ),
          ProductsSection(homeController: homeController),
        ],
      ),
    );
  }
}
