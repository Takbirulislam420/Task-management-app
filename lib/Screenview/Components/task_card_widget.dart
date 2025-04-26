import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_management_app/Screenview/Components/center_circular_progress_indecator.dart';
import 'package:task_management_app/Screenview/Components/show_snackbar.dart';
import 'package:task_management_app/data/model/task_model.dart';
import 'package:task_management_app/getcontroller/update_and_delete_task_controller.dart';

enum TaskStatus { newPage, progressPage, complatePage, cancelledPage }

class TaskCardWidget extends StatelessWidget {
  final TaskStatus taskStatus;
  final TaskModel taskModel;
  final VoidCallback refreshTaskList;

  TaskCardWidget({
    required this.taskModel,
    required this.taskStatus,
    required this.refreshTaskList,
    super.key,
  });

  final UpdateAndDeleteTaskController _updateTaskController =
      Get.find<UpdateAndDeleteTaskController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool isLoading =
          _updateTaskController.getTaskLoadingState(taskModel.id).value;

      return Card(
        elevation: 0,
        color: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                taskModel.title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(taskModel.description),
              const SizedBox(height: 4),
              Text(_dateFormator()),
              const SizedBox(height: 8),
              Row(
                children: [
                  Chip(
                    label: Text(
                      taskModel.status,
                      style: const TextStyle(color: Colors.white),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    backgroundColor: _getChipButtonColor(),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    side: BorderSide.none,
                  ),
                  const Spacer(),
                  isLoading
                      ? const CenterCircularProgressIndecator()
                      : Row(
                          children: [
                            IconButton(
                              onPressed: _showUpdateStatusDialog,
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: _deleteTask,
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  Color _getChipButtonColor() {
    switch (taskStatus) {
      case TaskStatus.newPage:
        return Colors.green;
      case TaskStatus.progressPage:
        return Colors.amber;
      case TaskStatus.complatePage:
        return Colors.blueAccent;
      case TaskStatus.cancelledPage:
        return Colors.red;
    }
  }

  void _showUpdateStatusDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text("Update Status"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildStatusTile("New"),
            Divider(),
            _buildStatusTile("Progress"),
            Divider(),
            _buildStatusTile("Complated"),
            Divider(),
            _buildStatusTile("Cancelled"),
          ],
        ),
      ),
    );
  }

  ListTile _buildStatusTile(String status) {
    return ListTile(
      onTap: () {
        Get.back();
        if (isSelected(status)) return;
        _changeTaskStatus(status);
      },
      title: Text(status),
      trailing: isSelected(status) ? const Icon(Icons.done) : null,
    );
  }

  bool isSelected(String status) => taskModel.status == status;

  Future<void> _changeTaskStatus(String status) async {
    final bool isSuccess = await _updateTaskController.getUpdateTaskStatus(
      taskModel.id,
      status,
    );

    if (isSuccess) {
      refreshTaskList();
    } else {
      showSnackbarMessage(
          Get.context!, "Something wrong for update status", true);
    }
  }

  Future<void> _deleteTask() async {
    final bool isSuccess =
        await _updateTaskController.getDeleteTaskStatus(taskModel.id);

    if (isSuccess) {
      refreshTaskList();
    } else {
      showSnackbarMessage(Get.context!, "Delete unsuccesfull", true);
    }
  }

  String _dateFormator() {
    DateTime parsedDate = DateTime.parse(taskModel.createDate).toLocal();
    String formattedDate = DateFormat('dd MMMM yyyy').format(parsedDate);
    String formattedTime = DateFormat('hh:mma').format(parsedDate);
    return "$formattedDate $formattedTime";
  }
}
