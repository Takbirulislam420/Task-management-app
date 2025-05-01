import 'package:flutter/material.dart';

class PasswordComponent extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const PasswordComponent({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: false,
      controller: controller,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      maxLength: 15,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        counterText: "",
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12,
        ),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (String? value) {
        if (value == null || value.trim().isEmpty) {
          return 'Password is required';
        } else if (value.trim().length < 4) {
          return 'Password must be at least 4 characters';
        } else if (value.trim().length > 15) {
          return 'Password must not exceed 15 characters';
        }
        return null;
      },
    );
  }
}
