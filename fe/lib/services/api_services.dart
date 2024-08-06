import 'dart:convert';
import 'package:fe/models/lesson.dart';
import 'package:fe/models/lesson_progress.dart';
import 'package:fe/models/material_progress.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/user.dart';
import '../models/lesson_material.dart';
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

  Future<List<LessonMaterial>> getMaterialById(String lessonId) async {
    try {
      print('Fetching materials for lesson ID: $lessonId');
      final response = await _httpClient
          .get(Uri.parse('$baseUrl/api/lessons/material/$lessonId'));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse
            .map((data) => LessonMaterial.fromJson(data))
            .toList();
      } else {
        throw Exception(
            'Failed to load lesson materials: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred: $e');
      throw Exception('An error occurred while fetching lesson materials');
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

  Future<List<Exercise>> getExercisesForMaterial(String materialId) async {
    try {
      final response = await _httpClient.get(
        Uri.parse('$baseUrl/api/exercises?materialId=$materialId'),
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((data) => Exercise.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load exercises: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred: $e');
      throw Exception('An error occurred while fetching exercises');
    }
  }

  Future<void> updateLessonProgress(String lessonId, double progress,
      String materialId, bool isCompleted) async {
    try {
      final user = await getCurrentUser();
      if (user == null) {
        throw Exception('User not logged in');
      }

      final response = await _httpClient.post(
        Uri.parse('$baseUrl/api/users/${user.id}/lesson-progress'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'lessonId': lessonId,
          'progress': progress,
          'materialId': materialId,
          'isCompleted': isCompleted
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update lesson progress');
      }

      final responseData = json.decode(response.body);
      if (responseData['user'] != null) {
        final updatedUser = User.fromJson(responseData['user']);

        // Update local user data
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user', jsonEncode(updatedUser.toJson()));

        // Update the current user in memory
        user.lessons = updatedUser.lessons;
        user.progress = updatedUser.progress;

        print('Lesson progress updated successfully');
      } else {
        throw Exception('Invalid response format');
      }
    } catch (error) {
      print('Error updating lesson progress: $error');
      rethrow;
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
