import 'package:flutter/material.dart';
import 'package:simple_e_commerce/domain/entities/category_entity.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_cached_image.dart'; // Existing widget

class CategoryItemWidget extends StatelessWidget {
  final CategoryEntity category;
  final VoidCallback? onTap; // Optional onTap callback

  const CategoryItemWidget({
    super.key,
    required this.category,
    this.onTap,
  });

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
              child: (category.imageUrl != null && category.imageUrl!.isNotEmpty)
                  ? CustomCachedImage(
                      image: category.imageUrl!,
                      widthImage: 60,
                      heightImage: 60,
                      borderRadius: BorderRadius.circular(30), // Makes it circular
                    )
                  : CircleAvatar( // Fallback if no image
                      radius: 30,
                      child: Icon(Icons.category, color: Theme.of(context).primaryColor),
                      backgroundColor: Theme.of(context).primaryColorLight,
                    ),
            ),
            const SizedBox(height: 6),
            Text(
              category.name,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12),
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