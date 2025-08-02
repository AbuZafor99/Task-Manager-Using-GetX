import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/urls.dart';
import 'package:task_manager/ui/controllers/reset_password_controller.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import '../widgets/screen_background.dart';
import '../widgets/snacksbar_message.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  static const String name = '/change_password_screen';

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ResetPasswordController _resetPasswordController=Get.find<ResetPasswordController>();
  String? _email;
  String? _otp;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map<String, dynamic>) {
      _email = args['email'] as String?;
      _otp = args['otp'] as String?;
    } else {
      _email = args as String?;
    }
  }

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
                    "Set New Password",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Password should be more than 6 digit.',
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
                  TextFormField(
                    controller: _passwordTEController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.next,
                    obscureText: true,
                    decoration: InputDecoration(hintText: "Password"),
                    validator: (String? value) {
                      if ((value?.length ?? 0) <= 6) {
                        return "Your password length must be 7 digit";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _confirmPasswordTEController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    decoration: InputDecoration(hintText: "Confirm Password"),
                    validator: (String? value) {
                      if ((value ?? '') != _passwordTEController.text) {
                        return "Confirm password doesn't match.";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  GetBuilder<ResetPasswordController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.isLoading==false,
                        replacement: CenteredCircularProgressIndicator(),
                        child: ElevatedButton(
                          onPressed: _onConfirmPassword,
                          child: Text("Confirm"),
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

  void _onConfirmPassword() async {
    if (_formKey.currentState!.validate()) {
      if (_email == null || _email!.isEmpty) {
        showSnackBarMessage(context, 'Email is required for password reset');
        return;
      }
      if (_otp == null || _otp!.isEmpty) {
        showSnackBarMessage(context, 'OTP is required for password reset');
        return;
      }
      final bool isSuccess = await _resetPasswordController.resetPassword(
          _email!, _otp!, _passwordTEController.text);

      if (isSuccess) {
        if (mounted) {
          showSnackBarMessage(context, "Password has been reset");
          _navigateToSignInPage();
        }
      } else {
        if (mounted) {
          showSnackBarMessage(
              context, _resetPasswordController.errorMessage ?? 'Failed to reset password');
        }
      }
    }
  }


  @override
  void dispose() {
    _passwordTEController.dispose();
    _confirmPasswordTEController.dispose();
    super.dispose();
  }
}
