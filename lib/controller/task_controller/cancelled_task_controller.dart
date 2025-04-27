import 'package:get/get.dart';
import 'package:task_management_app/data/api_services/network_client.dart';
import 'package:task_management_app/data/api_services/network_response.dart';
import 'package:task_management_app/data/model/task_list_model.dart';
import 'package:task_management_app/data/model/task_model.dart';
import 'package:task_management_app/data/utils/api_urls.dart';

class CancelledTaskController extends GetxController {
  bool _cancelledTaskInProgress = false;
  String? _errorMessage;
  List<TaskModel> _cancelledTaskList = [];

  bool get cancelledTaskInProgress => _cancelledTaskInProgress;
  String? get errorMessage => _errorMessage;
  List<TaskModel> get cancelledTaskList => _cancelledTaskList;

  Future<bool> getcancelledTaskList() async {
    bool isSuccess = false;
    _cancelledTaskInProgress = true;
    update();
    //start
    NetworkResponse response =
        await NetworkClient.getRequest(url: ApiUrls.cancelledTaskListUrl);
    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _cancelledTaskList = taskListModel.taskList;
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    //end
    _cancelledTaskInProgress = false;
    update();
    return isSuccess;
  }
}
