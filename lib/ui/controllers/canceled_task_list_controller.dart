import 'package:get/get.dart';
import 'package:task_manager/data/models/task_model.dart';

import '../../data/service/network_caller.dart';
import '../../data/urls.dart';

class CancalledTaskListController extends GetxController{

  bool _InProgress=false;
  String? _errorMessage;
  List<TaskModel> _cancalledTaskList=[];

  bool get inProgress =>_InProgress;
  String? get errorMessage =>_errorMessage;
  List get cancelledTaskList =>_cancalledTaskList;



  Future<bool> getCompleteTaskList() async{
    bool inSuccess=false;
    _InProgress=true;
    update();
    NetworkResponse response=await NetworkCaller.getRequest(url: Urls.getCancelledTasksUrl);


    if(response.isSuccess){
      List<TaskModel> list=[];
      for(Map<String,dynamic> jsonData in response.body!['data']){
        list.add(TaskModel.fromJson(jsonData));
      }
      _cancalledTaskList=list;
    }else{
      _errorMessage=response.errorMessage!;
    }
    _InProgress=false;
    update();

    return inSuccess;
  }
}