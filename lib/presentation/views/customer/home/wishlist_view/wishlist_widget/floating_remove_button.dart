import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_e_commerce/core/utils/colors.dart';
import 'package:simple_e_commerce/presentation/controllers/wishlist/wishlist_cubit.dart';

class FloatingRemoveButton extends StatelessWidget {
  const FloatingRemoveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<WishlistCubit>().removeAllProducts();
      },
      child: Container(
        width: 70.w,
        height: 70.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.mainColor.withOpacity(0.6),
        ),
        child: Icon(
          Icons.cleaning_services_outlined,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}
