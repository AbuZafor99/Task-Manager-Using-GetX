import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskCounrtSummaryCard extends StatelessWidget {
  const TaskCounrtSummaryCard({
    super.key,
    required this.title,
    required this.count,
  });

  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$count", style: Theme.of(context).textTheme.titleLarge),
            Text(title,maxLines: 1,),
          ],
        ),
      ),
    )
    );
  }
}