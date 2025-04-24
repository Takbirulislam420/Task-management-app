import 'package:get/get.dart';
import 'package:task_management_app/data/api_services/network_client.dart';
import 'package:task_management_app/data/api_services/network_response.dart';
import 'package:task_management_app/data/utils/api_urls.dart';

class UpdateAndDeleteTaskController extends GetxController {
  bool _updateAndDeleteTaskInProgress = false;
  String? _errorMessage;

  bool get updateAndDeleteTaskInProgress => _updateAndDeleteTaskInProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> getUpdateTaskStatus(String id, String taskstatus) async {
    bool isSuccess = false;
    _updateAndDeleteTaskInProgress = true;
    update();

    final NetworkResponse response = await NetworkClient.getRequest(
        url: ApiUrls.updateStatusTaskUrl(id, taskstatus));

    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    _updateAndDeleteTaskInProgress = false;
    update();
    return isSuccess;
  }

  Future<bool> getDeleteTaskStatus(String id) async {
    bool isSuccess = false;
    _updateAndDeleteTaskInProgress = true;
    update();

    final NetworkResponse response =
        await NetworkClient.getRequest(url: ApiUrls.deleteTaskUrl(id));

    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    _updateAndDeleteTaskInProgress = false;
    update();
    return isSuccess;
  }
}
