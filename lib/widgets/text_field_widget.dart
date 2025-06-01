import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final Icon icon;
  final TextInputType? keyboard;
  final int? maxLines;

  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.icon,
    this.maxLines,
    this.keyboard,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboard ?? TextInputType.text,
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: labelText,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.black87, fontSize: 14),
        prefixIcon: icon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFB0BEC5)),
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 12,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.indigoAccent, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
