import 'package:flutter/material.dart';
import 'package:task_management_app/Screenview/Components/task_card_widget.dart';

class ComplateTaskScreen extends StatefulWidget {
  const ComplateTaskScreen({super.key});

  @override
  State<ComplateTaskScreen> createState() => _ComplateTaskScreenState();
}

class _ComplateTaskScreenState extends State<ComplateTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        //primary: false,
        // shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          return TaskCardWidget(
            title: "Complate task title",
            description: "Complate task description",
            date: "26/02/2025",
            buttonName: "Complate",
            buttonColors: Colors.green,
          );
        },
        separatorBuilder: (context, index) => SizedBox(
          height: 8,
        ),
      ),
    );
  }
}
