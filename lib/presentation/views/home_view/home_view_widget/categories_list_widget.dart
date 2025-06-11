import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_e_commerce/presentation/controllers/category/categories_cubit.dart';
import 'package:simple_e_commerce/presentation/controllers/category/categories_state.dart';
import 'package:simple_e_commerce/presentation/views/home_view/home_view_widget/category_item_widget.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_loading_spinkit.dart';

class CategoriesListWidget extends StatelessWidget {
  final Function(String categoryId, String categoryName)? onCategoryTap;

  const CategoriesListWidget({super.key, this.onCategoryTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesLoading || state is CategoriesInitial) {
          return SizedBox(height: 100, child: showSpinKitLoading());
        } else if (state is CategoriesLoaded) {
          if (state.categories.isEmpty) {
            return const SizedBox(
              height: 100,
              child: Center(child: Text("No categories found.")),
            );
          }
          return SizedBox(
            height: 105,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.categories.length,
              itemBuilder: (ctx, index) {
                final category = state.categories[index];
                return CategoryItemWidget(
                  category: category,
                  onTap:
                      onCategoryTap == null
                          ? null
                          : () => onCategoryTap!(category.id, category.name),
                );
              },
            ),
          );
        } else if (state is CategoriesError) {
          return SizedBox(
            height: 100,
            child: Center(child: Text("Error: ${state.message}")),
          );
        }
        return const SizedBox(height: 100);
      },
    );
  }
}
