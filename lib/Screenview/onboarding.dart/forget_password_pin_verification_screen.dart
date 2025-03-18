import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_management_app/Screenview/onboarding.dart/login_screen.dart';
import 'package:task_management_app/Screenview/onboarding.dart/reset_password_screen.dart';
import 'package:task_management_app/Screenview/Components/background_widget.dart';
import 'package:task_management_app/const/app_int.dart';

class ForgetPasswordPinVerificationScreen extends StatefulWidget {
  const ForgetPasswordPinVerificationScreen({super.key});
  @override
  State<ForgetPasswordPinVerificationScreen> createState() =>
      _ForgetPasswordPinVerificationScreenState();
}

class _ForgetPasswordPinVerificationScreenState
    extends State<ForgetPasswordPinVerificationScreen> {
  final TextEditingController _pinVerifyController = TextEditingController();
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
                  "Pin verification",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  "A six digit verification pin has been send to your email.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.grey),
                ),
                SizedBox(
                  height: 15,
                ),
                PinCodeTextField(
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                    //inactiveFillColor: Colors.blueAccent,
                    //selectedFillColor: Colors.amber
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  controller: _pinVerifyController,
                  appContext: context,
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    onPressed: _ontapSubmitButton, child: Text("Verify")),
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

  void _ontapSubmitButton() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ResetPasswordScreen()));
  }

  void _ontapSinginButton() {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => LoginScreen()), (pre) => false);
  }

  @override
  void dispose() {
    // _pinVerifyController.dispose();
    super.dispose();
  }
}
