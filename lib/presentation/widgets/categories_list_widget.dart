import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_e_commerce/presentation/controllers/category/categories_cubit.dart';
import 'package:simple_e_commerce/presentation/controllers/category/categories_state.dart';
import 'package:simple_e_commerce/presentation/widgets/category_item_widget.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_loading_spinkit.dart';

class CategoriesListWidget extends StatelessWidget {
  final Function(String categoryId, String categoryName)? onCategoryTap;

  const CategoriesListWidget({super.key, this.onCategoryTap});

  @override
  Widget build(BuildContext context) {
    // It's assumed that CategoriesCubit is provided higher up in the widget tree,
    // or if this widget is self-contained for a specific screen,
    // it might be wrapped with BlocProvider there.
    // For demonstration, if it's always fetched when this widget appears:
    // BlocProvider.of<CategoriesCubit>(context).fetchCategories(); // Or handle this in a page/screen

    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesLoading || state is CategoriesInitial) {
          return SizedBox( // Removed const
            height: 100, // Consistent height during loading
            child: showSpinKitLoading(), // Call the function
          );
        } else if (state is CategoriesLoaded) {
          if (state.categories.isEmpty) {
            return const SizedBox( // This can remain const as Text can be const
              height: 100, // Consistent height
              child: Center(child: Text("No categories found.")),
            );
          }
          return SizedBox(
            height: 105, // Adjusted height to accommodate padding/text
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.categories.length,
              itemBuilder: (ctx, index) {
                final category = state.categories[index];
                return CategoryItemWidget(
                  category: category,
                  onTap: onCategoryTap == null ? null : () => onCategoryTap!(category.id, category.name),
                );
              },
            ),
          );
        } else if (state is CategoriesError) {
          return SizedBox(
            height: 100, // Consistent height
            child: Center(child: Text("Error: ${state.message}")),
          );
        }
        return const SizedBox(height: 100); // Default empty space
      },
    );
  }
}