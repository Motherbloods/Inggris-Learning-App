import 'package:get/get.dart';
import '../models/user.dart';
import '../models/lesson.dart';
import '../services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  final ApiService _apiService = ApiService();
  final user = Rx<User?>(null);
  final lessons = <Lesson>[].obs;
  final isLoading = true.obs;

  final currentScreenIndex = 0.obs;

  List<String> screenTitles = ['Language Master', 'Lessons', 'Profile'];

  String get currentScreenTitle => screenTitles[currentScreenIndex.value];

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      user.value = await _apiService.getCurrentUser();

      if (user.value == null) {
        // If there's no logged-in user, navigate to login screen
        Get.offAllNamed('/login');
      } else {
        lessons.value = await _apiService.getLessons();
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshData() async {
    await fetchData();
  }

  void logout() async {
    // Clear user data from shared preferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    // Navigate to login screen
    Get.offAllNamed('/login');
  }

  void changeScreen(int index) {
    currentScreenIndex.value = index;
  }
}
