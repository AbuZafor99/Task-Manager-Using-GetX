import 'package:flutter/cupertino.dart';

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
  bool _getCompleteTaskInProgress=false;
  List<TaskModel> _completeTaskList=[];

  @override
  void initState() {
    super.initState();
    _getCompleteTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Visibility(
        visible: _getCompleteTaskInProgress==false,
        replacement: CenteredCircularProgressIndicator(),
        child: ListView.builder(
          itemCount: _completeTaskList.length,
          itemBuilder: (context, index) {
            return TaskCard(
              taskType: TaskType.completed,
              taskModel: _completeTaskList[index],
              onStatusUpdate: () {
                _getCompleteTaskList();
              },
            );
          },
        ),
      ),
    );
  }
  Future<void> _getCompleteTaskList() async{
    _getCompleteTaskInProgress=true;
    setState(() {});
    NetworkResponse response=await NetworkCaller.getRequest(url: Urls.getCompletedTasksUrl);


    if(response.isSuccess){
      List<TaskModel> list=[];
      for(Map<String,dynamic> jsonData in response.body!['data']){
        list.add(TaskModel.fromJson(jsonData));
      }
      _completeTaskList=list;
    }else{
      showSnackBarMessage(context, response.errorMessage!);
    }
    _getCompleteTaskInProgress=false;
    setState(() {});
  }
}
