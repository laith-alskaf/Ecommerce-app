import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_e_commerce/domain/entities/category_entity.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_cached_image.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_text.dart';

class CategoryItemWidget extends StatelessWidget {
  final CategoryEntity category;
  final VoidCallback? onTap;

  const CategoryItemWidget({super.key, required this.category, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child:
                  (category.imageUrl != null && category.imageUrl!.isNotEmpty)
                      ? CustomCachedImage(
                        image: category.imageUrl!,
                        widthImage: 60,
                        heightImage: 60,
                        borderRadius: BorderRadius.circular(30),
                      )
                      : CircleAvatar(
                        radius: 30,
                        backgroundColor: Theme.of(context).primaryColorLight,
                        child: Icon(
                          Icons.category,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
            ),
            const SizedBox(height: 6),
            CustomText(
              text: category.name,
              textType: TextStyleType.body,
              fontWeight: FontWeight.normal,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
