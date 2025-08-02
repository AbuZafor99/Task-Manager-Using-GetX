import 'package:get/get.dart';

import '../../data/service/network_caller.dart';
import '../../data/urls.dart';

class SendRecoveryEmailController extends GetxController{
  bool _isLoading=false;
  String? _errorMessage;

  bool get isLoading=>_isLoading;
  String? get errorMessage=>_errorMessage;

  Future<bool> sendRecoveryEmail(String email) async {
    bool isSuccess=false;
    _isLoading = true;
    update();

    // final String email = _emailForVerificationController.text.trim();

    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.recoverVerifyEmail(email),
    );

    _isLoading = false;
    update();

    if (response.isSuccess) {
      isSuccess=true;
    } else {
      _errorMessage=response.errorMessage;
    }
    return isSuccess;
  }
}