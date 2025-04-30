import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_management_app/Screenview/Components/background_component.dart';
import 'package:task_management_app/Screenview/Components/center_circular_progress_indecator.dart';
import 'package:task_management_app/const/app_int.dart';
import 'package:task_management_app/const/app_string.dart';
import 'package:task_management_app/controller/onboarding_controller/pin_verification_controller.dart';

// ignore: must_be_immutable
class ForgetPasswordPinVerificationScreen extends StatelessWidget {
  ForgetPasswordPinVerificationScreen({super.key});

  final argss = Get.arguments as Map<String, dynamic>;
  late String email = argss['userEmail'];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PinVerificationController>(
      init: PinVerificationController(email),
      builder: (pinVerifyController) => Scaffold(
        body: BackgroundComponent(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(AppInt.padding),
            child: SingleChildScrollView(
              child: Form(
                key: pinVerifyController.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppString.pinVerification,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      AppString.sendOtpTextui,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.grey),
                    ),
                    SizedBox(height: 15),
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
                      controller: pinVerifyController.pinVerifyController,
                      appContext: context,
                    ),
                    SizedBox(height: 15),
                    Obx(() => pinVerifyController.pinVerifyInProgress.value
                        ? CenterCircularProgressIndecator()
                        : ElevatedButton(
                            onPressed: pinVerifyController.onTapSubmitButton,
                            child: Text(AppString.verifyText),
                          )),
                    SizedBox(height: 25),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(text: AppString.alreadyHaveAccount),
                            TextSpan(
                              text: AppString.loginButtonText,
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = pinVerifyController.onTapSignInButton,
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
      ),
    );
  }
}
