import 'package:flutter/material.dart';

class ConfirmPasswordComponent extends StatefulWidget {
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final String hintText;

  const ConfirmPasswordComponent({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
    this.hintText = 'Confirm your password',
  });

  @override
  State<ConfirmPasswordComponent> createState() =>
      _ConfirmPasswordComponentState();
}

class _ConfirmPasswordComponentState extends State<ConfirmPasswordComponent> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _isObscured,
      controller: widget.confirmPasswordController,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        hintText: widget.hintText,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
            onPressed: () {
              setState(() {
                _isObscured = !_isObscured;
              });
            },
            icon: Icon(
              _isObscured ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
          ),
        ),
        suffixIconConstraints: const BoxConstraints(
          minHeight: 40,
          minWidth: 40,
        ),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (String? value) {
        if (value == null || value.trim().isEmpty) {
          return 'Confirm password is required';
        } else if (value.trim() != widget.passwordController.text.trim()) {
          return 'Passwords do not match';
        }
        return null;
      },
    );
  }
}
