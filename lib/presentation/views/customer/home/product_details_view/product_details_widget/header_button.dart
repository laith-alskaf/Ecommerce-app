import 'package:flutter/material.dart';

class HeaderButton extends StatelessWidget {
  const HeaderButton({super.key, required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Container(
        color: Colors.white.withOpacity(0.7),
        child: IconButton(
          icon: Icon(icon, color: Colors.grey[800]),
          onPressed: () {},
        ),
      ),
    );
  }
}
