import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:email_validator/email_validator.dart';
import 'package:task_management_app/const/app_string.dart';
import 'package:task_management_app/data/api_services/network_client.dart';
import 'package:task_management_app/data/api_services/network_response.dart';
import 'package:task_management_app/data/utils/api_urls.dart';
import 'package:task_management_app/Screenview/Components/show_snackbar.dart';
import 'package:task_management_app/Screenview/onboarding.dart/forget_password_pin_verification_screen.dart';

class EmailVerifyController extends GetxController {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var isLoading = false.obs;

  String? validateEmail(String? value) {
    String email = value?.trim() ?? '';
    if (!EmailValidator.validate(email)) {
      return AppString.enterValidEmail;
    }
    return null;
  }

  void submitEmail() {
    if (formKey.currentState!.validate()) {
      verifyEmail();
    }
  }

  Future<void> verifyEmail() async {
    isLoading.value = true;
    String userEmail = emailController.text.trim();

    NetworkResponse response =
        await NetworkClient.getRequest(url: ApiUrls.emailVerifyUrl + userEmail);
    isLoading.value = false;

    if (response.isSuccess) {
      Get.snackbar(
        AppString.successText,
        AppString.sendOtpText,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
      Get.to(() => ForgetPasswordPinVerificationScreen(userEmail));
    } else {
      showSnackbarMessage(Get.context!, response.errorMessage, true);
    }
  }

  // @override
  // void onClose() {
  //   emailController.dispose();
  //   super.onClose();
  // }
}
