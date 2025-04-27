import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/Screenview/Components/show_snackbar.dart';
import 'package:task_management_app/Screenview/onboarding.dart/login_screen.dart';
import 'package:task_management_app/Screenview/onboarding.dart/reset_password_screen.dart';
import 'package:task_management_app/data/api_services/network_client.dart';
import 'package:task_management_app/data/api_services/network_response.dart';
import 'package:task_management_app/data/utils/api_urls.dart';

class PinVerificationController extends GetxController {
  final String email;
  PinVerificationController(this.email);

  final TextEditingController pinVerifyController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var pinVerifyInProgress = false.obs;

  void onTapSubmitButton() {
    if (formKey.currentState!.validate()) {
      pinVerification();
    }
  }

  Future<void> pinVerification() async {
    pinVerifyInProgress.value = true;
    String verifyPin = "/${pinVerifyController.text.trim()}";
    String verifyPinForNav = pinVerifyController.text.trim();

    NetworkResponse response = await NetworkClient.getRequest(
        url: ApiUrls.recoverVerifyOtpUrl + email + verifyPin);

    pinVerifyInProgress.value = false;

    if (response.isSuccess) {
      Get.snackbar("Success", "OTP Successfully verified",
          backgroundColor: Colors.green);
      Get.to(() => ResetPasswordScreen(email, verifyPinForNav));
    } else {
      showSnackbarMessage(Get.context!, response.errorMessage, true);
    }
  }

  void onTapSignInButton() {
    Get.offAll(LoginScreen());
  }

  // @override
  // void onClose() {
  //   pinVerifyController.dispose();
  //   super.onClose();
  // }
}
