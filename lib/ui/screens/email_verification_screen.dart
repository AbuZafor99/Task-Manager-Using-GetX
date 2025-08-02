import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/urls.dart';
import 'package:task_manager/ui/controllers/send_recovery_email_controller.dart';
import 'package:task_manager/ui/screens/pin_verification_screen.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snacksbar_message.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  static const String name = '/email_verify_screen';

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailForVerificationController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SendRecoveryEmailController recoveryEmailController=Get.find<SendRecoveryEmailController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 80),
                  Text(
                    "Your Email Address",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'A 6 digit verification pin will send to your \nemail address.',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _emailForVerificationController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(hintText: "Email"),
                    validator: (String? value) {
                      String email = value ?? "";
                      if (EmailValidator.validate(email) == false) {
                        return "Enter a valid Email.";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  GetBuilder<SendRecoveryEmailController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.isLoading==false,
                        replacement: CenteredCircularProgressIndicator(),
                        child: ElevatedButton(
                          onPressed: _emailSubmitOnButtonClick,
                          child: Icon(Icons.arrow_circle_right_outlined),
                        ),
                      );
                    }
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
    Get.offAllNamed(SignInScreen.name);
  }

  void _emailSubmitOnButtonClick() {
    if (_formKey.currentState!.validate()) {
      _sendRecoveryEmail();
    }
  }

  Future<void> _sendRecoveryEmail() async {
    final String email = _emailForVerificationController.text.trim();
    final bool isSuccess= await recoveryEmailController.sendRecoveryEmail(email);

    if (isSuccess) {
      if (mounted) {
        showSnackBarMessage(context, 'Recovery email sent successfully!');
        Get.toNamed(PinVerificationScreen.name, arguments: email);
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
          context,
          recoveryEmailController.errorMessage ?? 'Failed to send recovery email',
        );
      }
    }
  }

  @override
  void dispose() {
    _emailForVerificationController.dispose();
    super.dispose();
  }
}
