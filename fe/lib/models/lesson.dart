import 'package:fe/models/lesson_material.dart';

class Lesson {
  String id;
  String title;
  DateTime createdAt;
  int level;
  double progress;
  List<String> materialIds;

  Lesson(
      {required this.createdAt,
      required this.id,
      required this.title,
      required this.level,
      required this.progress,
      required this.materialIds});

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json["_id"] as String,
      title: json["title"] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      level: json['level'] as int,
      progress: json['progress'] as double,
      materialIds: List<String>.from(json['material'] ?? []),
    );
  }
}
