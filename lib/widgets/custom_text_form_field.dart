import 'package:flutter/material.dart';
class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    required this.obscureText,
    this.validator,
    required this.controller, this.onChanged,
  });
  final String labelText;
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
    onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(prefixIcon),
        border: const OutlineInputBorder(),
      ),
      obscureText: obscureText,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: const TextStyle(fontSize: 16),
      controller: controller,
    );
  }
}
