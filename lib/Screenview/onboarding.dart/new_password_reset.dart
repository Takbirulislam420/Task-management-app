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
import 'package:task_management_app/data/api_services/network_client.dart';
import 'package:task_management_app/data/api_services/network_response.dart';
import 'package:task_management_app/data/utils/api_urls.dart';

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
  bool _resetPasswordInProgress = false;
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
                Visibility(
                  visible: _resetPasswordInProgress == false,
                  replacement: CenterCircularProgressIndecator(),
                  child: ElevatedButton(
                      onPressed: _ontapSubmitButton, child: Text("Submit")),
                ),
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
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => LoginScreen()),
    // );
    Get.offAll(LoginScreen());
  }

  void _ontapSubmitButton() {
    if (_formkey.currentState!.validate()) {
      if (_passwordController.text == _confirmpasswordController.text) {
        resetPassword();
      } else {
        showSnackbarMessage(context, "Password should be same", true);
      }
    }
    // Navigator.pushAndRemoveUntil(context,
    //     MaterialPageRoute(builder: (context) => LoginScreen()), (pre) => false);
  }

  Future<void> resetPassword() async {
    _resetPasswordInProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "email": email,
      "OTP": verifyPin,
      "password": _passwordController.text.trim()
    };

    NetworkResponse response = await NetworkClient.postRequest(
        url: ApiUrls.recoverResetPasswordUrl, body: requestBody);
    _resetPasswordInProgress = false;
    setState(() {});

    if (response.isSuccess) {
      SuccessToast("Your password reset successful");
      Navigator.pushAndRemoveUntil(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (pre) => false);
    } else {
      // ignore: use_build_context_synchronously
      showSnackbarMessage(context, response.errorMessage, true);
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    super.dispose();
  }
}
