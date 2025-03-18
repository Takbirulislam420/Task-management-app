import 'package:flutter/material.dart';
import 'package:task_management_app/Screenview/Components/task_card_widget.dart';

class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({super.key});

  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        //primary: false,
        // shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          return TaskCardWidget(
            title: "cancel task title",
            description: "cancel task description",
            date: "23/02/2025",
            buttonName: "cancel",
            buttonColors: Colors.redAccent,
          );
        },
        separatorBuilder: (context, index) => SizedBox(
          height: 8,
        ),
      ),
    );
  }
}
