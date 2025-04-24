import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/Screenview/Components/center_circular_progress_indecator.dart';
import 'package:task_management_app/Screenview/Components/show_snackbar.dart';
import 'package:task_management_app/Screenview/Components/task_card_widget.dart';
import 'package:task_management_app/getcontroller/cancelled_task_controller.dart';

class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({super.key});

  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {
  final CancelledTaskController _cancelledTaskController =
      Get.find<CancelledTaskController>();

  @override
  void initState() {
    _getAllDeletedTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CancelledTaskController>(builder: (controller) {
        return controller.cancelledTaskInProgress
            ? CenterCircularProgressIndecator()
            : Visibility(
                visible: controller.cancelledTaskList.isEmpty == false,
                replacement: Center(
                  child: Text("No data"),
                ),
                child: ListView.separated(
                  //primary: false,
                  // shrinkWrap: true,
                  itemCount: controller.cancelledTaskList.length,
                  itemBuilder: (context, index) {
                    return TaskCardWidget(
                      taskStatus: TaskStatus.cancelledPage,
                      taskModel: controller.cancelledTaskList[index],
                      refreshTaskList: () {
                        _getAllDeletedTaskList();
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

  Future<void> _getAllDeletedTaskList() async {
    final bool isSuccess =
        await _cancelledTaskController.getcancelledTaskList();
    if (!isSuccess) {
      showSnackbarMessage(
          // ignore: use_build_context_synchronously
          context,
          _cancelledTaskController.errorMessage!,
          true);
    }
  }
}
