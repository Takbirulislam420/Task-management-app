import 'package:get/get.dart';
import 'package:task_management_app/controller/onboarding_controller/auth_controller.dart';
import 'package:task_management_app/controller/task_controller/add_new_task_controller.dart';
import 'package:task_management_app/controller/task_controller/cancelled_task_controller.dart';
import 'package:task_management_app/controller/task_controller/complated_task_controller.dart';
import 'package:task_management_app/controller/onboarding_controller/login_controller.dart';
import 'package:task_management_app/controller/task_controller/home_controller.dart';
import 'package:task_management_app/controller/task_controller/new_task_controller.dart';
import 'package:task_management_app/controller/task_controller/progress_controller.dart';
import 'package:task_management_app/controller/task_controller/task_status_count_controller.dart';
import 'package:task_management_app/controller/task_controller/update_and_delete_task_controller.dart';
import 'package:task_management_app/controller/profile_controller/update_profile_controller.dart';

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
    Get.put(AuthController());
    Get.put(HomeController());
  }
}
