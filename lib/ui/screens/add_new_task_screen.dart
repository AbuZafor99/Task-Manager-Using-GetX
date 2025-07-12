import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/tm_app_bar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  static const String name='/add_new_task';

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {

  final TextEditingController _titleTEController=TextEditingController();
  final TextEditingController _descriptionTEController=TextEditingController();
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: ScreenBackground(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              autovalidateMode:AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height:40),
                  Text("Add New Task",style: Theme.of(context).textTheme.titleLarge,),
                  const SizedBox(height: 16,),
                  TextFormField(
                    controller: _titleTEController,
                    validator: (String? value){
                      if(value?.trim().isEmpty?? true){
                        return "Enter your Title";
                      }return null;
                    },
                    decoration: InputDecoration(
                      hintText:'Title'
                    ),
                  ),
                  const SizedBox(height: 16,),
                  TextFormField(
                    controller: _descriptionTEController,
                    maxLines: 5,
                    validator: (String? value){
                      if(value?.trim().isEmpty?? true){
                        return "Enter your Description";
                      }return null;
                    },
                    decoration: InputDecoration(
                      hintText:'Description'
                  ),
                  ),
                  const SizedBox(height: 16,),
                  ElevatedButton(onPressed: _onTapSubmitButton, child: Icon(Icons.arrow_circle_right_outlined))
                ],
              ),
            ),
          )
      ),
    );
  }
  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }

  void _onTapSubmitButton(){
    if(_formKey.currentState!.validate()){
      //TODO: Add New Task
    }
    Navigator.pop(context);
  }
}
