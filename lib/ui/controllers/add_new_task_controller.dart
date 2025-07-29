import 'package:get/get.dart';
import 'package:task_manager/data/models/task_model.dart';
import '../../data/service/network_caller.dart' show NetworkResponse, NetworkCaller;
import '../../data/urls.dart';
import '../widgets/snacksbar_message.dart';

class AddNewTaskController extends GetxController{
  bool _inProgress=false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> addNewTask(String title, String description) async {
    bool isSuccess=false;
    _inProgress = true;
    update();

    Map<String, String> requestBody = {
      "title": title,
      "description": description,
      "status": "New",
    };

    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.createNewTaskUrl,
      body: requestBody,
    );

    _inProgress = false;
    update();

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage=response.errorMessage ?? 'Add new task failed';
    }
    return isSuccess;
  }
}