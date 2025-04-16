import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_management_app/Screenview/Components/background_component.dart';
import 'package:task_management_app/Screenview/Components/center_circular_progress_indecator.dart';
import 'package:task_management_app/Screenview/Components/show_snackbar.dart';
import 'package:task_management_app/Screenview/onboarding.dart/login_screen.dart';
import 'package:task_management_app/Screenview/style/style.dart';
import 'package:task_management_app/const/app_int.dart';
import 'package:task_management_app/data/api_services/network_client.dart';
import 'package:task_management_app/data/api_services/network_response.dart';
import 'package:task_management_app/data/utils/api_urls.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  final String verifyPin;
  const ResetPasswordScreen(this.email, this.verifyPin, {super.key});
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _resetPasswordInProgress = false;
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
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: "New Password",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  controller: _confirmpasswordController,
                  decoration: InputDecoration(
                    hintText: "Confirm new Password",
                  ),
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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
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
      "email": widget.email,
      "OTP": widget.verifyPin,
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
