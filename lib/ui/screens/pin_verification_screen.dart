import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/ui/screens/change_password_screen.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  static const String name="/pin_verification_page";

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();

}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final TextEditingController _otpTEController= TextEditingController();
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
                    "Your Email Address",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'A 6 digit verification pin has been sent to your \nemail address.',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 20,),
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
                      inactiveColor: Colors.grey
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    controller: _otpTEController,
                    appContext: context,
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(
                      onPressed: _submitOnButtonClick,
                      child: Text("Verify")
                  ),
                  SizedBox(height: 15,),
                  Center(
                    child: RichText(
                      text: TextSpan(
                          text: 'Have account? ',style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          letterSpacing: 0.4
                      ),children: [
                        TextSpan(
                          text: 'Sign in',
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w700
                          ),
                          recognizer: TapGestureRecognizer()..onTap=_navigateToSignInPage,
                        )
                      ]
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToSignInPage(){
    Navigator.pushNamedAndRemoveUntil(context, SignInScreen.name, (predicate) => false);
  }

  void _submitOnButtonClick(){
    Navigator.pushReplacementNamed(context, ChangePasswordScreen.name);
  }
  @override
  void dispose() {
    if (mounted) {
      _otpTEController.dispose();
    }
    super.dispose();
  }

}
