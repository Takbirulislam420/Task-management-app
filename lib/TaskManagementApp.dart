// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:task_management_app/Screenview/onboarding.dart/splash_screen.dart';
import 'package:task_management_app/const/app_colors.dart';
import 'package:task_management_app/const/app_string.dart';

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
    return MaterialApp(
      navigatorKey: TaskManagementApp.navigatorkey,
      title: AppString.appName,

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.amber,
        inputDecorationTheme: InputDecorationTheme(
            hintStyle:
                TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            border: InputBorder.none),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              fixedSize: Size.fromWidth(double.maxFinite),
              backgroundColor: AppColors.submitButton,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              )),
        ),
        textTheme: TextTheme(
            titleLarge: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins_Regular')),
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.amber,
        inputDecorationTheme: InputDecorationTheme(
            alignLabelWithHint: true,
            hintStyle:
                TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            border: InputBorder.none),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              fixedSize: Size.fromWidth(double.maxFinite),
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              )),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins_Regular'),
        ),
      ),
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
