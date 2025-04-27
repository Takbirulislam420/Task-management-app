// ignore: file_names
import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_management_app/Screenview/Components/background_component.dart';
import 'package:task_management_app/Screenview/Components/center_circular_progress_indecator.dart';
import 'package:task_management_app/const/app_int.dart';
import 'package:task_management_app/controller/onboarding_controller/registation_controller.dart';

class RegistationScreen extends StatefulWidget {
  const RegistationScreen({super.key});

  @override
  State<RegistationScreen> createState() => _RegistationScreenState();
}

class _RegistationScreenState extends State<RegistationScreen> {
  final RegistrationController _registrationController =
      Get.find<RegistrationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundComponent(
          child: Container(
        alignment: Alignment.center,
        child: Form(
          key: _registrationController.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    controller: _registrationController.emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                    ),
                    validator: _registrationController.validateEmail,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    controller: _registrationController.fnameController,
                    decoration: InputDecoration(
                      hintText: "First name",
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => _registrationController
                        .validateName(value, fieldName: "First Name"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    controller: _registrationController.lnameController,
                    decoration: InputDecoration(
                      hintText: "Last name",
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => _registrationController
                        .validateName(value, fieldName: "Last Name"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    controller: _registrationController.phoneController,
                    decoration: InputDecoration(
                      hintText: "mobile",
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: _registrationController.validateMobile,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    controller: _registrationController.passwordController,
                    decoration: InputDecoration(
                      hintText: "Password",
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: _registrationController.validatePassword,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    controller:
                        _registrationController.confirmPasswordController,
                    decoration: InputDecoration(
                      hintText: "Confirm password",
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: _registrationController.validateConfirmPassword,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(height: 20),
                  Obx(() {
                    return _registrationController.isLoading.value
                        ? CenterCircularProgressIndecator()
                        : ElevatedButton(
                            onPressed: _registrationController.registerUser,
                            child: Text("Sign up"),
                          );
                  }),
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

  void _ontapSinginButton() {
    Navigator.pop(context);
  }
}
