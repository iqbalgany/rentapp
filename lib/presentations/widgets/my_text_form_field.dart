import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final String? hintText;
  final IconData? prefixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  const MyTextFormField({
    super.key,
    this.hintText,
    this.prefixIcon,
    this.obscureText = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(30),
        ),
        prefixIcon: Icon(prefixIcon, color: Colors.grey),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
      ),
    );
  }
}
