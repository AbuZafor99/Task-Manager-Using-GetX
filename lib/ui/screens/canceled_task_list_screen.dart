import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_manager/ui/controllers/canceled_task_list_controller.dart';

import '../../data/models/task_model.dart';
import '../../data/service/network_caller.dart';
import '../../data/urls.dart';
import '../widgets/centered_circular_progress_indicator.dart';
import '../widgets/snacksbar_message.dart';
import '../widgets/task_card.dart';

class CanceledTaskListScreen extends StatefulWidget {
  const CanceledTaskListScreen({super.key});

  @override
  State<CanceledTaskListScreen> createState() => _CanceledTaskListScreenState();
}

class _CanceledTaskListScreenState extends State<CanceledTaskListScreen> {

  @override
  void initState() {
    super.initState();
    Get.find<CancalledTaskListController>().cancelledTaskList;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GetBuilder<CancalledTaskListController>(
        builder: (controller) {
          return Visibility(
            visible: controller.inProgress==false,
            replacement: CenteredCircularProgressIndicator(),
            child: ListView.builder(
              itemCount: controller.cancelledTaskList.length,
              itemBuilder: (context, index) {
                return TaskCard(
                  taskType: TaskType.completed,
                  taskModel: controller.cancelledTaskList[index],
                  onStatusUpdate: () {
                    Get.find<CancalledTaskListController>().cancelledTaskList;
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
