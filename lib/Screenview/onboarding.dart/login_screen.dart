import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_management_app/Screenview/Components/background_widget.dart';
import 'package:task_management_app/Screenview/onboarding.dart/forget_password_verify_email_screen.dart';
import 'package:task_management_app/Screenview/onboarding.dart/registation_Screen.dart';
import 'package:task_management_app/Screenview/tesk/home_screen.dart';
import 'package:task_management_app/const/app_int.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  // To toggle password visibility
  bool _isObscured = true;
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
                  "Get Started with",
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
                    hintText: 'Enter your email',
                    hintStyle: TextStyle(height: 1.5),
                  ),
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
                      hintText: 'Enter your password',
                      hintStyle: TextStyle(height: 1.5),
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
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    onPressed: _ontapLogInButton, child: Text("Log in")),
                SizedBox(
                  height: 25,
                ),
                Center(
                  child: Column(
                    children: [
                      TextButton(
                          onPressed: _ontapForgetPasswordButton,
                          child: Text(
                            "forget password?",
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
                            TextSpan(text: "Don't have account?"),
                            TextSpan(
                              text: "Sing up",
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
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => HomeScreen()), (pre) => false);
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => HomeScreen()),
    // );
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
