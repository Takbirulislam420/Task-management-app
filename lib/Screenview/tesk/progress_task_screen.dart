import 'package:flutter/material.dart';
import 'package:task_management_app/Screenview/Components/background_component.dart';
import 'package:task_management_app/Screenview/Components/center_circular_progress_indecator.dart';
import 'package:task_management_app/Screenview/Components/show_snackbar.dart';
import 'package:task_management_app/Screenview/Components/task_card_widget.dart';
import 'package:task_management_app/data/api_services/network_client.dart';
import 'package:task_management_app/data/api_services/network_response.dart';
import 'package:task_management_app/data/model/task_list_model.dart';
import 'package:task_management_app/data/model/task_model.dart';
import 'package:task_management_app/data/utils/api_urls.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool _getProgressTaskListInProgress = false;
  List<TaskModel> _taskList = [];

  @override
  void initState() {
    _getAllProgressTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundComponent(
        child: Visibility(
          visible: _getProgressTaskListInProgress == false,
          replacement: CenterCircularProgressIndecator(),
          child: _taskList.isEmpty
              ? Center(
                  child: Text("No Data"),
                )
              : ListView.separated(
                  //primary: false,
                  // shrinkWrap: true,
                  itemCount: _taskList.length,
                  itemBuilder: (context, index) {
                    return TaskCardWidget(
                      taskStatus: TaskStatus.progressPage,
                      taskModel: _taskList[index],
                      refreshTaskList: () {
                        _getAllProgressTaskList();
                      },
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    height: 8,
                  ),
                ),
        ),
      ),
    );
  }

  // bool _getProgressTaskListInProgress = false;
  // List<TaskModel> _taskList = [];
  Future<void> _getAllProgressTaskList() async {
    _getProgressTaskListInProgress = true;
    setState(() {});
    NetworkResponse response =
        await NetworkClient.getRequest(url: ApiUrls.progressTaskListUrl);
    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _taskList = taskListModel.taskList;
    } else {
      // ignore: use_build_context_synchronously
      showSnackbarMessage(context, response.errorMessage, true);
    }
    _getProgressTaskListInProgress = false;
    setState(() {});
  }
}
