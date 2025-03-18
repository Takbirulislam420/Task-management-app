import 'package:flutter/material.dart';
import 'package:task_management_app/const/app_colors.dart';

// ignore: non_constant_identifier_names
AppBar TaskAppBar(context, ProfileData) {
  return AppBar(
    backgroundColor: AppColors.colorGreen,
    flexibleSpace: Container(
      margin: EdgeInsets.fromLTRB(10, 40, 10, 0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 24,
            child: ClipOval(child: Text("P")),
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text("first"), Text("Second")],
          )
        ],
      ),
    ),
    actions: [
      IconButton(onPressed: () {}, icon: Icon(Icons.add_circle_outline)),
      IconButton(onPressed: () {}, icon: Icon(Icons.output))
    ],
  );
}
