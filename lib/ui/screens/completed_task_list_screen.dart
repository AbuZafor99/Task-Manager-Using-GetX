import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_manager/ui/controllers/complete_task_List_controller.dart';

import '../../data/models/task_model.dart';
import '../../data/service/network_caller.dart';
import '../../data/urls.dart';
import '../widgets/centered_circular_progress_indicator.dart';
import '../widgets/snacksbar_message.dart';
import '../widgets/task_card.dart';

class CompletedTaskListScreen extends StatefulWidget {
  const CompletedTaskListScreen({super.key});

  @override
  State<CompletedTaskListScreen> createState() => _CompletedTaskListScreenState();
}
class _CompletedTaskListScreenState extends State<CompletedTaskListScreen> {

  @override
  void initState() {
    super.initState();
    Get.find<CompleteTaskListController>().getCompleteTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GetBuilder<CompleteTaskListController>(
        builder: (controller) {
          return Visibility(
            visible: controller.inProgress==false,
            replacement: CenteredCircularProgressIndicator(),
            child: ListView.builder(
              itemCount: controller.completeTaskList.length,
              itemBuilder: (context, index) {
                return TaskCard(
                  taskType: TaskType.completed,
                  taskModel: controller.completeTaskList[index],
                  onStatusUpdate: () {
                    Get.find<CompleteTaskListController>().getCompleteTaskList();
                  },
                );
              },
            ),
          );
        }
      ),
    );
  }

}
