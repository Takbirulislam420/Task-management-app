import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/Screenview/Components/background_component.dart';
import 'package:task_management_app/Screenview/Components/center_circular_progress_indecator.dart';
import 'package:task_management_app/Screenview/Components/email_text_field_component.dart';
import 'package:task_management_app/Screenview/Components/login_password_text_field.dart';
import 'package:task_management_app/Screenview/Components/show_snackbar.dart';
import 'package:task_management_app/Screenview/onboarding.dart/forget_password_verify_email_screen.dart';
import 'package:task_management_app/Screenview/onboarding.dart/registation_Screen.dart';
import 'package:task_management_app/Screenview/tesk/home_screen.dart';
import 'package:task_management_app/const/app_int.dart';
import 'package:task_management_app/const/app_string.dart';
import 'package:task_management_app/controller/onboarding_controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  //another way to use getx
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final LoginController _loginController = Get.find<LoginController>();

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
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppString.getStart,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 15,
                ),
                EmailTextFieldComponent(
                  controller: _emailController,
                ),
                SizedBox(
                  height: 10,
                ),
                LoginPasswordTextField(
                  controller: _passwordController,
                ),
                SizedBox(
                  height: 15,
                ),
                GetBuilder<LoginController>(builder: (controller) {
                  return Visibility(
                    visible: controller.loginInProgress == false,
                    replacement: CenterCircularProgressIndecator(),
                    child: ElevatedButton(
                        onPressed: _ontapLogInButton,
                        child: Text(AppString.loginButtonText)),
                  );
                }),
                SizedBox(
                  height: 25,
                ),
                Center(
                  child: Column(
                    children: [
                      TextButton(
                          onPressed: _ontapForgetPasswordButton,
                          child: Text(
                            AppString.forgetPassword,
                            style: TextStyle(color: Colors.black54),
                            textAlign: TextAlign.center,
                          )),
                      RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                              children: [
                            TextSpan(text: AppString.dontHaveAccount),
                            TextSpan(
                              text: AppString.singUp,
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()
                                ..onTap = _ontapSingUpButton,
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

  void _ontapLogInButton() {
    if (_formKey.currentState!.validate()) {
      _logInUser();
    }
  }

  Future<void> _logInUser() async {
    final bool isSuccess = await _loginController.logInUser(
        _emailController.text.trim(), _passwordController.text);
    if (isSuccess) {
      Get.offAll(HomeScreen());
    } else {
      // ignore: use_build_context_synchronously
      showSnackbarMessage(context, _loginController.errorMessage!, true);
    }
  }

  void _ontapSingUpButton() {
    Get.to(RegistationScreen());
  }

  void _ontapForgetPasswordButton() {
    Get.to(ForgetPasswordVerifyEmailScreen());
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
