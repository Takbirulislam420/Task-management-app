import 'package:flutter/material.dart';
import 'package:task_management_app/Screenview/Components/background_component.dart';
import 'package:task_management_app/Screenview/Components/summary_card.dart';
import 'package:task_management_app/Screenview/Components/task_card_widget.dart';
import 'package:task_management_app/Screenview/tesk/add_new_task_screen.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            SummaryCard(
              title: "new",
              count: "12",
            ),
            SummaryCard(
              title: "Progress",
              count: "15",
            ),
            SummaryCard(
              title: "Complated",
              count: "20",
            ),
            SummaryCard(
              title: "Deleted",
              count: "05",
            ),
          ],
        ),
      ),
    );
  }
}
