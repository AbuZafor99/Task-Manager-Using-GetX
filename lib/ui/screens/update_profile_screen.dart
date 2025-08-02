import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/controllers/update_profile_controller.dart';
import 'package:task_manager/ui/screens/main_nav_bar_holder_screen.dart';
import 'package:task_manager/ui/screens/new_task_list_screen.dart';
import 'package:task_manager/ui/screens/sign_up_screen.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snacksbar_message.dart';
import 'package:task_manager/ui/widgets/tm_app_bar.dart';

import '../../data/urls.dart';
import '../widgets/screen_background.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  static const String name = "/update_profile";

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _phoneNumberTEController =
      TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImagePicker imagePicker = ImagePicker();
  final UpdateProfileController updateProfileController= Get.find<UpdateProfileController>();
  XFile? _selectedImage;

  @override
  void initState() {
    _emailTEController.text = AuthController.userModel?.email ?? "";
    _firstNameTEController.text = AuthController.userModel?.firstName ?? "";
    _lastNameTEController.text = AuthController.userModel?.lastName ?? "";
    _phoneNumberTEController.text = AuthController.userModel?.mobile ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
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
                  SizedBox(height: 40),

                  SizedBox(height: 8),
                  Text(
                    "Update Profile",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 24),
                  _buildPhotoPicker(),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _emailTEController,
                    textInputAction: TextInputAction.next,
                    enabled: false,
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _firstNameTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: 'First Name'),
                    // autovalidateMode: AutovalidateMode.always,
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter your first name.";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _lastNameTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: 'Last Name'),
                    // autovalidateMode: AutovalidateMode.always,
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter your last name.";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _phoneNumberTEController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(hintText: 'Phone'),
                    // autovalidateMode: AutovalidateMode.always,
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Number is required.";
                      }
                      if (value.trim().length < 11) {
                        return "Enter a valid number (at least 11 digits).";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordTEController,
                    obscureText: true,
                    decoration: InputDecoration(hintText: 'Password'),
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value) {
                      int length = value?.length ?? 0;
                      if (length > 0 && length <= 6) {
                        return "Enter a password more then 6 letters.";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  GetBuilder<UpdateProfileController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.inProgress == false,
                        replacement: CenteredCircularProgressIndicator(),
                        child: ElevatedButton(
                          onPressed: _onTapSignUpButton,
                          child: Icon(Icons.arrow_circle_right_outlined),
                        ),
                      );
                    }
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoPicker() {
    return GestureDetector(
      onTap: _onTapPhotoPicker,
      child: Container(
        height: 50,
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                "Photo",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              _selectedImage == null ? "Select Image" : _selectedImage!.name,
              maxLines: 1,
              style: TextStyle(overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onTapPhotoPicker() async {
    final XFile? pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      _selectedImage = pickedImage;
      setState(() {});
    }
  }

  void _onTapSignUpButton() {
    if (_formKey.currentState!.validate()) {
      _updateProfile();
    }
  }

  Future<void> _updateProfile() async {
    Uint8List? imageBytes;

    String email= _emailTEController.text;
    String fName= _firstNameTEController.text.trim();
    String lName= _lastNameTEController.text.trim();
    String mobile= _phoneNumberTEController.text.trim();
    String pass = _passwordTEController.text;
    imageBytes = await _selectedImage!.readAsBytes();
    String photo = base64Encode(imageBytes);

    final bool isSuccess= await updateProfileController.updateProfile(email, fName, lName, mobile, pass, photo);

    if (isSuccess) {
      _passwordTEController.clear();
      if (mounted) {
        showSnackBarMessage(context, "Profile Updated");
        Get.back();
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context, updateProfileController.errorMessage!);
      }
    }
  }

  void _onTapSignInButton() {
    Get.offNamed(SignUpScreen.name);
  }

  @override
  void dispose() {
    _passwordTEController.dispose();
    _firstNameTEController.dispose();
    _phoneNumberTEController.dispose();
    _lastNameTEController.dispose();
    _emailTEController.dispose();
    super.dispose();
  }
}
