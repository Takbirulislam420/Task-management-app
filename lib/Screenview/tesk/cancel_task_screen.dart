import 'package:flutter/material.dart';
import 'package:task_management_app/Screenview/Components/center_circular_progress_indecator.dart';
import 'package:task_management_app/Screenview/Components/show_snackbar.dart';
import 'package:task_management_app/Screenview/Components/task_card_widget.dart';
import 'package:task_management_app/data/api_services/network_client.dart';
import 'package:task_management_app/data/api_services/network_response.dart';
import 'package:task_management_app/data/model/task_list_model.dart';
import 'package:task_management_app/data/model/task_model.dart';
import 'package:task_management_app/data/utils/api_urls.dart';

class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({super.key});

  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {
  bool _getDeletedTaskListInProgress = false;
  List<TaskModel> _taskList = [];

  @override
  void initState() {
    _getAllDeletedTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getDeletedTaskListInProgress
          ? CenterCircularProgressIndecator()
          : Visibility(
              visible: _taskList.isEmpty == false,
              replacement: Center(
                child: Text("No data"),
              ),
              child: ListView.separated(
                //primary: false,
                // shrinkWrap: true,
                itemCount: _taskList.length,
                itemBuilder: (context, index) {
                  return TaskCardWidget(
                    taskStatus: TaskStatus.cancelledPage,
                    taskModel: _taskList[index],
                    refreshTaskList: () {
                      _getAllDeletedTaskList();
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

  Future<void> _getAllDeletedTaskList() async {
    _getDeletedTaskListInProgress = true;
    setState(() {});
    NetworkResponse response =
        await NetworkClient.getRequest(url: ApiUrls.cancelledTaskListUrl);
    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _taskList = taskListModel.taskList;
    } else {
      // ignore: use_build_context_synchronously
      showSnackbarMessage(context, response.errorMessage, true);
    }
    _getDeletedTaskListInProgress = false;
    setState(() {});
  }
}
