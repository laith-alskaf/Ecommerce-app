import 'package:flutter/material.dart';
import 'package:simple_e_commerce/domain/entities/category_entity.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_cached_image.dart';

class CategoryItemWidget extends StatelessWidget {
  final CategoryEntity category;
  final VoidCallback? onTap;

  const CategoryItemWidget({super.key, required this.category, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
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
            Text(
              category.name,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontSize: 12),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
