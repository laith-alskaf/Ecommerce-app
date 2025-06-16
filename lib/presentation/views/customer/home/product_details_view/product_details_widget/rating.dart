import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  const Rating({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: List.generate(5, (index) {
            return Icon(
              Icons.stars_sharp,
              size: 20,
              color: index < 4 ? Colors.yellow[600] : Colors.grey[300],
            );
          }),
        ),
        const SizedBox(width: 8),
        const Text(
          '(120 تقييم)',
          style: TextStyle(color: Color(0xFF6B7280), fontSize: 14),
        ),
      ],
    );
  }
}
