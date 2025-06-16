import 'package:flutter/material.dart';
import 'package:simple_e_commerce/core/utils/colors.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_cached_image.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: BoxDecoration(color: AppColors.mainColor),
        child: Hero(tag: image, child: CustomCachedImage(image: image)),
      ),
    );
  }
}
