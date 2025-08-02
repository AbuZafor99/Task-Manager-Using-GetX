import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/add_new_task_controller.dart';
import 'package:task_manager/ui/controllers/canceled_task_list_controller.dart';
import 'package:task_manager/ui/controllers/complete_task_List_controller.dart';
import 'package:task_manager/ui/controllers/new_task_list_controller.dart';
import 'package:task_manager/ui/controllers/progress_task_list_controller.dart';
import 'package:task_manager/ui/controllers/reset_password_controller.dart';
import 'package:task_manager/ui/controllers/reset_pin_verification_controller.dart';
import 'package:task_manager/ui/controllers/send_recovery_email_controller.dart';
import 'package:task_manager/ui/controllers/sign_in_controller.dart';
import 'package:task_manager/ui/controllers/sign_up_controller.dart';
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
    Get.put(ProgressTaskListController());
    Get.put(ResetPasswordController());
    Get.put(SendRecoveryEmailController());
    Get.put(ResetPinVerificationController());
    Get.put(SignUpController());
  }

}