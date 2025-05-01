import 'package:flutter/material.dart';

class LoginPasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String errorText;

  const LoginPasswordTextField({
    super.key,
    required this.controller,
    this.hintText = 'Enter your password',
    this.errorText = 'Password must be at least 6 characters',
  });

  @override
  State<LoginPasswordTextField> createState() => _LoginPasswordTextFieldState();
}

class _LoginPasswordTextFieldState extends State<LoginPasswordTextField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _isObscured,
      controller: widget.controller,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        hintText: widget.hintText,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12,
        ),
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
        if ((value?.isEmpty ?? true) || value!.length < 6) {
          return widget.errorText;
        }
        return null;
      },
    );
  }
}
