import 'package:flutter/material.dart';

class ColorSelector extends StatefulWidget {
  const ColorSelector({super.key});

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  final List<Color> _colors = [
    const Color(0xFF000000), // Black
    const Color(0xFF1E3A8A), // Blue
    const Color(0xFF9CA3AF), // Gray
    const Color(0xFFB91C1C), // Red
  ];
  Color _selectedColor = const Color(0xFF000000);

  @override
  Widget build(BuildContext context) {
    return Row(
      children:
          _colors.map((color) {
            bool isSelected = _selectedColor == color;
            return GestureDetector(
              onTap: () => setState(() => _selectedColor = color),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(left: 16),
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:
                      isSelected
                          ? Border.all(color: const Color(0xFF5A5FD0), width: 2)
                          : null,
                ),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }
}
