import 'package:fe/screens/pratice_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../widgets/user_profile_widget.dart';
import '../widgets/progress_bar_widget.dart';
import '../widgets/lesson_list_widget.dart';

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Language Master'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings screen
            },
          ),
        ],
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: controller.refreshData,
                child: ListView(
                  padding: EdgeInsets.all(16.0),
                  children: [
                    if (controller.user.value != null)
                      UserProfileWidget(user: controller.user.value!)
                    else
                      Text('User data not available. Please log in.'),
                    SizedBox(height: 16),
                    if (controller.user.value != null)
                      ProgressBarWidget(
                          progress: controller.user.value!.progress)
                    else
                      SizedBox.shrink(),
                    SizedBox(height: 24),
                    Text(
                      'Your Lessons',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 8),
                    if (controller.lessons.isNotEmpty)
                      LessonListWidget(lessons: controller.lessons)
                    else
                      Text('No lessons available.'),
                    SizedBox(height: 24),
                    // ElevatedButton.icon(
                    //   icon: Icon(Icons.play_arrow),
                    //   label: Text('Start Practice'),
                    //   style: ElevatedButton.styleFrom(
                    //     padding:
                    //         EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    //   ),
                    //   onPressed: () {
                    //     Get.to(() => PracticeScreen());
                    //   },
                    // ),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Lessons'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (index) {
          // Handle navigation
        },
      ),
    );
  }
}
