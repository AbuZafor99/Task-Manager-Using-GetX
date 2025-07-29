import 'package:get/get.dart';
import 'package:task_manager/data/models/task_model.dart';

import '../../data/service/network_caller.dart';
import '../../data/urls.dart';

class ProgressTaskListController extends GetxController{
  bool _inProgress=false;
  String? _errorMessage;
  List<TaskModel> _progressTaskList=[];

  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;
  List get progressTaskList =>_progressTaskList;

  Future<bool> getProgressTaskList() async{
    bool isSuccess=false;
    _inProgress=true;
    update();
    NetworkResponse response=await NetworkCaller.getRequest(url: Urls.getProgressTasksUrl);


    if(response.isSuccess){
      isSuccess=true;
      List<TaskModel> list=[];
      for(Map<String,dynamic> jsonData in response.body!['data']){
        list.add(TaskModel.fromJson(jsonData));
      }
      _progressTaskList=list;
    }else{
      _errorMessage=response.errorMessage!;
    }
    _inProgress=false;
    update();

    return isSuccess;
  }
}