import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_e_commerce/app/di/service_locator.dart';
import 'package:simple_e_commerce/core/utils/colors.dart';
import 'package:simple_e_commerce/presentation/controllers/wishlist/wishlist_cubit.dart';
import 'package:simple_e_commerce/presentation/views/customer/home/wishlist_view/wishlist_widget/floating_remove_button.dart';
import 'package:simple_e_commerce/presentation/views/customer/home/wishlist_view/wishlist_widget/products_wishlist.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<WishlistCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        floatingActionButton: FloatingRemoveButton(),
        body: ProductsWishlist(),
      ),
    );
  }
}
