import 'package:flutter/cupertino.dart';

import '../widgets/task_card.dart';

class CanceledTaskListScreen extends StatefulWidget {
  const CanceledTaskListScreen({super.key});

  @override
  State<CanceledTaskListScreen> createState() => _CanceledTaskListScreenState();
}

class _CanceledTaskListScreenState extends State<CanceledTaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return TaskCard();
        },
      ),
    );;
  }
}
