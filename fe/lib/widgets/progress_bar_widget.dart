import 'package:flutter/material.dart';

class ProgressBarWidget extends StatelessWidget {
  final int progress;

  ProgressBarWidget({required this.progress});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Progress',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress / 100,
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          minHeight: 10,
        ),
        SizedBox(height: 4),
        Text(
          '$progress% Complete',
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }
}
