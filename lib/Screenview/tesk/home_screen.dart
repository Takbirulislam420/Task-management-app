import 'package:flutter/material.dart';
import 'package:task_management_app/Screenview/Components/app_bar_component.dart';
import 'package:task_management_app/Screenview/tesk/cancel_task_screen.dart';
import 'package:task_management_app/Screenview/tesk/complate_task_screen.dart';
import 'package:task_management_app/Screenview/tesk/new_task_screen.dart';
import 'package:task_management_app/Screenview/tesk/progress_task_screen.dart';

// ignore: camel_case_types
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screen = [
    NewTaskScreen(),
    ProgressTaskScreen(),
    ComplateTaskScreen(),
    CancelTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(),
      //drawer: ProfileDetailsDrower(),
      body: _screen[_selectedIndex],
      bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) {
            _selectedIndex = index;
            setState(() {});
          },
          destinations: [
            NavigationDestination(icon: Icon(Icons.home), label: "Home"),
            NavigationDestination(
                icon: Icon(Icons.download_sharp), label: "Progress"),
            NavigationDestination(icon: Icon(Icons.done), label: "Complated"),
            NavigationDestination(icon: Icon(Icons.cancel), label: "Cancelled"),
          ]),
    );
  }
}
