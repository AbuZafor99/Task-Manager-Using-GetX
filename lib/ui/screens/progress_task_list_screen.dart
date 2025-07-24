import 'package:flutter/cupertino.dart';

import '../../data/models/task_model.dart';
import '../../data/service/network_caller.dart';
import '../../data/urls.dart';
import '../widgets/centered_circular_progress_indicator.dart';
import '../widgets/snacksbar_message.dart';
import '../widgets/task_card.dart';

class ProgressTaskListScreen extends StatefulWidget {
  const ProgressTaskListScreen({super.key});

  @override
  State<ProgressTaskListScreen> createState() => _ProgressTaskListScreenState();
}

class _ProgressTaskListScreenState extends State<ProgressTaskListScreen> {

  bool _getProgressTaskInProgress=false;
  List<TaskModel> _progressTaskList=[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _getProgressTaskList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Visibility(
        visible: _getProgressTaskInProgress==false,
        replacement: CenteredCircularProgressIndicator(),
        child: ListView.builder(
          itemCount: _progressTaskList.length,
          itemBuilder: (context, index) {
            return TaskCard(
                taskType: TaskType.progress,
              taskModel: _progressTaskList[index],
            );
          },
        ),
      ),
    );
  }
  Future<void> _getProgressTaskList() async{
    _getProgressTaskInProgress=true;
    setState(() {});
    NetworkResponse response=await NetworkCaller.getRequest(url: Urls.getProgressTasksUrl);


    if(response.isSuccess){
      List<TaskModel> list=[];
      for(Map<String,dynamic> jsonData in response.body!['data']){
        list.add(TaskModel.fromJson(jsonData));
      }
      _progressTaskList=list;
    }else{
      showSnackBarMessage(context, response.errorMessage!);
    }
    _getProgressTaskInProgress=false;
    setState(() {});
  }

}
