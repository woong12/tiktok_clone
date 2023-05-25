import 'package:flutter/material.dart';

import '../../../constants/sizes.dart';

class InterestButton extends StatefulWidget {
  const InterestButton({
    super.key,
    required this.intereset,
  });

  final String intereset;

  @override
  State<InterestButton> createState() => _InterestButtonState();
}

class _InterestButtonState extends State<InterestButton> {
  bool _isSelected = false;

  void _onTap() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size16 + Sizes.size2,
          horizontal: Sizes.size16 + Sizes.size2,
        ),
        decoration: BoxDecoration(
          color: _isSelected ? Theme.of(context).primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 5,
              spreadRadius: 4,
            ),
          ],
          border: Border.all(
            color: Colors.black.withOpacity(0.07),
          ),
        ),
        child: Text(
          widget.intereset,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: Sizes.size16 + Sizes.size1,
            color: _isSelected ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}
