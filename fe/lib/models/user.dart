class User {
  String id;
  String email;
  String? avatarUrl; // Allow null
  String username;
  int level;
  int progress;

  User({
    required this.id,
    required this.email,
    this.avatarUrl, // Allow null
    required this.username,
    required this.level,
    required this.progress,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      email: json['email'],
      avatarUrl: json['avatarUrl'], // Allow null
      username: json['username'],
      level: json['level'],
      progress: json['progress'],
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
    };
  }
}
