import 'package:get/get.dart';
import 'package:task_management_app/data/api_services/network_client.dart';
import 'package:task_management_app/data/api_services/network_response.dart';
import 'package:task_management_app/data/model/task_list_model.dart';
import 'package:task_management_app/data/model/task_model.dart';
import 'package:task_management_app/data/utils/api_urls.dart';

class ComplatedTaskController extends GetxController {
  bool _complatedTaskInProgress = false;
  String? _errorMessage;
  List<TaskModel> _complatedTaskList = [];

  bool get complatedTaskInProgress => _complatedTaskInProgress;
  String? get errorMessage => _errorMessage;
  List<TaskModel> get complatedTaskList => _complatedTaskList;

  Future<bool> getPprogressTaskList() async {
    bool isSuccess = false;
    _complatedTaskInProgress = true;
    update();
    //start
    NetworkResponse response =
        await NetworkClient.getRequest(url: ApiUrls.complatedTaskListUrl);
    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _complatedTaskList = taskListModel.taskList;
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    //end
    _complatedTaskInProgress = false;
    update();
    return isSuccess;
  }
}
