import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_management_app/Screenview/Components/background_component.dart';
import 'package:task_management_app/Screenview/Components/center_circular_progress_indecator.dart';
import 'package:task_management_app/Screenview/Components/show_snackbar.dart';
import 'package:task_management_app/Screenview/onboarding.dart/forget_password_pin_verification_screen.dart';
import 'package:task_management_app/Screenview/style/style.dart';
import 'package:task_management_app/const/app_int.dart';
import 'package:task_management_app/data/api_services/network_client.dart';
import 'package:task_management_app/data/api_services/network_response.dart';
import 'package:task_management_app/data/utils/api_urls.dart';

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
  bool _emailVerifyInProgress = false;
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
                  validator: (String? value) {
                    String email = value?.trim() ?? '';
                    if (EmailValidator.validate(email) == false) {
                      return "Enter your Email";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 15,
                ),
                Visibility(
                  visible: _emailVerifyInProgress == false,
                  replacement: CenterCircularProgressIndecator(),
                  child: ElevatedButton(
                      onPressed: _onTapEmailverificationButton,
                      child: Text("Submit")),
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
    if (_formkey.currentState!.validate()) {
      emailVerification();
    }
  }

  Future<void> emailVerification() async {
    _emailVerifyInProgress = true;
    String userEmail = _emailController.text.trim();
    setState(() {});

    NetworkResponse response =
        await NetworkClient.getRequest(url: ApiUrls.emailVerifyUrl + userEmail);
    _emailVerifyInProgress = false;
    setState(() {});

    if (response.isSuccess) {
      SuccessToast("A 6 digit OTP code sent to your email");
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
            builder: (context) =>
                ForgetPasswordPinVerificationScreen(userEmail)),
      );
    } else {
      // ignore: use_build_context_synchronously
      showSnackbarMessage(context, response.errorMessage, true);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
