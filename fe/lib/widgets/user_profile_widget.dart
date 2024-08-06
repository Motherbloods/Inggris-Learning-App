import 'package:flutter/material.dart';
import '../models/user.dart';

class UserProfileWidget extends StatelessWidget {
  final User? user;

  UserProfileWidget({required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: user?.avatarUrl != null
                  ? NetworkImage(user!.avatarUrl!)
                  : NetworkImage(
                      'http://pluspng.com/img-png/user-png-icon-big-image-png-2240.png'),
              child: user?.avatarUrl == null
                  ? Text(
                      user?.username?.isNotEmpty == true
                          ? user!.username![0]
                          : '?',
                      style: TextStyle(fontSize: 24))
                  : null,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.username ?? 'Guest',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Level ${user?.level ?? 1}',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  LinearProgressIndicator(
                    value: (user?.xp ?? 0) /
                        100, // Assuming xp is between 0 and 100
                    backgroundColor: Colors.grey[300],
                    color: Colors.blue,
                    minHeight: 8,
                  ),
                  SizedBox(height: 4),
                  Text(
                    'XP: ${user?.xp ?? 0} / 100',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
