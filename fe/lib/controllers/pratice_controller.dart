import 'package:fe/controllers/home_controller.dart';
import 'package:fe/controllers/lesson_material_controller.dart';
import 'package:fe/models/lesson_progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/exercise.dart';
import '../services/api_services.dart';

class PracticeController extends GetxController {
  final ApiService _apiService = ApiService();
  final exercises = <Exercise>[].obs;
  final currentExerciseIndex = 0.obs;
  final isLoading = true.obs;
  final score = 0.obs;
  final wrongExercises = <Exercise>[].obs;
  final isReviewMode = false.obs;
  final String materialId;
  final String lessonId;
  final isCompleted = false.obs;

  PracticeController(this.materialId, this.lessonId);

  @override
  void onInit() {
    super.onInit();
    fetchExercises();
    checkCompletionStatus();
  }

  Exercise get currentExercise => isReviewMode.value
      ? wrongExercises[currentExerciseIndex.value]
      : exercises[currentExerciseIndex.value];

  bool get isLastExercise => isReviewMode.value
      ? currentExerciseIndex.value == wrongExercises.length - 1
      : currentExerciseIndex.value == exercises.length - 1;

  void fetchExercises() async {
    isLoading.value = true;
    try {
      exercises.value = await _apiService.getExercisesForMaterial(materialId);
    } catch (e) {
      print('Error fetching exercises: $e');
      Get.snackbar('Error', 'Failed to load exercises');
    } finally {
      isLoading.value = false;
    }
  }

  void checkAnswer(String selectedAnswer) {
    final currentExercise = this.currentExercise;
    bool isCorrect = selectedAnswer.toLowerCase() ==
        currentExercise.correctAnswer.toLowerCase();

    if (isCorrect) {
      score.value++;
    } else {
      if (!isReviewMode.value) {
        wrongExercises.add(currentExercise);
      }
    }

    nextExercise();
  }

  void nextExercise() {
    if (isLastExercise) {
      if (!isReviewMode.value && wrongExercises.isNotEmpty) {
        startReviewMode();
      } else {
        print('ini selesai');
        finishPractice();
      }
    } else {
      currentExerciseIndex.value++;
    }
  }

  void startReviewMode() {
    isReviewMode.value = true;
    currentExerciseIndex.value = 0;
  }

  void checkCompletionStatus() async {
    final user = await _apiService.getCurrentUser();
    if (user != null && user.lessons != null) {
      final lessonProgress = user.lessons!.firstWhere(
        (lp) => lp.lessonId == lessonId,
        orElse: () => LessonProgress(lessonId: lessonId, progress: 0.0),
      );
      isCompleted.value =
          lessonProgress.materialIds?.contains(materialId) ?? false;
    }
  }

  void finishPractice() async {
    bool allCorrect = score.value == exercises.length;

    await _apiService.updateLessonProgress(
        lessonId, score.value.toDouble(), materialId, allCorrect);

    final homeController = Get.find<HomeController>();
    homeController.updateUserProgress();

    final lessonMaterialController = Get.find<LessonMaterialController>();
    lessonMaterialController.refreshMaterials();
    Get.dialog(
      AlertDialog(
        title: Text(allCorrect ? 'Practice Complete' : 'Practice Finished'),
        content: Text('Your final score: ${score.value}/${exercises.length}'),
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
