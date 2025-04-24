import 'package:get/get.dart';
import 'package:task_management_app/data/api_services/network_client.dart';
import 'package:task_management_app/data/api_services/network_response.dart';
import 'package:task_management_app/data/utils/api_urls.dart';

class UpdateProfileController extends GetxController {
  bool _updateProfileInProgress = false;
  String? _errorMessage;

  bool get updateProfileInProgress => _updateProfileInProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> getUpdateProfile(Map<String, dynamic> getRequestBosy) async {
    bool isSuccess = false;
    _updateProfileInProgress = true;
    update();
    NetworkResponse response = await NetworkClient.postRequest(
        url: ApiUrls.userUpdateProfile, body: getRequestBosy);

    if (response.isSuccess) {
      if (response.isSuccess) {
        // LoginModel loginModel = LoginModel.fromJson(response.data!);
        // await AuthController.saveUserInformation(
        //     AuthController.token!, loginModel.userModel);
        isSuccess = true;
        _errorMessage = null;
      }
    } else {
      _errorMessage = response.errorMessage;
    }
    _updateProfileInProgress = false;
    update();
    return isSuccess;
  }
}
