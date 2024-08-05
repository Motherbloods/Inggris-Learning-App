import '../models/exercise.dart';

class Lesson {
  String id;
  String title;
  String content;
  List<dynamic>? media;
  List<Exercise> exercises;
  DateTime createdAt;
  int level;

  Lesson({
    required this.id,
    required this.title,
    required this.content,
    this.media,
    required this.exercises,
    required this.createdAt,
    this.level = 1,
  });
  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
        id: json['_id'] as String,
        title: json['title'] as String,
        content: json['content'] as String,
        media: (json['media'] as List<dynamic>?)
            ?.map((item) => item as String)
            .toList(),
        exercises: (json['exercises'] as List<dynamic>?)
                ?.map((item) => Exercise.fromJson(item as Map<String, dynamic>))
                .toList() ??
            [],
        createdAt: DateTime.parse(json['createdAt'] as String),
        level: json['level'] as int);
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'content': content,
      'media': media,
      'exercises': exercises,
      'createdAt': createdAt.toIso8601String(),
      'level': level
    };
  }
}
