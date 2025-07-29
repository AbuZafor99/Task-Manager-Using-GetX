import 'package:get/get.dart';

import '../../data/models/task_status_count_model.dart';
import '../../data/service/network_caller.dart';
import '../../data/urls.dart';

class TaskStatusCountController extends GetxController{
  bool _InProgress=false;
  String? _errorMessage;
  List<TaskStatusCountModel> _taskStatusCountList = [];

  bool get inProgress =>_InProgress;
  String? get errorMessage => _errorMessage;
  List<TaskStatusCountModel> get taskStatusList => _taskStatusCountList;

  Future<bool> getTaskStatusCountList() async {
    bool isSuccess=false;
    _InProgress = true;
    update();

    NetworkResponse response = await NetworkCaller
        .getRequest(url: Urls.taskStatusCountUrls);

    if (response.isSuccess) {
      List<TaskStatusCountModel> list = [];
      for (Map<String, dynamic> jsonData in response.body!['data']) {
        list.add(TaskStatusCountModel.fromJson(jsonData));
      }
      _taskStatusCountList = list;
      _errorMessage=null;
    } else {
      _errorMessage=response.errorMessage!;
    }

    _InProgress = false;
    update();

    return isSuccess;
  }
}