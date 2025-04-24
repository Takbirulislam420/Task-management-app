import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/Screenview/Components/center_circular_progress_indecator.dart';
import 'package:task_management_app/Screenview/Components/show_snackbar.dart';
import 'package:task_management_app/Screenview/Components/task_card_widget.dart';
import 'package:task_management_app/getcontroller/complated_task_controller.dart';

class ComplateTaskScreen extends StatefulWidget {
  const ComplateTaskScreen({super.key});

  @override
  State<ComplateTaskScreen> createState() => _ComplateTaskScreenState();
}

class _ComplateTaskScreenState extends State<ComplateTaskScreen> {
  final ComplatedTaskController _complatedTaskController =
      Get.find<ComplatedTaskController>();

  @override
  void initState() {
    _getAllComplatedTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ComplatedTaskController>(builder: (controller) {
        return Visibility(
          visible: controller.complatedTaskInProgress == false,
          replacement: CenterCircularProgressIndecator(),
          child: controller.complatedTaskList.isEmpty
              ? Center(
                  child: Text("No Data"),
                )
              : ListView.separated(
                  //primary: false,
                  // shrinkWrap: true,
                  itemCount: controller.complatedTaskList.length,
                  itemBuilder: (context, index) {
                    return TaskCardWidget(
                      taskStatus: TaskStatus.complatePage,
                      taskModel: controller.complatedTaskList[index],
                      refreshTaskList: () {
                        _getAllComplatedTaskList();
                      },
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    height: 8,
                  ),
                ),
        );
      }),
    );
  }

  // bool _getComplatedTaskListInProgress = false;
  // List<TaskModel> _taskList = [];
  Future<void> _getAllComplatedTaskList() async {
    final bool isSuccess =
        await _complatedTaskController.getPprogressTaskList();
    if (!isSuccess) {
      showSnackbarMessage(
          // ignore: use_build_context_synchronously
          context,
          _complatedTaskController.errorMessage!,
          true);
    }
  }
}
