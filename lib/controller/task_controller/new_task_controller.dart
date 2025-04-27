import 'package:get/get.dart';
import 'package:task_management_app/data/api_services/network_client.dart';
import 'package:task_management_app/data/api_services/network_response.dart';
import 'package:task_management_app/data/model/task_list_model.dart';
import 'package:task_management_app/data/model/task_model.dart';
import 'package:task_management_app/data/utils/api_urls.dart';

class NewTaskController extends GetxController {
  bool _getNewTaskInProgress = false;
  String? _errorMessage;
  List<TaskModel> _newTaskList = [];

  bool get getNewTaskInProgress => _getNewTaskInProgress;
  String? get errorMessage => _errorMessage;
  List<TaskModel> get newTaskList => _newTaskList;

  Future<bool> getNewTaskList() async {
    bool isSuccess = false;
    _getNewTaskInProgress = true;
    update();
    //start
    NetworkResponse response =
        await NetworkClient.getRequest(url: ApiUrls.newTaskListUrl);
    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _newTaskList = taskListModel.taskList;
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    //end

    _getNewTaskInProgress = false;
    update();
    return isSuccess;
  }
}
