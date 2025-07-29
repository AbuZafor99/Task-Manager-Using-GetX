import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/add_new_task_controller.dart';
import 'package:task_manager/ui/controllers/canceled_task_list_controller.dart';
import 'package:task_manager/ui/controllers/complete_task_List_controller.dart';
import 'package:task_manager/ui/controllers/new_task_list_controller.dart';
import 'package:task_manager/ui/controllers/sign_in_controller.dart';
import 'package:task_manager/ui/controllers/task_status_count_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(SignInController());
    Get.put(NewTaskListController());
    Get.put(TaskStatusCountController());
    Get.put(CompleteTaskListController());
    Get.put(CompleteTaskListController());
    Get.put(AddNewTaskController());
    Get.put(CanceledTaskListController());
  }

}