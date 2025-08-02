import 'package:get/get.dart';

import '../../data/service/network_caller.dart';
import '../../data/urls.dart';

class UpdateProfileController extends GetxController{
  bool _InProgress=false;
  String? _errorMessage;

  bool get inProgress=>_InProgress;
  String? get errorMessage=>_errorMessage;

  Future<bool> updateProfile(String email, String fName,String lName, String mobile,String pass,String? image) async {
    bool isSuccess=false;
    _InProgress = true;
    update();


    Map<String, String> requestBody = {
      "email": email,
      "firstName":fName,
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

    _InProgress = false;
    update();
    if (response.isSuccess) {
      isSuccess=true;
    }else{
      _errorMessage=response.errorMessage;
    }
    return isSuccess;
  }
}