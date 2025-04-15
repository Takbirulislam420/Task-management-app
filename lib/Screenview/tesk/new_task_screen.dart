import 'package:flutter/material.dart';
import 'package:task_management_app/Screenview/Components/background_component.dart';
import 'package:task_management_app/Screenview/Components/center_circular_progress_indecator.dart';
import 'package:task_management_app/Screenview/Components/show_snackbar.dart';
import 'package:task_management_app/Screenview/Components/summary_card.dart';
import 'package:task_management_app/Screenview/Components/task_card_widget.dart';
import 'package:task_management_app/Screenview/tesk/add_new_task_screen.dart';
import 'package:task_management_app/data/api_services/network_client.dart';
import 'package:task_management_app/data/api_services/network_response.dart';
import 'package:task_management_app/data/model/task_status_count_list_model.dart';
import 'package:task_management_app/data/model/task_status_count_model.dart';
import 'package:task_management_app/data/utils/api_urls.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getStatusCountInProgress = false;
  List<TaskStatusCountModel> _taskStatusCountList = [];

  @override
  void initState() {
    _getAllTaskStatusCount();
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildSummarySection(),
              ListView.separated(
                primary: false,
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return TaskCardWidget(
                    title: "new task title",
                    description: "new task description",
                    date: "20/02/2025",
                    buttonName: "new",
                    taskStatus: TaskStatus.newPage,
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: 8,
                ),
              )
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
        child: _getStatusCountInProgress
            ? CenterCircularProgressIndecator()
            : ListView.builder(
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
}
