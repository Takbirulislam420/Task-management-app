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
import 'package:task_management_app/data/api_services/network_client.dart';
import 'package:task_management_app/data/api_services/network_response.dart';
import 'package:task_management_app/data/model/task_status_count_list_model.dart';
import 'package:task_management_app/data/model/task_status_count_model.dart';
import 'package:task_management_app/data/utils/api_urls.dart';
import 'package:task_management_app/getcontroller/new_task_controller.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getStatusCountInProgress = false;
  List<TaskStatusCountModel> _taskStatusCountList = [];
  var formatter = DateFormat('dd-MM-yyyy');

  final NewTaskController _newTaskController = Get.find<NewTaskController>();

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
        child: Icon(Icons.add),
      ),
      body: BackgroundComponent(
        child: _getStatusCountInProgress
            ? CenterCircularProgressIndecator()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    buildSummarySection(),
                    GetBuilder<NewTaskController>(builder: (controller) {
                      return Visibility(
                        visible: controller.getNewTaskInProgress == false,
                        replacement: SizedBox(
                            height: 300,
                            child: CenterCircularProgressIndecator()),
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
                                            "Are you sure you want to delete this task?",
                                        onOk: () {
                                          SuccessToast("User confirmed delete");
                                          // Proceed with deletion logic
                                        },
                                        onCancel: () {
                                          SuccessToast("User cancelled delete");
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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddNewTaskScreen()),
    );
  }

  Widget buildSummarySection() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        height: 100,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _taskStatusCountList.length,
            itemBuilder: (context, index) {
              return SummaryCard(
                  title: _taskStatusCountList[index].status,
                  count: _taskStatusCountList[index].count);
            }),
      ),
    );
  }

  Future<void> _getAllTaskStatusCount() async {
    _getStatusCountInProgress = true;
    setState(() {});
    NetworkResponse response =
        await NetworkClient.getRequest(url: ApiUrls.taskStatusCountUrl);
    if (response.isSuccess) {
      TaskStatusCountListModel taskStatusCountListModel =
          TaskStatusCountListModel.fromJson(response.data ?? {});
      _taskStatusCountList = taskStatusCountListModel.statusCountList;
    } else {
      // ignore: use_build_context_synchronously
      showSnackbarMessage(context, response.errorMessage, true);
    }
    _getStatusCountInProgress = false;
    setState(() {});
  }

  Future<void> _getAllTaskList() async {
    final bool isSuccess = await _newTaskController.getNewTaskList();
    if (!isSuccess) {
      // ignore: use_build_context_synchronously
      showSnackbarMessage(context, _newTaskController.errorMessage!, true);
    }
  }
}
