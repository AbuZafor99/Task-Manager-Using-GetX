import 'package:get/get.dart';

import '../../data/service/network_caller.dart';
import '../../data/urls.dart';

class SignUpController extends GetxController{
  bool _InProgress=false;
  String? _errorMessage;

  bool get InProgress => _InProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> signUp(String email, String firstName, String lastName, String phone, String pass) async {
    bool isSuccess=false;
    _InProgress = true;
    update();

    Map<String, String> requestBody={
      "email":email,
      "firstName":firstName,
      "lastName":lastName,
      "mobile":phone,
      "password":pass
    };

    NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.registrationUrl,
        body: requestBody
    );

    _InProgress = false;
    update();

    if(response.isSuccess){
      isSuccess=true;
    }else{
      _errorMessage= response.errorMessage;
    }
    return isSuccess;
  }
}