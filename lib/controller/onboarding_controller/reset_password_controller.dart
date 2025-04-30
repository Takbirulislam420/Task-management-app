import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/Screenview/onboarding.dart/login_screen.dart';
import 'package:task_management_app/Screenview/Components/show_snackbar.dart';
import 'package:task_management_app/Screenview/style_&_function/style.dart';
import 'package:task_management_app/data/api_services/network_client.dart';
import 'package:task_management_app/data/api_services/network_response.dart';
import 'package:task_management_app/data/utils/api_urls.dart';

class ResetPasswordController extends GetxController {
  static ResetPasswordController get to => Get.put(ResetPasswordController());
  final args = Get.arguments as Map<String, dynamic>;
  late String email = args['userEmail'];
  late String verifyPin = args['userPin'];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  var resetPasswordInProgress = false.obs;
  var passwordVisible = false.obs;
  var confirmPasswordVisible = false.obs;

  String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    } else if (value.trim().length < 4) {
      return 'Password must be at least 4 characters';
    } else if (value.trim().length > 15) {
      return 'Password must not exceed 15 characters';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Confirm password is required';
    } else if (value.trim() != passwordController.text.trim()) {
      return 'Passwords do not match';
    }
    return null;
  }

  void onTapSubmitButton() {
    if (formKey.currentState!.validate()) {
      resetPassword();
    }
  }

  void onTapSignInButton() {
    Get.offAll(() => LoginScreen());
  }

  Future<void> resetPassword() async {
    resetPasswordInProgress.value = true;
    Map<String, dynamic> requestBody = {
      "email": email,
      "OTP": verifyPin,
      "password": passwordController.text.trim(),
    };

    NetworkResponse response = await NetworkClient.postRequest(
      url: ApiUrls.recoverResetPasswordUrl,
      body: requestBody,
    );

    if (response.isSuccess) {
      resetPasswordInProgress.value = false;
      SuccessToast("Your password reset successful");
      Get.offAll(() => LoginScreen());
    } else {
      resetPasswordInProgress.value = false;
      showSnackbarMessage(Get.context!, response.errorMessage, true);
    }
  }

  @override //not need use in getx controller ,getx will handel this
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
