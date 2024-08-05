import 'package:get/get.dart';
import '../models/lesson.dart';
import '../services/api_services.dart';

class LessonController extends GetxController {
  final ApiService _apiService = ApiService();
  final lesson = Rx<Lesson?>(null);
  final isLoading = true.obs;

  LessonController(Lesson initialLesson) {
    lesson.value = initialLesson;
  }

  @override
  void onInit() {
    super.onInit();
    fetchLessonDetails();
  }

  Future<void> fetchLessonDetails() async {
    isLoading.value = true;
    try {
      final updatedLesson = await _apiService.getLessonById(lesson.value!.id);
      print('ini update ${updatedLesson.exercises[0].question}');
      lesson.value = updatedLesson;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load lesson details');
    } finally {
      isLoading.value = false;
    }
  }

  void startExercises() {
    if (lesson.value?.exercises != null &&
        lesson.value!.exercises!.isNotEmpty) {
      Get.toNamed('/practice', arguments: lesson.value!.exercises);
    } else {
      Get.snackbar('No Exercises', 'This lesson has no exercises yet');
    }
  }
}
