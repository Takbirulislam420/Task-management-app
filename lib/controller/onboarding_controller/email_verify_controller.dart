import 'package:get/get.dart';
import 'package:task_management_app/data/api_services/network_client.dart';
import 'package:task_management_app/data/api_services/network_response.dart';
import 'package:task_management_app/data/utils/api_urls.dart';

class EmailVerifyController extends GetxController {
  bool _emailVerifyInProgress = false;
  String? _errorMessage;

  bool get emailVerifyInProgress => _emailVerifyInProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> getEmailVerify(inputEmail) async {
    bool isSuccess = false;
    _emailVerifyInProgress = true;
    update();
    //start
    NetworkResponse response =
        await NetworkClient.getRequest(url: ApiUrls.emailVerifyUrl(inputEmail));
    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    //end

    _emailVerifyInProgress = false;
    update();
    return isSuccess;
  }
}
