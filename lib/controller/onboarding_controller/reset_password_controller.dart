import 'package:get/get.dart';
import 'package:task_management_app/Screenview/onboarding.dart/login_screen.dart';
import 'package:task_management_app/Screenview/Components/show_snackbar.dart';
import 'package:task_management_app/Screenview/style_&_function/style.dart';
import 'package:task_management_app/data/api_services/network_client.dart';
import 'package:task_management_app/data/api_services/network_response.dart';
import 'package:task_management_app/data/utils/api_urls.dart';

class ResetPasswordController extends GetxController {
  bool _resetPasswordInProgress = false;
  String? _errorMessage;

  bool get resetPasswordInProgress => _resetPasswordInProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> resetPassword(inputNewPasssword) async {
    bool isSuccess = false;
    final args = Get.arguments as Map<String, dynamic>;
    late String email = args['userEmail'];
    late String verifyPin = args['userPin'];
    _resetPasswordInProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "email": email,
      "OTP": verifyPin,
      "password": inputNewPasssword
    };

    NetworkResponse response = await NetworkClient.postRequest(
      url: ApiUrls.recoverResetPasswordUrl,
      body: requestBody,
    );

    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
      SuccessToast("Your password reset successful");
      Get.offAll(() => LoginScreen());
    } else {
      showSnackbarMessage(Get.context!, response.errorMessage, true);
    }
    _resetPasswordInProgress = false;
    update();

    return isSuccess;
  }
}
