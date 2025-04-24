import 'package:get/get.dart';
import 'package:task_management_app/Screenview/controller/auth_controller.dart';
import 'package:task_management_app/data/api_services/network_client.dart';
import 'package:task_management_app/data/api_services/network_response.dart';
import 'package:task_management_app/data/model/login_model.dart';
import 'package:task_management_app/data/utils/api_urls.dart';

class LoginController extends GetxController {
  bool _loginInProgress = false;
  String? _errorMessage;

  bool get loginInProgress => _loginInProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> logInUser(String email, String password) async {
    bool isSuccess = false;
    _loginInProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "email": email,
      "password": password,
    };

    NetworkResponse response = await NetworkClient.postRequest(
        url: ApiUrls.userLogin, body: requestBody);

    if (response.isSuccess) {
      LoginModel loginModel = LoginModel.fromJson(response.data!);
      await AuthController.to
          .saveUserInformation(loginModel.token, loginModel.userModel);
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    _loginInProgress = false;
    update();
    return isSuccess;
  }
}
