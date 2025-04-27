// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/Screenview/onboarding.dart/splash_screen.dart';
import 'package:task_management_app/const/app_string.dart';
import 'package:task_management_app/controller_binder.dart';
import 'package:task_management_app/myapp_theme.dart';

class TaskManagementApp extends StatefulWidget {
  const TaskManagementApp({super.key});

  static final GlobalKey<NavigatorState> navigatorkey =
      GlobalKey<NavigatorState>();

  @override
  State<TaskManagementApp> createState() => _TaskManagementAppState();
}

class _TaskManagementAppState extends State<TaskManagementApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: TaskManagementApp.navigatorkey,
      title: AppString.appName,
      initialBinding: ControllerBinder(),

      debugShowCheckedModeBanner: true,
      theme: MyappTheme.lightTheme,
      darkTheme: MyappTheme.darkTheme,
      color: Colors.blue,
      home: SplashScreenView(),
      // initialRoute: "/",
      // routes: {
      //   '/': (context) => SplashScreenView(),
      //   '/login': (context) => LoginScreen(),
      //   '/emailVerification': (context) => Emailverificationscreen(),
      //   '/pinverification': (context) => Pinverificationscreen(),
      //   '/registation': (context) => Registationscreenview(),
      //   '/setpassword': (context) => Setpasswordscreen(),
      //   '/profileupdagescreen': (context) => Profileupdagescreen()
      // },
    );
  }
}
