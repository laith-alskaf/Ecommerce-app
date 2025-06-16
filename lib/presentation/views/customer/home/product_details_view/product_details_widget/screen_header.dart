import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_e_commerce/core/utils/colors.dart';
import 'package:simple_e_commerce/presentation/views/customer/home/product_details_view/product_details_widget/header_button.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_text.dart';

class ScreenHeader extends StatelessWidget {
  const ScreenHeader({super.key});


  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 16,
      left: 16,
      right: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HeaderButton(icon: Icons.ice_skating),
          HeaderButton(icon: Icons.accessibility_rounded),
        ],
      ),
    );
  }
}
