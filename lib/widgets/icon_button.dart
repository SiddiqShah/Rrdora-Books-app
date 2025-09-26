import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Colors.deepPurple, // button background
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white, // icon color
          size: 24,
        ),
      ),
    );
  }
}
