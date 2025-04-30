import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/Screenview/Components/show_snackbar.dart';
import 'package:task_management_app/Screenview/onboarding.dart/login_screen.dart';
import 'package:task_management_app/Screenview/onboarding.dart/new_password_reset.dart';
import 'package:task_management_app/data/api_services/network_client.dart';
import 'package:task_management_app/data/api_services/network_response.dart';
import 'package:task_management_app/data/utils/api_urls.dart';

class PinVerificationController extends GetxController {
  late String verifyEmailFromScreen;
  PinVerificationController(this.verifyEmailFromScreen);

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
    String verifyPin = pinVerifyController.text.trim();

    NetworkResponse response = await NetworkClient.getRequest(
        url: ApiUrls.recoverVerifyOtpUrl(verifyEmailFromScreen, verifyPin));

    pinVerifyInProgress.value = false;

    if (response.isSuccess) {
      Get.snackbar("Success",
          "$verifyPin OTP Successfully verified $verifyEmailFromScreen ",
          backgroundColor: Colors.green);
      //Get.to(() => ResetPasswordScreen(verifyEmailFromScreen, verifyPin));
      //Get.to(ResetPasswordScreen());
      Get.to(() => NewPasswordReset(), arguments: {
        'userEmail': verifyEmailFromScreen,
        'userPin': verifyPin
      });
      // Get.delete<PinVerificationController>();
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
