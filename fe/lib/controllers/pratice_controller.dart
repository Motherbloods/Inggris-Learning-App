import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../models/exercise.dart';
import '../services/api_services.dart';

class PracticeController extends GetxController {
  final ApiService _apiService = ApiService();
  final exercises = <Exercise>[].obs;
  final currentExerciseIndex = 0.obs;
  final isLoading = true.obs;
  final score = 0.obs;
  final wrongExercises = <Exercise>[].obs;

  PracticeController(List<Exercise> exerciseList) {
    exercises.value = exerciseList;
  }

  Exercise get currentExercise => wrongExercises.isEmpty
      ? exercises[currentExerciseIndex.value]
      : wrongExercises[currentExerciseIndex.value];

  bool get isLastExercise => wrongExercises.isEmpty
      ? currentExerciseIndex.value == exercises.length - 1
      : currentExerciseIndex.value == wrongExercises.length - 1;

  bool get isReviewMode => wrongExercises.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    isLoading.value = false;
  }

  Future<void> fetchExercises() async {
    isLoading.value = true;
    try {
      exercises.value = await _apiService.getExercises();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load exercises');
    } finally {
      isLoading.value = false;
    }
  }

  void checkAnswer(String selectedAnswer) {
    final currentExercise = this.currentExercise;
    bool isCorrect;

    if (currentExercise.type == 'truefalse') {
      isCorrect = selectedAnswer.toLowerCase() ==
          currentExercise.correctAnswer.toLowerCase();
    } else {
      isCorrect = selectedAnswer == currentExercise.correctAnswer;
    }

    if (isCorrect) {
      score.value++;
      Get.snackbar('Correct!', 'Good job!', backgroundColor: Colors.green);
    } else {
      Get.snackbar('Incorrect',
          'The correct answer was: ${currentExercise.correctAnswer}',
          backgroundColor: Colors.red);
      if (!isReviewMode) {
        wrongExercises.add(currentExercise);
      }
    }
    nextExercise();
  }

  void nextExercise() {
    if (isLastExercise) {
      if (wrongExercises.isEmpty) {
        finishPractice();
      } else if (isReviewMode) {
        finishPractice();
      } else {
        startReview();
      }
    } else {
      currentExerciseIndex.value++;
    }
  }

  void startReview() {
    Get.snackbar('Review Time', 'Let\'s review the questions you got wrong');
    currentExerciseIndex.value = 0;
  }

  void finishPractice() {
    final totalExercises = exercises.length;
    final correctAnswers = score.value;
    Get.dialog(
      AlertDialog(
        title: Text('Practice Complete'),
        content: Text('Your score: $correctAnswers/$totalExercises'),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Get.back(); // Close dialog
              Get.back(); // Return to previous screen
            },
          ),
        ],
      ),
    );
  }
}
