import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';

import '../widgets/task_card.dart';
import '../widgets/task_count_summary_card.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            SizedBox(height: 16),
            SizedBox(
              height: 100,
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return TaskCounrtSummaryCard(title: "Progress", count: 12);
                },
                separatorBuilder: (context, index) => const SizedBox(width: 4),
                itemCount: 4,
                scrollDirection: Axis.horizontal,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return TaskCard(
                    taskType: TaskType.tNew,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: _onTapNewTaskButton,child: Icon(Icons.add),),
    );
  }

  void _onTapNewTaskButton(){
    Navigator.pushNamed(context, AddNewTaskScreen.name);
  }
}

