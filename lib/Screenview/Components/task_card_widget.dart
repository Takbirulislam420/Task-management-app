import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_management_app/Screenview/Components/center_circular_progress_indecator.dart';
import 'package:task_management_app/Screenview/Components/show_snackbar.dart';
import 'package:task_management_app/data/model/task_model.dart';
import 'package:task_management_app/getcontroller/update_and_delete_task_controller.dart';

enum TaskStatus { newPage, progressPage, complatePage, cancelledPage }

// ignore: must_be_immutable
class TaskCardWidget extends StatefulWidget {
  TaskStatus taskStatus;
  TaskModel taskModel;
  final VoidCallback refreshTaskList;

  TaskCardWidget({
    required this.taskModel,
    required this.taskStatus,
    required this.refreshTaskList,
    super.key,
  });

  @override
  State<TaskCardWidget> createState() => _TaskCardWidgetState();
}

class _TaskCardWidgetState extends State<TaskCardWidget> {
  final UpdateAndDeleteTaskController _updateTaskController =
      Get.find<UpdateAndDeleteTaskController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskModel.title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text(widget.taskModel.description),
            Text(_dateFormator()),
            Row(
              children: [
                Chip(
                  label: Text(
                    widget.taskModel.status,
                    style: TextStyle(color: Colors.white),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  backgroundColor: _getChipButtonColor(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  side: BorderSide.none,
                ),
                Spacer(),
                GetBuilder<UpdateAndDeleteTaskController>(
                    builder: (controller) {
                  return Visibility(
                    visible: controller.updateAndDeleteTaskInProgress == false,
                    replacement: CenterCircularProgressIndecator(),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: _showUpdateStatusDialog,
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: _deleteTask,
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  );
                })
              ],
            )
          ],
        ),
      ),
    );
  }

  Color _getChipButtonColor() {
    late Color color;

    switch (widget.taskStatus) {
      case TaskStatus.newPage:
        color = Colors.green;
      case TaskStatus.progressPage:
        color = Colors.amber;
      case TaskStatus.complatePage:
        color = Colors.blueAccent;
      case TaskStatus.cancelledPage:
        color = Colors.red;
    }
    return color;

    // Different way
    // if (taskStatus == TaskStatus.newPage) {
    //   return Colors.blue;
    // }else if(taskStatus == TaskStatus.progressPage){
    //       return Colors.black;
    // }
    // else if(taskStatus == TaskStatus.progressPage){
    //       return Colors.amber;
    // }else if(taskStatus == TaskStatus.progressPage){
    //       return Colors.green;
    // }else{
    //   return Colors.white;
    // }
  }

  void _showUpdateStatusDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Update status"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    _popDialog();
                    if (isSelected("New")) return;
                    _changeTaskStatus("New");
                  },
                  title: Text("New"),
                  trailing: isSelected("New") ? Icon(Icons.done) : null,
                ),
                ListTile(
                  onTap: () {
                    _popDialog();
                    if (isSelected("Progress")) return;
                    _changeTaskStatus("Progress");
                  },
                  title: Text("Progress"),
                  trailing: isSelected("Progress") ? Icon(Icons.done) : null,
                ),
                ListTile(
                  onTap: () {
                    _popDialog();
                    if (isSelected("Complated")) return;
                    _changeTaskStatus("Complated");
                  },
                  title: Text("Complated"),
                  trailing: isSelected("Complated") ? Icon(Icons.done) : null,
                ),
                ListTile(
                  onTap: () {
                    _popDialog();
                    if (isSelected("Cancelled")) return;
                    _changeTaskStatus("Cancelled");
                  },
                  title: Text("Cancelled"),
                  trailing: isSelected("Cancelled") ? Icon(Icons.done) : null,
                ),
              ],
            ),
          );
        });
  }

  bool isSelected(String status) => widget.taskModel.status == status;

  Future<void> _changeTaskStatus(String status) async {
    final bool isSuccess = await _updateTaskController.getUpdateTaskStatus(
        widget.taskModel.id, status);
    if (isSuccess) {
      widget.refreshTaskList();
    } else {
      showSnackbarMessage(
          // ignore: use_build_context_synchronously
          context,
          _updateTaskController.errorMessage!,
          true);
    }
  }

  Future<void> _deleteTask() async {
    final bool isSuccess =
        await _updateTaskController.getDeleteTaskStatus(widget.taskModel.id);
    if (isSuccess) {
      widget.refreshTaskList();
    } else {
      showSnackbarMessage(
          // ignore: use_build_context_synchronously
          context,
          _updateTaskController.errorMessage!,
          true);
    }
  }

  void _popDialog() {
    Navigator.pop(context);
  }

  _dateFormator() {
    var dateNtime = widget.taskModel.createDate;
    DateTime parsedDate = DateTime.parse(dateNtime).toLocal();
    String formattedDate = DateFormat('dd MMMM yyyy').format(parsedDate);
    String formattedTime = DateFormat('hh:mma').format(parsedDate);
    return "$formattedDate $formattedTime";
  }
}
