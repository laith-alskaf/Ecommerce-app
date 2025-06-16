import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_e_commerce/core/utils/colors.dart';
import 'package:simple_e_commerce/core/utils/extension_sizebox.dart';
import 'package:simple_e_commerce/presentation/controllers/wishlist/wishlist_cubit.dart';
import 'package:simple_e_commerce/presentation/controllers/wishlist/wishlist_state.dart';
import 'package:simple_e_commerce/presentation/views/customer/home/product_details_view/product_details_view.dart';
import 'package:simple_e_commerce/presentation/views/customer/home/wishlist_view/wishlist_widget/wishlist_empty.dart';
import 'package:simple_e_commerce/presentation/views/customer/home/wishlist_view/wishlist_widget/wishlist_item_card.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_loading_spinkit.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_show_snackbar.dart';

class ProductsWishlist extends StatelessWidget {
  const ProductsWishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WishlistCubit, WishlistState>(
      listener: (context, state) {
        if (state is AddProductSuccess ||
            state is RemoveProductSuccess ||
            state is RemoveAllProductsSuccess) {
          showSnackBar(
            title: state.message,
            backgroundColor: AppColors.greenColor.withOpacity(0.7),
          );
        } else if (state is AddProductError ||
            state is RemoveProductError ||
            state is RemoveAllProductsError) {
          showSnackBar(
            title: state.message,
            backgroundColor: AppColors.redcolor.withOpacity(0.6),
          );
        }
      },
      builder: (context, state) {
        if (state is WishlistLoading) {
          return showSpinKitLoading();
        }
        if (state is WishlistLoaded) {
          if (state.wishlistItems.isEmpty) {
            return WishlistEmpty();
          } else {
            return ListView.separated(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              itemCount: state.wishlistItems.length,
              itemBuilder: (context, index) {
                return WishlistItemCard(
                  onTapCard: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder:
                            (_) => ProductDetailsView(
                              productDetails: state.wishlistItems[index],
                            ),
                      ),
                    );
                  },
                  product: state.wishlistItems[index],
                  onRemoveFromWishlist: () {
                    context.read<WishlistCubit>().removeProduct(
                      product: state.wishlistItems[index],
                    );
                  },
                  onAddToCart: () {},
                );
              },
              separatorBuilder: (context, index) => (15.h).ph,
            );
          }
        } else {
          return WishlistEmpty();
        }
      },
    );
  }
}
