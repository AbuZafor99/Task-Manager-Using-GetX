import 'package:get/get.dart';

import '../../data/service/network_caller.dart';
import '../../data/urls.dart';

class ResetPinVerificationController extends GetxController{
  bool _isLoading=false;
  String? _errorMessage;

  bool get isLoading=> _isLoading;
  String? get errorMessage=> _errorMessage;

  Future<bool> verifyOTP(String email, String otp) async {
    bool isSuccess=false;
    _isLoading = true;
    update();

    // debugPrint('OTP Verification Request:');
    // debugPrint(
    //   'URL: ${Urls.recoverVerifyOTP(_email ?? "", _otpTEController.text)}',
    // );
    // debugPrint('Email: $_email');
    // debugPrint('OTP: ${_otpTEController.text}');

    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.recoverVerifyOTP(email ?? "", otp),
    );

    _isLoading = false;
    update();

    // // Debug: Print the OTP verification response
    // debugPrint('OTP Verification Response:');
    // debugPrint('Status Code: ${response.statusCode}');
    // debugPrint('Is Success: ${response.isSuccess}');
    // debugPrint('Error Message: ${response.errorMessage}');
    // debugPrint('Response Body: ${response.body}');

    if (response.isSuccess) {
      isSuccess=true;
    } else {
      _errorMessage=response.errorMessage;
    }
    return isSuccess;
  }
}