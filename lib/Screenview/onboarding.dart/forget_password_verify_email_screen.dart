import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_management_app/Screenview/Components/background_widget.dart';
import 'package:task_management_app/Screenview/onboarding.dart/forget_password_pin_verification_screen.dart';
import 'package:task_management_app/const/app_int.dart';

class ForgetPasswordVerifyEmailScreen extends StatefulWidget {
  const ForgetPasswordVerifyEmailScreen({super.key});
  @override
  State<ForgetPasswordVerifyEmailScreen> createState() =>
      _ForgetPasswordVerifyEmailScreenState();
}

class _ForgetPasswordVerifyEmailScreenState
    extends State<ForgetPasswordVerifyEmailScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
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
                  "Your Email address",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  "A six digit verification pin will be send to your email",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.grey),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Email",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    onPressed: _onTapEmailverificationButton,
                    child: Text("Submit")),
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
                            TextSpan(text: " have account?"),
                            TextSpan(
                              text: "Sing in",
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
    Navigator.pop(context);
  }

  void _onTapEmailverificationButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ForgetPasswordPinVerificationScreen()),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
