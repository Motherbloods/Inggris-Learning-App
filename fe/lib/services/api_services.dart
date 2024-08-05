import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/user.dart';
import '../models/lesson.dart';
import '../models/exercise.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl;
  final http.Client _httpClient;

  ApiService({http.Client? httpClient})
      : baseUrl = dotenv.env['URL'] ?? '',
        _httpClient = httpClient ?? http.Client();

  // User API calls
  Future<User?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');

    if (userJson != null) {
      final Map<String, dynamic> userMap = jsonDecode(userJson);
      return User.fromJson(userMap);
    }

    return null;
  }

  Future<User> login(String email, String password) async {
    final response = await _httpClient.post(
      Uri.parse('$baseUrl/api/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        final userMap = jsonDecode(response.body);
        final user = User.fromJson(userMap['user']);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user', jsonEncode(user.toJson()));
        return user;
      } catch (e, stackTrace) {
        print('Error in login function: $e');
        print('Stack trace: $stackTrace');
        rethrow;
      }
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<User> register(String username, String email, String password) async {
    final response = await _httpClient.post(
      Uri.parse('$baseUrl/api/register'),
      headers: {'Content-Type': 'application/json'},
      body: json
          .encode({'username': username, 'email': email, 'password': password}),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final user = jsonDecode(response.body);
      return User.fromJson(user['user']);
    } else {
      throw Exception('Failed to register');
    }
  }

  // Lesson API calls
  Future<List<Lesson>> getLessons() async {
    final response = await _httpClient.get(Uri.parse('$baseUrl/api/lessons'));
    if (response.statusCode == 200) {
      List<dynamic> lessonJson = json.decode(response.body);
      return lessonJson.map((json) => Lesson.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load lessons');
    }
  }

  Future<Lesson> getLessonById(String id) async {
    final response =
        await _httpClient.get(Uri.parse('$baseUrl/api/lessons/$id'));
    if (response.statusCode == 200) {
      return Lesson.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load lesson');
    }
  }

  // Exercise API calls
  Future<List<Exercise>> getExercises({String? lessonId}) async {
    final String url = lessonId != null
        ? '$baseUrl/api/exercises/lessonId=$lessonId'
        : '$baseUrl/api/exercises';
    final response = await _httpClient.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> exerciseJson = json.decode(response.body);
      return exerciseJson.map((json) => Exercise.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load exercises');
    }
  }

  Future<Exercise> getExerciseById(String id) async {
    final response =
        await _httpClient.get(Uri.parse('$baseUrl/api/exercises/$id'));
    if (response.statusCode == 200) {
      return Exercise.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load exercise');
    }
  }

  // Progress API calls
  Future<void> updateProgress(String userId, int progress) async {
    final response = await _httpClient.post(
      Uri.parse('$baseUrl/api/progress'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'userId': userId, 'progress': progress}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update progress');
    }
  }
}
