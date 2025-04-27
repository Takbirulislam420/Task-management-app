import 'package:get/get.dart';
import 'package:task_management_app/data/api_services/network_client.dart';
import 'package:task_management_app/data/api_services/network_response.dart';
import 'package:task_management_app/data/model/task_status_count_list_model.dart';
import 'package:task_management_app/data/model/task_status_count_model.dart';
import 'package:task_management_app/data/utils/api_urls.dart';

class TaskStatusCountController extends GetxController {
  bool _taskStatusCountInProgress = false;
  String? _errorMessage;
  List<TaskStatusCountModel> _taskStatusCountList = [];

  bool get taskStatusCountInProgress => _taskStatusCountInProgress;
  String? get errorMessage => _errorMessage;
  List<TaskStatusCountModel> get taskStatusCountList => _taskStatusCountList;

  Future<bool> getTaskStatusCount() async {
    bool isSuccess = false;
    _taskStatusCountInProgress = true;
    update();
    //start
    NetworkResponse response =
        await NetworkClient.getRequest(url: ApiUrls.taskStatusCountUrl);
    if (response.isSuccess) {
      TaskStatusCountListModel taskStatusCountListModel =
          TaskStatusCountListModel.fromJson(response.data ?? {});
      _taskStatusCountList = taskStatusCountListModel.statusCountList;
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    //end

    _taskStatusCountInProgress = false;
    update();
    return isSuccess;
  }
}
