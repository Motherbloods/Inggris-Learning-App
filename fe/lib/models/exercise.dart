class Exercise {
  final String id;
  final String materialId;
  final String type;
  final String question;
  final List<String>? options;
  final String correctAnswer;
  final String? explanation;
  int level;

  Exercise({
    required this.id,
    required this.materialId,
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
      materialId: json['materialId'] as String,
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
      'materialId': materialId,
      'type': type,
      'question': question,
      'options': options,
      'correctAnswer': correctAnswer,
      'explanation': explanation,
      'level': level,
    };
  }
}
