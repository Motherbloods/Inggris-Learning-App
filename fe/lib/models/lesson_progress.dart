import 'package:fe/models/material_progress.dart';

class LessonProgress {
  String lessonId;
  List<MaterialProgress>? materialIds;
  double progress;

  LessonProgress({
    required this.lessonId,
    this.materialIds, // Updated to List<String> and optional
    required this.progress,
  });

  factory LessonProgress.fromJson(Map<String, dynamic> json) {
    var materialsJson = json['materialIds'] as List? ?? [];
    List<MaterialProgress> materials =
        materialsJson.map((m) => MaterialProgress.fromJson(m)).toList();

    return LessonProgress(
      lessonId: json["lessonId"] as String,
      materialIds: materials,
      progress: json['progress'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lessonId': lessonId,
      'materialIds': materialIds?.map((m) => m.toJson()).toList(),
      'progress': progress,
    };
  }
}
