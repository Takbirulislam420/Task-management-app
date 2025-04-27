import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/Screenview/Components/background_component.dart';
import 'package:task_management_app/Screenview/Components/center_circular_progress_indecator.dart';
import 'package:task_management_app/const/app_int.dart';
import 'package:task_management_app/controller/onboarding_controller/email_verify_controller.dart';

class ForgetPasswordVerifyEmailScreen extends StatefulWidget {
  const ForgetPasswordVerifyEmailScreen({super.key});
  @override
  State<ForgetPasswordVerifyEmailScreen> createState() =>
      _ForgetPasswordVerifyEmailScreenState();
}

class _ForgetPasswordVerifyEmailScreenState
    extends State<ForgetPasswordVerifyEmailScreen> {
  final EmailVerifyController emailVerifyController =
      Get.find<EmailVerifyController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundComponent(
          child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(AppInt.padding),
        child: SingleChildScrollView(
          child: Form(
            key: emailVerifyController.formKey,
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
                  controller: emailVerifyController.emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Email",
                  ),
                  validator: emailVerifyController.validateEmail,
                ),
                SizedBox(
                  height: 10,
                ),
                const SizedBox(height: 15),
                Obx(() => emailVerifyController.isLoading.value
                    ? const CenterCircularProgressIndecator()
                    : ElevatedButton(
                        onPressed: emailVerifyController.submitEmail,
                        child: const Text("Submit"),
                      )),
                const SizedBox(height: 25),
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
}
