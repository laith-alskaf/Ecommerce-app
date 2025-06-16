import 'package:flutter/material.dart';
import 'package:simple_e_commerce/domain/entities/product_entity.dart';
import 'package:simple_e_commerce/presentation/views/customer/home/product_details_view/product_details_widget/add_to_cart_button.dart';
import 'package:simple_e_commerce/presentation/views/customer/home/product_details_view/product_details_widget/draggable_product_details.dart';
import 'package:simple_e_commerce/presentation/views/customer/home/product_details_view/product_details_widget/product_image.dart';
import 'package:simple_e_commerce/presentation/views/customer/home/product_details_view/product_details_widget/screen_header.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key, required this.productDetails});

  final ProductEntity productDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ProductImage(image: productDetails.images[0]),
          ScreenHeader(),
          DraggableProductDetails(
            title: productDetails.title,
            price: productDetails.price.toString(),
            description: productDetails.description!,
          ),
        ],
      ),
      bottomNavigationBar: AddToCartButton(),
    );
  }
}
