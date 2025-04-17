import 'package:flutter/material.dart';
import 'package:task_management_app/Screenview/Components/center_circular_progress_indecator.dart';
import 'package:task_management_app/Screenview/Components/show_snackbar.dart';
import 'package:task_management_app/Screenview/Components/task_card_widget.dart';
import 'package:task_management_app/Screenview/style_&_function/style.dart';
import 'package:task_management_app/data/api_services/network_client.dart';
import 'package:task_management_app/data/api_services/network_response.dart';
import 'package:task_management_app/data/model/task_list_model.dart';
import 'package:task_management_app/data/model/task_model.dart';
import 'package:task_management_app/data/utils/api_urls.dart';

class ComplateTaskScreen extends StatefulWidget {
  const ComplateTaskScreen({super.key});

  @override
  State<ComplateTaskScreen> createState() => _ComplateTaskScreenState();
}

class _ComplateTaskScreenState extends State<ComplateTaskScreen> {
  bool _getComplatedTaskListInProgress = false;
  List<TaskModel> _taskList = [];

  @override
  void initState() {
    _getAllComplatedTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: _getComplatedTaskListInProgress == false,
        replacement: CenterCircularProgressIndecator(),
        child: ListView.separated(
          //primary: false,
          // shrinkWrap: true,
          itemCount: _taskList.length,
          itemBuilder: (context, index) {
            return TaskCardWidget(
              title: _taskList[index].title,
              description: _taskList[index].description,
              date: "Date: ${_taskList[index].createDate}",
              buttonName: _taskList[index].status,
              taskStatus: TaskStatus.complatePage,
              onEdit: () {
                SuccessToast('Edit pressed');
                // Navigate to edit screen or perform update
              },
              onDelete: () {
                SuccessToast('Delete pressed');
                // Show confirmation dialog or delete from list
              },
            );
          },
          separatorBuilder: (context, index) => SizedBox(
            height: 8,
          ),
        ),
      ),
    );
  }

  // bool _getComplatedTaskListInProgress = false;
  // List<TaskModel> _taskList = [];
  Future<void> _getAllComplatedTaskList() async {
    _getComplatedTaskListInProgress = true;
    setState(() {});
    NetworkResponse response =
        await NetworkClient.getRequest(url: ApiUrls.complatedTaskListUrl);
    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _taskList = taskListModel.taskList;
    } else {
      // ignore: use_build_context_synchronously
      showSnackbarMessage(context, response.errorMessage, true);
    }
    _getComplatedTaskListInProgress = false;
    setState(() {});
  }
}
