import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/Screenview/Components/background_component.dart';
import 'package:task_management_app/Screenview/Components/center_circular_progress_indecator.dart';
import 'package:task_management_app/Screenview/Components/show_snackbar.dart';
import 'package:task_management_app/Screenview/onboarding.dart/forget_password_verify_email_screen.dart';
import 'package:task_management_app/Screenview/onboarding.dart/registation_Screen.dart';
import 'package:task_management_app/Screenview/tesk/home_screen.dart';
import 'package:task_management_app/const/app_int.dart';
import 'package:task_management_app/const/app_string.dart';
import 'package:task_management_app/getcontroller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final LoginController _loginController = Get.find<LoginController>();
  // To toggle password visibility
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
                TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    //labelText: 'Email',
                    hintText: AppString.emailHintText,
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
                TextFormField(
                  obscureText: _isObscured,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  controller: _passwordController,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                      //labelText: 'Password',
                      hintText: AppString.passwordHintText,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isObscured =
                                !_isObscured; // Toggle password visibility
                          });
                        },
                        icon: Icon(
                          _isObscured ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey,
                        ),
                      )),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if ((value?.isEmpty ?? true) || (value!.length < 6)) {
                      return "Enter your Password";
                    } else {
                      return null;
                    }
                  },
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
      // showSnackbarMessage(context, "Login successfull");
      Navigator.pushAndRemoveUntil(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (pre) => false);
    } else {
      // ignore: use_build_context_synchronously
      showSnackbarMessage(context, _loginController.errorMessage!, true);
    }
  }

  void _ontapSingUpButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegistationScreen()),
    );
  }

  void _ontapForgetPasswordButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ForgetPasswordVerifyEmailScreen()),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
