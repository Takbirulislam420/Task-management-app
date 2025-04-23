import 'package:get/get.dart';
import 'package:task_management_app/getcontroller/login_controller.dart';
import 'package:task_management_app/getcontroller/new_task_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(NewTaskController());
  }
}
