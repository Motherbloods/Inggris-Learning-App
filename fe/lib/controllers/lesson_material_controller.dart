import 'package:fe/models/lesson_progress.dart';
import 'package:fe/models/material_progress.dart';
import 'package:get/get.dart';
import '../models/lesson_material.dart';
import '../services/api_services.dart';
import '../models/user.dart';

class LessonMaterialController extends GetxController {
  final ApiService _apiService = ApiService();
  final materials = <LessonMaterial>[].obs;
  final isLoading = true.obs;
  final String lessonId;
  final Rx<User?> user = Rx<User?>(null);
  final completedMaterials = <String>[].obs;

  LessonMaterialController(this.lessonId);

  @override
  void onInit() {
    super.onInit();
    fetchMaterialsById();
    fetchCurrentUser();
  }

  void fetchMaterialsById() async {
    isLoading.value = true;
    try {
      final fetchedMaterials = await _apiService.getMaterialById(lessonId);
      materials.value = fetchedMaterials;
    } catch (e) {
      print('Error: $e');
      Get.snackbar('Error', 'Failed to load material details');
    } finally {
      isLoading.value = false;
    }
  }

  void fetchCurrentUser() async {
    user.value = await _apiService.getCurrentUser();
    updateCompletedMaterials();
  }

  void updateCompletedMaterials() {
    if (user.value != null && user.value!.lessons != null) {
      print('ini lesson id ${lessonId}');

      var lessonProgress = user.value!.lessons!.firstWhere(
        (lp) {
          print('ini leson ${lp.lessonId}');
          return lp.lessonId == lessonId;
        },
        orElse: () =>
            LessonProgress(lessonId: lessonId, progress: 0.0, materialIds: []),
      );

      print('Material Ids: ${lessonProgress.materialIds}');

      // Explicitly convert materialIds to List<MaterialProgress>
      List<MaterialProgress> materials = lessonProgress.materialIds
              ?.map((e) => e as MaterialProgress)
              .toList() ??
          [];

      completedMaterials.value = materials
          .where((material) => material.completed)
          .map((material) => material.id)
          .toList();

      print('Completed materials: ${completedMaterials.value}');
    }
  }

  // void updateMaterialCompletion(String materialId, bool isCompleted) {
  //   if (isCompleted && !completedMaterials.contains(materialId)) {
  //     print('halo');
  //     completedMaterials.add(materialId);
  //   }
  //   update();
  // }

  void refreshMaterials() {
    fetchCurrentUser();
    fetchMaterialsById();
  }
}
