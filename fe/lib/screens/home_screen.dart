import 'package:fe/models/lesson_progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../widgets/user_profile_widget.dart';
import '../widgets/progress_bar_widget.dart';
import '../widgets/lesson_list_widget.dart';
import 'lesson_materials_screen.dart';

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
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.lessons.length,
                        itemBuilder: (context, index) {
                          final lesson = controller.lessons[index];
                          var lessonProgress =
                              controller.user.value!.lessons!.firstWhere(
                            (lp) {
                              print('ini lessonId ${lp.lessonId}');
                              return lp.lessonId == lesson.id;
                            },
                            orElse: () => LessonProgress(
                                lessonId: lesson.id,
                                progress: 0.0,
                                materialIds: []),
                          );

                          print('ini progress ${lessonProgress.progress}');
                          return Card(
                            margin: EdgeInsets.only(bottom: 12),
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text(lesson.level.toString()),
                                backgroundColor: _getLevelColor(lesson.level),
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(lesson.title),
                                  SizedBox(height: 4),
                                  LinearProgressIndicator(
                                    value: lessonProgress.progress / 100,
                                    backgroundColor: Colors.grey[200],
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        _getLevelColor(lesson.level)),
                                  ),
                                ],
                              ),
                              trailing: Icon(Icons.chevron_right),
                              onTap: () {
                                Get.to(() =>
                                    LessonMaterialsScreen(lesson: lesson));
                              },
                            ),
                          );
                        },
                      )
                    else
                      Text('No lessons available.'),
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

  Color _getLevelColor(int level) {
    if (level <= 3) return Colors.green;
    if (level <= 6) return Colors.orange;
    return Colors.red;
  }
}
