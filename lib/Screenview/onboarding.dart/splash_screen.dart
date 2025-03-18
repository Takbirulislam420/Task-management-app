// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_management_app/Screenview/Components/background_widget.dart';
import 'package:task_management_app/Screenview/onboarding.dart/login_screen.dart';
import 'package:task_management_app/const/app_image_path.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    super.initState();
    moveToNextScreen();
  }

  Future<void> moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 3), () {
      // ignore: use_build_context_synchronously
      //Navigator.pushNamed(context, "/login");
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackgroundWidget(
            child: Center(
      child: SvgPicture.asset(AppImagePath.logoImage),
    )));
  }
}
