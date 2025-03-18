import 'package:flutter/material.dart';
import 'package:task_management_app/Screenview/Components/background_widget.dart';
import 'package:task_management_app/Screenview/Components/summary_card.dart';
import 'package:task_management_app/Screenview/Components/task_card_widget.dart';

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
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: BackgroundWidget(
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
                    buttonColors: Colors.blue,
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
