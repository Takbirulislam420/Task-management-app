import 'package:flutter/material.dart';
import 'package:task_management_app/Screenview/profile/update_profile_screen.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  const AppBarComponent({
    super.key,
    this.fromProfileUpdate,
  });
  final bool? fromProfileUpdate;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: () {
          if (fromProfileUpdate ?? false) {
            return;
          }
          _onTapProfileUpdateScreen(context);
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Takbirul islam",
                    style: textTheme.bodyLarge?.copyWith(color: Colors.white),
                  ),
                  Text(
                    "Takbirulislam420@gmail.com",
                    style: textTheme.bodySmall?.copyWith(color: Colors.white),
                  )
                ],
              ),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.logout))
          ],
        ),
      ),
    );
  }

  void _onTapProfileUpdateScreen(BuildContext context) {
    //  Navigator.pushAndRemoveUntil(context,
    //   MaterialPageRoute(builder: (context) => UpdateProfileScreen()), (pre) => false);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UpdateProfileScreen()),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
