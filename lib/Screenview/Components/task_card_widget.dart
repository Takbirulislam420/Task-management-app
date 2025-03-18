import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TaskCardWidget extends StatelessWidget {
  String title;
  String description;
  String date;
  String buttonName;
  Color buttonColors;
  TaskCardWidget({
    required this.title,
    required this.description,
    required this.date,
    required this.buttonName,
    required this.buttonColors,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text(description),
            Text(date),
            Row(
              children: [
                Chip(
                  label: Text(
                    buttonName,
                    style: TextStyle(color: Colors.white),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  backgroundColor: buttonColors,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  side: BorderSide.none,
                ),
                Spacer(),
                IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
