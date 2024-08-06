import 'package:fe/controllers/pratice_controller.dart';
import 'package:fe/screens/pratice_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/lesson_material.dart';

class LessonMaterialScreen extends StatelessWidget {
  final LessonMaterial material;

  LessonMaterialScreen({required this.material});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(material.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Level ${material.level}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(height: 16),
            Text(
              material.content,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(height: 24),
            if (material.media != null && material.media!.isNotEmpty)
              ...material.media!.map((mediaUrl) => Image.network(mediaUrl)),
            SizedBox(height: 24),
            ElevatedButton(
              child: Text('Start Exercises'),
              onPressed: () {
                final practiceController =
                    Get.put(PracticeController(material.id, material.lessonId));
                practiceController.fetchExercises();
                Get.to(() => PracticeScreen(
                      materialId: material.id,
                      lessonId: material.lessonId,
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
