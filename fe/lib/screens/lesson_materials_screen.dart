import 'package:fe/models/lesson_progress.dart';
import 'package:fe/models/material_progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/lesson_material_controller.dart';
import '../models/lesson.dart';
import 'lesson_material_screen.dart';

class LessonMaterialsScreen extends StatelessWidget {
  final Lesson lesson;

  LessonMaterialsScreen({required this.lesson});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LessonMaterialController(lesson.id));

    return Scaffold(
      appBar: AppBar(
        title: Text(lesson.title),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.materials.isEmpty) {
          return Center(child: Text('No materials available for this lesson.'));
        } else {
          return ListView.builder(
            itemCount: controller.materials.length,
            itemBuilder: (context, index) {
              final material = controller.materials[index];

              return Obx(() {
                bool isCompleted =
                    controller.completedMaterials.contains(material.id);
                print('Material ${material.id} completed: $isCompleted');
                return ListTile(
                  title: Text(material.title),
                  tileColor: isCompleted ? Colors.green[100] : null,
                  onTap: () {
                    if (isCompleted) {
                      Get.dialog(
                        AlertDialog(
                          title: Text('Material Completed'),
                          content: Text(
                              'You have already completed this material. Do you want to review it?'),
                          actions: [
                            TextButton(
                              child: Text('No'),
                              onPressed: () => Get.back(),
                            ),
                            TextButton(
                              child: Text('Yes'),
                              onPressed: () {
                                Get.back();
                                Get.to(() =>
                                    LessonMaterialScreen(material: material));
                              },
                            ),
                          ],
                        ),
                      );
                    } else {
                      Get.to(() => LessonMaterialScreen(material: material));
                    }
                  },
                );
              });
            },
          );
        }
      }),
    );
  }
}
