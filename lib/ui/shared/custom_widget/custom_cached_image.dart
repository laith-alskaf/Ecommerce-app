import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_e_commerce/ui/shared/colors.dart';

// ignore: must_be_immutable
class CustomCachedImage extends StatelessWidget {
  const CustomCachedImage({
    super.key,
    required this.image,
    this.widthCircularProgress,
    this.heightCircularProgress,
    this.widthImage,
    this.heightImage,
    this.borderRadius,
  });

  final String image;
  final double? widthCircularProgress;
  final double? heightCircularProgress;
  final double? widthImage;
  final double? heightImage;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          borderRadius ?? BorderRadius.vertical(bottom: Radius.circular(12.r)),
      child: CachedNetworkImage(
        imageUrl: image,
        fit: BoxFit.cover,
        width: widthImage ?? double.infinity,
        height: heightImage ?? double.infinity,
        placeholder:
            (context, url) => Container(
              color: AppColors.grayColor.withOpacity(0.1),
              child: Center(
                child: SizedBox(
                  width: widthCircularProgress ?? double.infinity,
                  height: heightCircularProgress ?? double.infinity,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: AppColors.mainColor.withOpacity(0.7),
                  ),
                ),
              ),
            ),
        errorWidget:
            (context, url, error) => Container(
              color: AppColors.grayColor.withOpacity(0.1),
              child: Center(
                child: Icon(
                  Icons.broken_image_outlined,
                  size: 50.w,
                  color: AppColors.grayColor.withOpacity(0.5),
                ),
              ),
            ),
      ),
    );
  }
}
