import 'package:get/get.dart';
import 'package:task_manager/data/models/task_model.dart';

import '../../data/service/network_caller.dart';
import '../../data/urls.dart';

class CanceledTaskListController extends GetxController{

  bool _inProgress=false;
  String? _errorMessage;
  List<TaskModel> _cancelledTaskList=[];

  bool get inProgress =>_inProgress;
  String? get errorMessage =>_errorMessage;
  List<TaskModel> get cancelledTaskList =>_cancelledTaskList;



  Future<bool> getCancelledTaskList() async{
    bool isSuccess=false;
    _inProgress=true;
    update();
    NetworkResponse response=await NetworkCaller.getRequest(url: Urls.getCancelledTasksUrl);


    if(response.isSuccess){
      isSuccess = true;
      List<TaskModel> list=[];
      for(Map<String,dynamic> jsonData in response.body!['data']){
        list.add(TaskModel.fromJson(jsonData));
      }
      _cancelledTaskList=list;
    }else{
      _errorMessage=response.errorMessage;
    }
    _inProgress=false;
    update();

    return isSuccess;
  }
}
