import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_e_commerce/core/utils/colors.dart';
import 'package:simple_e_commerce/core/utils/extension_sizebox.dart';
import 'package:simple_e_commerce/presentation/views/customer/home/product_details_view/product_details_widget/color_selector.dart';
import 'package:simple_e_commerce/presentation/views/customer/home/product_details_view/product_details_widget/product_title_and_price.dart';
import 'package:simple_e_commerce/presentation/views/customer/home/product_details_view/product_details_widget/rating.dart';
import 'package:simple_e_commerce/presentation/views/customer/home/product_details_view/product_details_widget/section_title.dart';
import 'package:simple_e_commerce/presentation/views/customer/home/product_details_view/product_details_widget/size_selector.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_text.dart';

class DraggableProductDetails extends StatelessWidget {
  const DraggableProductDetails({
    super.key,
    required this.price,
    required this.title,
    required this.description,
  });

  final String price;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.6,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductTitleAndPrice(title: title, price: price),
                const SizedBox(height: 8),
                Rating(),
                (25.h).ph,
                Text(
                  description,
                  style: TextStyle(color: Color(0xFF6B7280), height: 1.6),
                ),
                (25.h).ph,
                SectionTitle(title: 'Select size'),
                SizeSelector(),
                (25.h).ph,
                SectionTitle(title: 'Available colors'),
                ColorSelector(),
                (80.h).ph,
              ],
            ),
          ),
        );
      },
    );
  }
}
