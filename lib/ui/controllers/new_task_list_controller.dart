import 'package:get/get.dart';
import '../../data/models/task_model.dart';
import '../../data/service/network_caller.dart';
import '../../data/urls.dart';

class NewTaskListController extends GetxController{
  bool _InProgress=false;
  String? _errorMessage;

  List<TaskModel> _newTaskList=[];

  bool get inProgress=>_InProgress;
  String? get errorMessage=>_errorMessage;
  List<TaskModel>get newTaskList=>_newTaskList;

  Future<bool> getNewTaskList() async {
    bool isSuccess=false;
    _InProgress = true;
    update();

    NetworkResponse response = await NetworkCaller
        .getRequest(url: Urls.getNewTasksUrl);

    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.body!['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _newTaskList = list;
      _errorMessage=null;
    } else {
      _errorMessage=response.errorMessage!;
    }

    _InProgress = false;
    update();

    return isSuccess;
  }


}