import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/Screenview/Components/background_component.dart';
import 'package:task_management_app/Screenview/Components/center_circular_progress_indecator.dart';
import 'package:task_management_app/Screenview/Components/show_snackbar.dart';
import 'package:task_management_app/Screenview/onboarding.dart/login_screen.dart';
import 'package:task_management_app/Screenview/style_&_function/style.dart';
import 'package:task_management_app/const/app_int.dart';
import 'package:task_management_app/const/app_string.dart';
import 'package:task_management_app/controller/onboarding_controller/reset_password_controller.dart';

class NewPasswordReset extends StatefulWidget {
  const NewPasswordReset({super.key});
  @override
  State<NewPasswordReset> createState() => _NewPasswordResetState();
}

class _NewPasswordResetState extends State<NewPasswordReset> {
  final args = Get.arguments as Map<String, dynamic>;
  late String email = args['userEmail'];
  late String verifyPin = args['userPin'];

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final ResetPasswordController resetPasswordController =
      Get.find<ResetPasswordController>();
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundComponent(
          child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(AppInt.padding),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Set your password",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                    obscureText: false,
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      hintText: AppString.passwordHintText,
                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(10),),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 12), // fixes vertical alignment
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
                    }),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                    obscureText: _isObscured,
                    controller: _confirmpasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      hintText: AppString.passwordHintText,
                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(10),),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 12), // fixes vertical alignment
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(
                            right: 8.0), // optional, for better spacing
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              _isObscured = !_isObscured;
                            });
                          },
                          icon: Icon(
                            _isObscured
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      suffixIconConstraints: BoxConstraints(
                        minHeight: 40,
                        minWidth: 40,
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Confirm password is required';
                      } else if (value.trim() !=
                          _passwordController.text.trim()) {
                        return 'Passwords do not match';
                      }
                      return null;
                    }),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 15,
                ),
                GetBuilder<ResetPasswordController>(builder: (controller) {
                  return Visibility(
                    visible: controller.resetPasswordInProgress == false,
                    replacement: CenterCircularProgressIndecator(),
                    child: ElevatedButton(
                        onPressed: _ontapSubmitButton, child: Text("Submit")),
                  );
                }),
                SizedBox(
                  height: 25,
                ),
                Center(
                  child: Column(
                    children: [
                      RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                              children: [
                            TextSpan(text: "Don't have account?"),
                            TextSpan(
                              text: " Sing in",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()
                                ..onTap = _ontapSinginButton,
                            ),
                          ]))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  void _ontapSinginButton() {
    Get.offAll(LoginScreen());
  }

  void _ontapSubmitButton() {
    if (_formkey.currentState!.validate()) {
      resetPassword();
    }
  }

  Future<void> resetPassword() async {
    String newPassword = _passwordController.text.trim();
    bool isSuccess = await resetPasswordController.resetPassword(newPassword);
    if (isSuccess) {
      SuccessToast("Your password reset successful");
      Get.offAll(LoginScreen());
    } else {
      // ignore: use_build_context_synchronously
      showSnackbarMessage(context, resetPasswordController.errorMessage!, true);
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    super.dispose();
  }
}
