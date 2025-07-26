import 'package:flutter/cupertino.dart';

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
  bool _getCanceledTaskInProgress=false;
  List<TaskModel> _canceledTaskList=[];

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
        visible: _getCanceledTaskInProgress==false,
        replacement: CenteredCircularProgressIndicator(),
        child: ListView.builder(
          itemCount: _canceledTaskList.length,
          itemBuilder: (context, index) {
            return TaskCard(
              taskType: TaskType.completed,
              taskModel: _canceledTaskList[index],
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
    _getCanceledTaskInProgress=true;
    setState(() {});
    NetworkResponse response=await NetworkCaller.getRequest(url: Urls.getCancelledTasksUrl);


    if(response.isSuccess){
      List<TaskModel> list=[];
      for(Map<String,dynamic> jsonData in response.body!['data']){
        list.add(TaskModel.fromJson(jsonData));
      }
      _canceledTaskList=list;
    }else{
      showSnackBarMessage(context, response.errorMessage!);
    }
    _getCanceledTaskInProgress=false;
    setState(() {});
  }
}
