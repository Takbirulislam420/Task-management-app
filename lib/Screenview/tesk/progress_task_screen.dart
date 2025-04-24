import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/Screenview/Components/background_component.dart';
import 'package:task_management_app/Screenview/Components/center_circular_progress_indecator.dart';
import 'package:task_management_app/Screenview/Components/show_snackbar.dart';
import 'package:task_management_app/Screenview/Components/task_card_widget.dart';
import 'package:task_management_app/getcontroller/progress_controller.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  final ProgressController _progressController = Get.find<ProgressController>();

  @override
  void initState() {
    _getAllProgressTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundComponent(
        child: GetBuilder<ProgressController>(builder: (controller) {
          return Visibility(
            visible: controller.progressTaskInProgress == false,
            replacement: CenterCircularProgressIndecator(),
            child: controller.progressTaskList.isEmpty
                ? Center(
                    child: Text("No Data"),
                  )
                : ListView.separated(
                    //primary: false,
                    // shrinkWrap: true,
                    itemCount: controller.progressTaskList.length,
                    itemBuilder: (context, index) {
                      return TaskCardWidget(
                        taskStatus: TaskStatus.progressPage,
                        taskModel: controller.progressTaskList[index],
                        refreshTaskList: () {
                          _getAllProgressTaskList();
                        },
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: 8,
                    ),
                  ),
          );
        }),
      ),
    );
  }

  Future<void> _getAllProgressTaskList() async {
    final bool isSuccess = await _progressController.getPprogressTaskList();
    if (!isSuccess) {
      showSnackbarMessage(
          // ignore: use_build_context_synchronously
          context,
          _progressController.errorMessage!,
          true);
    }
  }
}
