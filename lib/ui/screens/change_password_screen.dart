import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import '../widgets/screen_background.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  static const String name='/change_password_screen';

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController = TextEditingController();

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
                    "Set New Password",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Password should be more than 6 digit.',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: _passwordTEController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "Email",
                    ),
                    validator: (String? value){
                      if((value?.length??0)<=6){
                        return "Your password length must be 7 digit";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: _confirmPasswordTEController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "Confirm Email",
                    ),
                    validator: (String? value){
                      if((value?? '')!=_passwordTEController.text){
                        return "Confirm password doesn't match.";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(
                      onPressed: _confirmPasswordOnClick,
                      child: Text("Confirm")
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
    Navigator.pushReplacementNamed(context, SignInScreen.name);
  }
  void _confirmPasswordOnClick(){
    Navigator.pushReplacementNamed(context, SignInScreen.name);
  }
  @override
  void dispose() {
    _passwordTEController.dispose();
    _confirmPasswordTEController.dispose();
    super.dispose();
  }
}