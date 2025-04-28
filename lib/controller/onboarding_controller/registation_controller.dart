import 'package:get/get.dart';
import 'package:task_management_app/Screenview/onboarding.dart/login_screen.dart';
import 'package:task_management_app/const/app_string.dart';
import 'package:task_management_app/data/api_services/network_client.dart';
import 'package:task_management_app/data/api_services/network_response.dart';
import 'package:task_management_app/data/utils/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class RegistrationController extends GetxController {
  final emailController = TextEditingController();
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isLoading = false.obs;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  final formKey = GlobalKey<FormState>();

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppString.emailRequiredText;
    } else if (value.trim().length > 30) {
      return AppString.emailNotMoreThenTweenty;
    } else if (!EmailValidator.validate(value.trim())) {
      return AppString.enterValidEmail;
    }
    return null;
  }

  String? validateName(String? value, {String fieldName = "Name"}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    } else if (value.trim().length < 5) {
      return '$fieldName must be at least 5 characters';
    } else if (value.trim().length > 15) {
      return '$fieldName must not exceed 15 characters';
    }
    return null;
  }

  String? validateMobile(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppString.mobileRequiredText;
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppString.passwordRequired;
    } else if (value.length < 4) {
      return AppString.passwordMinimumLength;
    } else if (value.length > 15) {
      return AppString.passwordMaximumLength;
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppString.confirmPasswordRequired;
    } else if (value.length < 4) {
      return AppString.passwordMinimumLength;
    } else if (value.length > 15) {
      return AppString.passwordMaximumLength;
    } else if (value != passwordController.text) {
      return AppString.passwordNOtMatch;
    }
    return null;
  }

  void registerUser() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;
    Map<String, dynamic> requestBody = {
      "email": emailController.text.trim(),
      "firstName": fnameController.text.trim(),
      "lastName": lnameController.text.trim(),
      "mobile": phoneController.text.trim(),
      "password": passwordController.text,
    };

    NetworkResponse response = await NetworkClient.postRequest(
        url: ApiUrls.userRegistation, body: requestBody);

    if (response.isSuccess) {
      isLoading.value = false;
      _errorMessage = null;
      Get.snackbar(
        AppString.successText,
        AppString.registrationSuccessfullText,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );

      Get.offAll(LoginScreen());
    } else {
      isLoading.value = false;
      _errorMessage = response.errorMessage;
      Get.snackbar(
        AppString.unSuccessText,
        _errorMessage!,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
    }
  }

  // @override   // not need to use ondispose/onClose because getx will be handel it.
  // void onClose() {
  //   emailController.dispose();
  //   fnameController.dispose();
  //   lnameController.dispose();
  //   phoneController.dispose();
  //   passwordController.dispose();
  //   confirmPasswordController.dispose();
  //   super.onClose();
  // }
}
