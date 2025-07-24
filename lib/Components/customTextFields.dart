import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool? readOnly;
  final VoidCallback? onTap;
  final Widget? prefixWidget;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.readOnly,
    this.onTap,
    this.suffixIcon,
    this.prefixWidget,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onTap: onTap,
      readOnly: readOnly ?? false,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        prefixIcon: prefixWidget != null
            ? Padding(
          padding: const EdgeInsets.all(10.0),
          child: prefixWidget,
        )
            : prefixIcon != null
            ? Icon(prefixIcon, color: Colors.grey)
            : null,
        suffixIcon: suffixIcon != null ? Icon(suffixIcon, color: Colors.grey) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
      ),
    );
  }
}
