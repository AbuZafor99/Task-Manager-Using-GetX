import 'package:get/get.dart';

import '../../data/service/network_caller.dart';
import '../../data/urls.dart';

class ResetPasswordController extends GetxController{
  bool _isLoading=false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> resetPassword(String email, String otp, String pass) async {
    bool isSucccessful=false;
    _isLoading = true;
    update();

    final Map<String, String> requestBody = {
      "email": email,
      "OTP": otp,
      "password": pass,
    };

    NetworkResponse response = await NetworkCaller.postRequestWithoutAuth(
      url: Urls.recoverResetPasswordUrl,
      body: requestBody,
    );

    _isLoading = false;
    update();

    if (response.isSuccess) {
        isSucccessful=true;
    } else {
      _errorMessage=response.errorMessage?? "Reset Password Failed";
    }
    return isSucccessful;
  }
}