import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class EmailTextFieldComponent extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const EmailTextFieldComponent({
    super.key,
    required this.controller,
    this.hintText = 'Enter a valid email address',
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      validator: (String? value) {
        String email = value?.trim() ?? '';
        if (!EmailValidator.validate(email)) {
          return hintText;
        } else {
          return null;
        }
      },
    );
  }
}
