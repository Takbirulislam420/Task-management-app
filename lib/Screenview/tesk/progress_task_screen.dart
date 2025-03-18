import 'package:flutter/material.dart';
import 'package:task_management_app/Screenview/Components/task_card_widget.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        //primary: false,
        // shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          return TaskCardWidget(
            title: "Progress task title",
            description: "Progress task description",
            date: "25/02/2025",
            buttonName: "Progress",
            buttonColors: Colors.amber,
          );
        },
        separatorBuilder: (context, index) => SizedBox(
          height: 8,
        ),
      ),
    );
  }
}
