import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/Screenview/Components/app_bar_component.dart';
import 'package:task_management_app/controller/task_controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
          ),
          child: NavigationBar(
            height: 70,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: controller.changeTab,
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            animationDuration: Duration(milliseconds: 400),
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home, color: Colors.blue),
                label: "Home",
              ),
              NavigationDestination(
                icon: Icon(Icons.download_sharp),
                selectedIcon: Icon(Icons.download, color: Colors.green),
                label: "Progress",
              ),
              NavigationDestination(
                icon: Icon(Icons.done),
                selectedIcon: Icon(Icons.done_all, color: Colors.purple),
                label: "Completed",
              ),
              NavigationDestination(
                icon: Stack(
                  children: [
                    Icon(Icons.cancel_outlined),
                    Positioned(
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                selectedIcon: Icon(Icons.cancel, color: Colors.red),
                label: "Cancelled",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
