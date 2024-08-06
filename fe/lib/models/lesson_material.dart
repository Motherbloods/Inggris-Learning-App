import 'package:fe/models/exercise.dart';

class LessonMaterial {
  final String id;
  final String lessonId;
  final String title;
  final String content;
  final List<String>? media;
  final List<String>? exerciseIds;
  final DateTime createdAt;
  final int level;

  LessonMaterial({
    required this.id,
    required this.lessonId,
    required this.title,
    required this.content,
    this.media,
    this.exerciseIds,
    required this.createdAt,
    required this.level,
  });

  factory LessonMaterial.fromJson(Map<String, dynamic> json) {
    return LessonMaterial(
      id: json['_id'] as String? ?? '',
      lessonId: json['lessonId'] as String? ?? '',
      title: json['title'] as String? ?? '',
      content: json['content'] as String? ?? '',
      media: (json['media'] as List<dynamic>?)?.cast<String>(),
      exerciseIds: (json['exercises'] as List<dynamic>?)?.cast<String>(),
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ??
          DateTime.now(),
      level: json['level'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'content': content,
      'media': media,
      'exerciseIds': exerciseIds,
      'createdAt': createdAt.toIso8601String(),
      'level': level
    };
  }
}
