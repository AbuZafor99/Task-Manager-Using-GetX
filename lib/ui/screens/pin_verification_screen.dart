import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/urls.dart';
import 'package:task_manager/ui/screens/change_password_screen.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snacksbar_message.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  static const String name = "/pin_verification_page";

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final TextEditingController _otpTEController = TextEditingController();
  bool _isLoading = false;
  String? _email;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _email = ModalRoute.of(context)?.settings.arguments as String?;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 80),
                  Text(
                    "OTP Verification",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'A 6 digit verification pin has been sent to your \nemail address.',
                    style: TextStyle(color: Colors.grey),
                  ),
                  if (_email != null) ...[
                    SizedBox(height: 8),
                    Text(
                      'Email: $_email',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                  SizedBox(height: 20),
                  PinCodeTextField(
                    length: 6,
                    keyboardType: TextInputType.number,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      selectedColor: Colors.green,
                      inactiveColor: Colors.grey,
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    controller: _otpTEController,
                    appContext: context,
                  ),
                  SizedBox(height: 20),
                  Visibility(
                    visible: !_isLoading,
                    replacement: CenteredCircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: _submitOnButtonClick,
                      child: Text("Verify"),
                    ),
                  ),
                  SizedBox(height: 15),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: 'Have account? ',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          letterSpacing: 0.4,
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign in',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w700,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = _navigateToSignInPage,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToSignInPage() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      SignInScreen.name,
      (predicate) => false,
    );
  }

  void _submitOnButtonClick() {
    if (_otpTEController.text.length == 6) {
      _verifyOTP();
    } else {
      showSnackBarMessage(context, 'Please enter 6 digit OTP');
    }
  }

  Future<void> _verifyOTP() async {
    _isLoading = true;
    setState(() {});

    // Debug: Print the OTP verification details
    debugPrint('OTP Verification Request:');
    debugPrint(
      'URL: ${Urls.recoverVerifyOTP(_email ?? "", _otpTEController.text)}',
    );
    debugPrint('Email: $_email');
    debugPrint('OTP: ${_otpTEController.text}');

    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.recoverVerifyOTP(_email ?? "", _otpTEController.text),
    );

    _isLoading = false;
    setState(() {});

    // Debug: Print the OTP verification response
    debugPrint('OTP Verification Response:');
    debugPrint('Status Code: ${response.statusCode}');
    debugPrint('Is Success: ${response.isSuccess}');
    debugPrint('Error Message: ${response.errorMessage}');
    debugPrint('Response Body: ${response.body}');

    if (response.isSuccess) {
      if (mounted) {
        showSnackBarMessage(context, 'OTP verified successfully!');
        Navigator.pushReplacementNamed(
          context,
          ChangePasswordScreen.name,
          arguments: {'email': _email, 'otp': _otpTEController.text},
        );
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
          context,
          response.errorMessage ?? 'Failed to verify OTP',
        );
      }
    }
  }

  @override
  void dispose() {
    if (mounted) {
      _otpTEController.dispose();
    }
    super.dispose();
  }
}
