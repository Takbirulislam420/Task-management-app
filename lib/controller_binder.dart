import 'package:get/get.dart';
import 'package:task_management_app/getcontroller/add_new_task_controller.dart';
import 'package:task_management_app/getcontroller/cancelled_task_controller.dart';
import 'package:task_management_app/getcontroller/complated_task_controller.dart';
import 'package:task_management_app/getcontroller/login_controller.dart';
import 'package:task_management_app/getcontroller/new_task_controller.dart';
import 'package:task_management_app/getcontroller/progress_controller.dart';
import 'package:task_management_app/getcontroller/task_status_count_controller.dart';
import 'package:task_management_app/getcontroller/update_and_delete_task_controller.dart';
import 'package:task_management_app/getcontroller/update_profile_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(NewTaskController());
    Get.put(AddNewTaskController());
    Get.put(TaskStatusCountController());
    Get.put(ProgressController());
    Get.put(ComplatedTaskController());
    Get.put(CancelledTaskController());
    Get.put(UpdateAndDeleteTaskController());
    Get.put(UpdateProfileController());
  }
}
