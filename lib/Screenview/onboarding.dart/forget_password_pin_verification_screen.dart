import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_management_app/Screenview/Components/background_component.dart';
import 'package:task_management_app/Screenview/Components/center_circular_progress_indecator.dart';
import 'package:task_management_app/Screenview/Components/show_snackbar.dart';
import 'package:task_management_app/Screenview/onboarding.dart/login_screen.dart';
import 'package:task_management_app/Screenview/onboarding.dart/reset_password_screen.dart';
import 'package:task_management_app/Screenview/style_&_function/style.dart';
import 'package:task_management_app/const/app_int.dart';
import 'package:task_management_app/data/api_services/network_client.dart';
import 'package:task_management_app/data/api_services/network_response.dart';
import 'package:task_management_app/data/utils/api_urls.dart';

class ForgetPasswordPinVerificationScreen extends StatefulWidget {
  final String email;
  const ForgetPasswordPinVerificationScreen(this.email, {super.key});

  @override
  State<ForgetPasswordPinVerificationScreen> createState() =>
      _ForgetPasswordPinVerificationScreenState();
}

class _ForgetPasswordPinVerificationScreenState
    extends State<ForgetPasswordPinVerificationScreen> {
  final TextEditingController _pinVerifyController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _pinVerifyInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundComponent(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(AppInt.padding),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Pin Verification",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "A six-digit verification pin has been sent to your email.",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.grey),
                  ),
                  SizedBox(height: 20),
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
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,
                    controller: _pinVerifyController,
                    appContext: context,
                  ),
                  SizedBox(height: 20),
                  _pinVerifyInProgress
                      ? CenterCircularProgressIndecator()
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _onTapSubmitButton,
                            child: Text("Verify"),
                          ),
                        ),
                  SizedBox(height: 30),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        children: [
                          TextSpan(text: "Have an account? "),
                          TextSpan(
                            text: "Sign In",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = _onTapSignInButton,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSubmitButton() {
    if (_formKey.currentState!.validate()) {
      _pinVerification();
    }
  }

  Future<void> _pinVerification() async {
    setState(() {
      _pinVerifyInProgress = true;
    });

    String verifyPin = _pinVerifyController.text.trim();

    NetworkResponse response = await NetworkClient.getRequest(
      url: ApiUrls.recoverVerifyOtpUrl(widget.email, verifyPin),
    );

    setState(() {
      _pinVerifyInProgress = false;
    });
    if (!mounted) return;

    if (response.isSuccess) {
      SuccessToast("OTP successfully verified!");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResetPasswordScreen(widget.email, verifyPin),
        ),
      );
    } else {
      showSnackbarMessage(context, response.errorMessage, true);
    }
  }

  void _onTapSignInButton() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (route) => false,
    );
  }

  // @override
  // void dispose() {
  //   _pinVerifyController.dispose();
  //   super.dispose();
  // }
}
