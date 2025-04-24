// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_management_app/Screenview/Components/background_component.dart';
import 'package:task_management_app/Screenview/controller/auth_controller.dart';
import 'package:task_management_app/Screenview/onboarding.dart/login_screen.dart';
import 'package:task_management_app/Screenview/tesk/home_screen.dart';
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
    await Future.delayed(Duration(seconds: 3)); //wait here 3 seconds
    final bool isLoggedIn =
        await AuthController.to.checkIfUserLogIn(); //check log in here
    Navigator.pushReplacement(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(
          builder: (context) => isLoggedIn ? HomeScreen() : LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackgroundComponent(
            child: Center(
      child: SvgPicture.asset(AppImagePath.logoImage),
    )));
  }
}
