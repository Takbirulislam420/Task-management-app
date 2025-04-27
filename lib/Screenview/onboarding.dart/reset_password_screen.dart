import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/Screenview/Components/background_component.dart';
import 'package:task_management_app/Screenview/Components/center_circular_progress_indecator.dart';
import 'package:task_management_app/const/app_int.dart';
import 'package:task_management_app/const/app_string.dart';
import 'package:task_management_app/controller/onboarding_controller/reset_password_controller.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String email;
  final String verifyPin;

  const ResetPasswordScreen(this.email, this.verifyPin, {super.key});

  @override
  Widget build(BuildContext context) {
    final ResetPasswordController controller =
        Get.put(ResetPasswordController(email, verifyPin));

    return Scaffold(
      body: BackgroundComponent(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(AppInt.padding),
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Set your password",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 15),
                  Obx(
                    () => TextFormField(
                      obscureText: false,
                      keyboardType: TextInputType.visiblePassword,
                      controller: controller.passwordController,
                      textInputAction: TextInputAction.done,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        hintText: AppString.passwordHintText,
                        // border: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(10),),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 12), // fixes vertical alignment
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: controller.validateConfirmPassword,
                    ),
                  ),
                  SizedBox(height: 10),
                  Obx(
                    () => TextFormField(
                      obscureText: !controller.passwordVisible.value,
                      keyboardType: TextInputType.visiblePassword,
                      controller: controller.confirmPasswordController,
                      textInputAction: TextInputAction.done,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        hintText: AppString.passwordHintText,
                        // border: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(10),),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 12), // fixes vertical alignment
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(
                              right: 8.0), // optional, for better spacing
                          child: IconButton(
                            icon: Icon(
                              controller.passwordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              controller.passwordVisible.toggle();
                            },
                          ),
                        ),
                        suffixIconConstraints: BoxConstraints(
                          minHeight: 40,
                          minWidth: 40,
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: controller.validateConfirmPassword,
                    ),
                  ),
                  SizedBox(height: 15),
                  Obx(() => controller.resetPasswordInProgress.value
                      ? CenterCircularProgressIndecator()
                      : ElevatedButton(
                          onPressed: controller.onTapSubmitButton,
                          child: Text("Submit"),
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
                          TextSpan(text: "Don't have account?"),
                          TextSpan(
                            text: " Sign in",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = controller.onTapSignInButton,
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
}
