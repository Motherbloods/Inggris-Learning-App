import 'package:fe/models/exercise.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fe/controllers/pratice_controller.dart';
import '../widgets/exercise_widget.dart';

class PracticeScreen extends StatelessWidget {
  final List<Exercise> exercises;
  late final PracticeController controller;
  PracticeScreen({required this.exercises}) {
    controller = Get.put(PracticeController(exercises));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Practice'),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      controller.isReviewMode
                          ? 'Review: Question ${controller.currentExerciseIndex.value + 1} of ${controller.wrongExercises.length}'
                          : 'Question ${controller.currentExerciseIndex.value + 1} of ${controller.exercises.length}',
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24),
                    Expanded(
                      child: ExerciseWidget(
                        exercise: controller.currentExercise,
                        onAnswerSelected: controller.checkAnswer,
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Score: ${controller.score.value}',
                      style: Theme.of(context).textTheme.subtitle1,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
