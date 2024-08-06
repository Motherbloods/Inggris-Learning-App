class MaterialProgress {
  String id;
  bool completed;

  MaterialProgress({
    required this.id,
    required this.completed,
  });

  factory MaterialProgress.fromJson(Map<String, dynamic> json) {
    return MaterialProgress(
      id: json['id'] as String,
      completed: json['completed'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'completed': completed,
    };
  }
}
