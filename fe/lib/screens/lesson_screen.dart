import 'package:fe/screens/pratice_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/lesson.dart';
import '../controllers/lesson_controller.dart';

class LessonScreen extends StatelessWidget {
  final Lesson lesson;

  LessonScreen({required this.lesson});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LessonController>(
        init: LessonController(lesson),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text(lesson.title),
            ),
            body: Obx(
              () => controller.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Level ${lesson.level}',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          SizedBox(height: 16),
                          Text(
                            lesson.content,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          SizedBox(height: 24),
                          if (lesson.media != null && lesson.media!.isNotEmpty)
                            Column(
                              children: lesson.media!
                                  .map((url) => Image.network(url))
                                  .toList(),
                            ),
                          SizedBox(height: 24),
                          ElevatedButton(
                            child: Text('Start Exercises'),
                            onPressed: () {
                              if (controller.lesson.value?.exercises != null &&
                                  controller
                                      .lesson.value!.exercises!.isNotEmpty) {
                                Get.to(() => PracticeScreen(
                                    exercises:
                                        controller.lesson.value!.exercises!));
                              } else {
                                Get.snackbar('No Exercises',
                                    'This lesson has no exercises yet');
                              }
                            },
                          ),
                        ],
                      ),
                    ),
            ),
          );
        });
  }
}
