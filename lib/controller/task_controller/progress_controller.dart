import 'package:get/get.dart';
import 'package:task_management_app/data/api_services/network_client.dart';
import 'package:task_management_app/data/api_services/network_response.dart';
import 'package:task_management_app/data/model/task_list_model.dart';
import 'package:task_management_app/data/model/task_model.dart';
import 'package:task_management_app/data/utils/api_urls.dart';

class ProgressController extends GetxController {
  bool _progressTaskInProgress = false;
  String? _errorMessage;
  List<TaskModel> _progressTaskList = [];

  bool get progressTaskInProgress => _progressTaskInProgress;
  String? get errorMessage => _errorMessage;
  List<TaskModel> get progressTaskList => _progressTaskList;

  Future<bool> getPprogressTaskList() async {
    bool isSuccess = false;
    _progressTaskInProgress = true;
    update();
    //start
    NetworkResponse response =
        await NetworkClient.getRequest(url: ApiUrls.progressTaskListUrl);
    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _progressTaskList = taskListModel.taskList;
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    //end
    _progressTaskInProgress = false;
    update();
    return isSuccess;
  }
}
