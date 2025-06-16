import 'package:flutter/material.dart';

class ProductTitleAndPrice extends StatelessWidget {
  const ProductTitleAndPrice({
    super.key,
    required this.price,
    required this.title,
  });

  final String price;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
        ),
         Text(
          '\$$price',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: Color(0xFF5A5FD0),
          ),
        ),
      ],
    );
  }
}
