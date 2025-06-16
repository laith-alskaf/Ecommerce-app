import 'package:flutter/material.dart';

class SizeSelector extends StatefulWidget {
  const SizeSelector({super.key});

  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  final List<String> _sizes = ['S', 'M', 'L', 'XL'];
  String _selectedSize = 'M';

  @override
  Widget build(BuildContext context) {
    return Row(
      children:
          _sizes.map((size) {
            bool isSelected = _selectedSize == size;
            return GestureDetector(
              onTap: () => setState(() => _selectedSize = size),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(left: 12),
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color:
                      isSelected ? const Color(0xFF5A5FD0) : Colors.transparent,
                  border: Border.all(
                    color:
                        isSelected
                            ? const Color(0xFF5A5FD0)
                            : Colors.grey[300]!,
                    width: 2,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    size,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }
}
