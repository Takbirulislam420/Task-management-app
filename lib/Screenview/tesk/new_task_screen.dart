import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_management_app/Screenview/Components/background_component.dart';
import 'package:task_management_app/Screenview/Components/center_circular_progress_indecator.dart';
import 'package:task_management_app/Screenview/Components/show_snackbar.dart';
import 'package:task_management_app/Screenview/Components/summary_card.dart';
import 'package:task_management_app/Screenview/Components/task_card_widget.dart';
import 'package:task_management_app/Screenview/style_&_function/my_custom_function.dart';
import 'package:task_management_app/Screenview/style_&_function/style.dart';
import 'package:task_management_app/Screenview/tesk/add_new_task_screen.dart';
import 'package:task_management_app/controller/task_controller/new_task_controller.dart';
import 'package:task_management_app/controller/task_controller/task_status_count_controller.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  var formatter = DateFormat('dd-MM-yyyy');

  final NewTaskController _newTaskController = Get.find<NewTaskController>();
  final TaskStatusCountController _taskStatusCountController =
      Get.find<TaskStatusCountController>();
  @override
  void initState() {
    _getAllTaskStatusCount();
    _getAllTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: _onPressFloatingButton,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: BackgroundComponent(
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildSummarySection(),
              GetBuilder<NewTaskController>(builder: (controller) {
                return Visibility(
                  visible: controller.getNewTaskInProgress == false,
                  replacement: SizedBox(
                      height: 300, child: CenterCircularProgressIndecator()),
                  child: controller.newTaskList.isEmpty
                      ? Center(
                          child: Text("No Data"),
                        )
                      : ListView.separated(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: controller.newTaskList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onLongPress: () {
                                customAlertFunction(
                                  context: context,
                                  title: "Confirm Delete",
                                  message:
                                      "Are you sure you want to delete this task???",
                                  onOk: () {
                                    SuccessToast("User confirmed delete");
                                    // Proceed with deletion logic
                                  },
                                  onCancel: () {
                                    SuccessToast(
                                        "User cancelled delete${controller.newTaskList[index]}");
                                    // Maybe show a message or do nothing
                                  },
                                );
                              },
                              child: TaskCardWidget(
                                taskStatus: TaskStatus.newPage,
                                taskModel: controller.newTaskList[index],
                                refreshTaskList: () {
                                  _getAllTaskStatusCount();
                                  _getAllTaskList();
                                },
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            height: 8,
                          ),
                        ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  void _onPressFloatingButton() {
    Get.to(AddNewTaskScreen());
  }

  Widget buildSummarySection() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        height: 100,
        child: GetBuilder<TaskStatusCountController>(builder: (controller) {
          if (controller.taskStatusCountInProgress) {
            return Center(child: CircularProgressIndicator());
          }

          if (controller.taskStatusCountList.isEmpty) {
            return Center(child: Text("No Summary Data Found"));
          }
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.taskStatusCountList.length,
              itemBuilder: (context, index) {
                return SummaryCard(
                    title: controller.taskStatusCountList[index].status,
                    count: controller.taskStatusCountList[index].count);
              });
        }),
      ),
    );
  }

  Future<void> _getAllTaskStatusCount() async {
    final bool isSuccess =
        await _taskStatusCountController.getTaskStatusCount();
    if (!isSuccess) {
      showSnackbarMessage(
          // ignore: use_build_context_synchronously
          context,
          _taskStatusCountController.errorMessage!,
          true);
    }
  }

  Future<void> _getAllTaskList() async {
    final bool isSuccess = await _newTaskController.getNewTaskList();
    if (!isSuccess) {
      // ignore: use_build_context_synchronously
      showSnackbarMessage(context, _newTaskController.errorMessage!, true);
    }
  }
}
