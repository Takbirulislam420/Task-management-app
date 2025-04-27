import 'package:get/get.dart';
import 'package:task_management_app/data/api_services/network_client.dart';
import 'package:task_management_app/data/api_services/network_response.dart';
import 'package:task_management_app/data/utils/api_urls.dart';

class AddNewTaskController extends GetxController {
  bool _addNewTaskInProgress = false;
  String? _errorMessage;

  bool get addNewTaskInProgress => _addNewTaskInProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> addNewTask(
      String title, String description, String status) async {
    bool isSuccess = false;
    _addNewTaskInProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "title": title,
      "description": description,
      "status": status
    };

    NetworkResponse response = await NetworkClient.postRequest(
        url: ApiUrls.createTaskUrl, body: requestBody);

    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    _addNewTaskInProgress = false;
    update();
    return isSuccess;
  }
}
