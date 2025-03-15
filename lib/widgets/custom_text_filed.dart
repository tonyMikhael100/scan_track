import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData? prefixIcon;
  final bool obscureText;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool isEnable;
  TextEditingController? controller;
  int? maxLength;

  CustomTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.obscureText = false,
    required this.onChanged,
    this.keyboardType,
    required this.isEnable,
    this.controller,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        maxLength: maxLength,
        controller: controller,
        enabled: isEnable,
        keyboardType: keyboardType,
        onChanged: onChanged,
        obscureText: obscureText,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.shade200, // White background
          hintText: hintText,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15), // Circular border
            borderSide: BorderSide.none, // Removes default border
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        ),
      ),
    );
  }
}
