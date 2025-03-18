import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_management_app/Screenview/Components/background_widget.dart';
import 'package:task_management_app/const/app_int.dart';

class RegistationScreen extends StatefulWidget {
  const RegistationScreen({super.key});

  @override
  State<RegistationScreen> createState() => _RegistationScreenState();
}

class _RegistationScreenState extends State<RegistationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
          child: Container(
        alignment: Alignment.center,
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(AppInt.padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Join with us",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    controller: _fnameController,
                    decoration: InputDecoration(
                      hintText: "First name",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    controller: _lnameController,
                    decoration: InputDecoration(
                      hintText: "Last name",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    controller: _phoneController,
                    decoration: InputDecoration(
                      hintText: "mobile",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: "Password",
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
                      hintText: "Confirm password",
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      onPressed: _onTapSubmitbuttom, child: Text("Sign up")),
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
                              TextSpan(text: "have you account?"),
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
        ),
      )),
    );
  }

  void _onTapSubmitbuttom() {}

  void _ontapSinginButton() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _fnameController.dispose();
    _lnameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    super.dispose();
  }
}
