import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';

import '../../data/models/user_model.dart';
import '../../data/service/network_caller.dart';
import '../../data/urls.dart';

class UpdateProfileController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  Future<bool> updateProfile(String email, String fName, String lName,
      String mobile, String pass, String? image) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, String> requestBody = {
      "email": email,
      "firstName": fName,
      "lastName": lName,
      "mobile": mobile,
    };
    if (pass.isNotEmpty) {
      requestBody['password'] = pass;
    }
    if (image != null) {
      requestBody['photo'] = image;
    }

    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.updateProfile,
      body: requestBody,
    );

    _inProgress = false;
    update();
    if (response.isSuccess) {
      UserModel userModel = AuthController.userModel!;
      userModel.email=email;
      userModel.firstName=fName;
      userModel.lastName=lName;
      userModel.mobile=mobile;
      AuthController.saveUserData(userModel, AuthController.accessToken!);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    return isSuccess;
  }
}