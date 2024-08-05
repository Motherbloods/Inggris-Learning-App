import 'package:fe/screens/lesson_screen.dart';
import 'package:flutter/material.dart';
import '../models/lesson.dart';

class LessonListWidget extends StatelessWidget {
  final List<Lesson> lessons;

  LessonListWidget({required this.lessons});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: lessons.length,
      itemBuilder: (context, index) {
        final lesson = lessons[index];
        return Card(
          margin: EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              child: Text(lesson.level.toString()),
              backgroundColor: _getLevelColor(lesson.level),
            ),
            title: Text(lesson.title),
            subtitle: Text('${lesson.exercises!.length} exercises'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LessonScreen(lesson: lesson),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Color _getLevelColor(int level) {
    if (level <= 3) return Colors.green;
    if (level <= 6) return Colors.orange;
    return Colors.red;
  }
}
