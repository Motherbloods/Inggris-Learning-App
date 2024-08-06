import 'package:fe/models/lesson_progress.dart';

class User {
  String id;
  String email;
  String? avatarUrl; // Allow null
  String username;
  int level;
  int progress;
  List<LessonProgress>? lessons;
  double? xp;

  User(
      {required this.id,
      required this.email,
      this.avatarUrl, // Allow null
      required this.username,
      required this.level,
      required this.progress,
      this.xp,
      this.lessons});

  factory User.fromJson(Map<String, dynamic> json) {
    var lessonsFromJson = json['lessons'] as List;
    List<LessonProgress> lessonList =
        lessonsFromJson.map((i) => LessonProgress.fromJson(i)).toList();
    return User(
      id: json['_id'],
      email: json['email'],
      avatarUrl: json['avatarUrl'], // Allow null
      username: json['username'],
      level: json['level'],
      progress: json['progress'],
      lessons: lessonList,
      xp: json['xp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'avatarUrl': avatarUrl, // Allow null
      'username': username,
      'level': level,
      'progress': progress,
      'lessons': lessons!.map((lesson) => lesson.toJson()).toList(),
    };
  }
}
