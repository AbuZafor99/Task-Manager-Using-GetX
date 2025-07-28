import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller_binder.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/screens/change_password_screen.dart';
import 'package:task_manager/ui/screens/email_verification_screen.dart';
import 'package:task_manager/ui/screens/main_nav_bar_holder_screen.dart';
import 'package:task_manager/ui/screens/pin_verification_screen.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/screens/sign_up_screen.dart';
import 'package:task_manager/ui/screens/splash_screen.dart';
import 'package:task_manager/ui/screens/update_profile_screen.dart';

class TaskManager extends StatelessWidget {
  const TaskManager({super.key});
  static  GlobalKey<NavigatorState> navigator=GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigator,
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        textTheme: TextTheme(
          titleLarge:TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
          )
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
          hintStyle: TextStyle(
              color: Colors.grey
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                fixedSize: Size.fromWidth(double.maxFinite),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                ),
                padding: EdgeInsets.symmetric(vertical: 12),
                backgroundColor: Colors.green,
                foregroundColor: Colors.white
            )
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.green
          )
        )
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        SplashScreen.name:(context)=>SplashScreen(),
        SignInScreen.name:(context)=>SignInScreen(),
        EmailVerificationScreen.name:(context)=>EmailVerificationScreen(),
        SignUpScreen.name:(context)=>SignUpScreen(),
        PinVerificationScreen.name:(context)=>PinVerificationScreen(),
        ChangePasswordScreen.name:(context)=>ChangePasswordScreen(),
        MainNavBarHolderScreen.name:(context)=>MainNavBarHolderScreen(),
        AddNewTaskScreen.name:(context)=>AddNewTaskScreen(),
        UpdateProfileScreen.name:(context)=>UpdateProfileScreen()
      },
      initialBinding: ControllerBinder(),
    );
  }
}
