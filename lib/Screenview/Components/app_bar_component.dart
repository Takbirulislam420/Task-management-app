import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_management_app/Screenview/controller/auth_controller.dart';
import 'package:task_management_app/Screenview/onboarding.dart/login_screen.dart';
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
              backgroundImage: _shouldShowImage(AuthController.userModel?.photo)
                  ? MemoryImage(
                      base64Decode(AuthController.userModel?.photo ?? ""))
                  : null,
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AuthController.userModel?.fullName ?? "Unknown",
                    style: textTheme.bodyLarge?.copyWith(color: Colors.white),
                  ),
                  Text(
                    AuthController.userModel?.email ?? "UnknownEmail",
                    style: textTheme.bodySmall?.copyWith(color: Colors.white),
                  )
                ],
              ),
            ),
            IconButton(
                onPressed: () => _onTapLogOutButton(context),
                icon: Icon(Icons.logout))
          ],
        ),
      ),
    );
  }

  bool _shouldShowImage(String? photo) {
    return photo != null && photo.isNotEmpty;
  }

  void _onTapProfileUpdateScreen(BuildContext context) {
    //  Navigator.pushAndRemoveUntil(context,
    //   MaterialPageRoute(builder: (context) => UpdateProfileScreen()), (pre) => false);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UpdateProfileScreen()),
    );
  }

  Future<void> _onTapLogOutButton(BuildContext context) async {
    await AuthController.clearUserData();
    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => LoginScreen()), (pre) => false);
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
