import 'package:get/get.dart';
import 'package:task_management_app/Screenview/onboarding.dart/login_screen.dart';
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
      return 'Email is required';
    } else if (value.trim().length > 30) {
      return 'Email must not exceed 20 characters';
    } else if (!EmailValidator.validate(value.trim())) {
      return 'Enter a valid email';
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
      return 'Mobile number is required';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 4) {
      return 'Password must be at least 4 characters';
    } else if (value.length > 15) {
      return 'Password must not exceed 15 characters';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    } else if (value.length < 4) {
      return 'Password must be at least 4 characters';
    } else if (value.length > 15) {
      return 'Password must not exceed 15 characters';
    } else if (value != passwordController.text) {
      return 'Passwords do not match';
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
        'Success',
        'Registration Successful!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );

      Get.offAll(LoginScreen());
    } else {
      isLoading.value = false;
      _errorMessage = response.errorMessage;
      Get.snackbar(
        'Unsuccesfull',
        _errorMessage!,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    fnameController.dispose();
    lnameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
