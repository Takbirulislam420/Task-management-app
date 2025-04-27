import 'package:get/get.dart';
import 'package:task_management_app/data/api_services/network_client.dart';
import 'package:task_management_app/data/api_services/network_response.dart';
import 'package:task_management_app/data/utils/api_urls.dart';

class UpdateAndDeleteTaskController extends GetxController {
  // Map to store the loading state for each task
  var taskLoadingStates = <String, RxBool>{};

  Future<bool> getUpdateTaskStatus(String id, String taskstatus) async {
    // Set the task's loading state to true
    taskLoadingStates[id] = true.obs;
    update();

    final NetworkResponse response = await NetworkClient.getRequest(
        url: ApiUrls.updateStatusTaskUrl(id, taskstatus));

    bool isSuccess = response.isSuccess;
    if (isSuccess) {
      taskLoadingStates[id] =
          false.obs; // Set loading state to false after success
      update();
    } else {
      taskLoadingStates[id] = false.obs;
      update();
    }
    return isSuccess;
  }

  Future<bool> getDeleteTaskStatus(String id) async {
    // Set the task's loading state to true
    taskLoadingStates[id] = true.obs;
    update();

    final NetworkResponse response =
        await NetworkClient.getRequest(url: ApiUrls.deleteTaskUrl(id));

    bool isSuccess = response.isSuccess;
    if (isSuccess) {
      taskLoadingStates[id] =
          false.obs; // Set loading state to false after success
      update();
    } else {
      taskLoadingStates[id] = false.obs;
      update();
    }
    return isSuccess;
  }

  RxBool getTaskLoadingState(String id) {
    return taskLoadingStates[id] ??
        false.obs; // Return the loading state for a task
  }
}
