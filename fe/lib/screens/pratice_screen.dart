import 'package:fe/controllers/pratice_controller.dart';
import 'package:fe/widgets/exercise_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PracticeScreen extends StatelessWidget {
  final String materialId;
  final String lessonId;

  PracticeScreen({required this.materialId, required this.lessonId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PracticeController(materialId, lessonId));

    return Scaffold(
      appBar: AppBar(
        title: Text('Practice'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Score: ${controller.score.value}/${controller.exercises.length}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ExerciseWidget(
                exercise: controller.currentExercise,
                onAnswerSelected: controller.checkAnswer,
              ),
            ),
          ],
        );
      }),
    );
  }
}
