class Exercise {
  final String id;
  final String lessonId;
  final String type;
  final String question;
  final List<String>? options;
  final String correctAnswer;
  final String? explanation;
  int level;

  Exercise({
    required this.id,
    required this.lessonId,
    required this.type,
    required this.question,
    this.options,
    required this.correctAnswer,
    this.explanation,
    this.level = 1,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['_id'] as String,
      lessonId: json['lessonId'] as String,
      type: json['type'] as String,
      question: json['question'] as String,
      options: (json['options'] as List<dynamic>?)
          ?.map((item) => item as String)
          .toList(),
      correctAnswer: json['correctAnswer'] as String,
      explanation: json['explanation'] as String?,
      level: json['level'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'lessonId': lessonId,
      'type': type,
      'question': question,
      'options': options,
      'correctAnswer': correctAnswer,
      'explanation': explanation,
      'level': level,
    };
  }
}
