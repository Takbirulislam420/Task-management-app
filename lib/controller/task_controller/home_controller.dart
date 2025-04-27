import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/Screenview/tesk/cancel_task_screen.dart';
import 'package:task_management_app/Screenview/tesk/complate_task_screen.dart';
import 'package:task_management_app/Screenview/tesk/new_task_screen.dart';
import 'package:task_management_app/Screenview/tesk/progress_task_screen.dart';

// Controller
class HomeController extends GetxController {
  var selectedIndex = 0.obs;

  final List<Widget> screens = [
    NewTaskScreen(),
    ProgressTaskScreen(),
    ComplateTaskScreen(),
    CancelTaskScreen(),
  ];

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
