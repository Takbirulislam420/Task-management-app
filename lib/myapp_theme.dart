import 'package:flutter/material.dart';
import 'package:task_management_app/const/app_colors.dart';

class MyappTheme {
  static final ThemeData lightTheme = ThemeData(
    colorSchemeSeed: Colors.amber,
    iconTheme: IconThemeData(
      color: Colors.white, // All icons will be white
    ),
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white), // AppBar icons white
      titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20), // AppBar title text white (optional)
      backgroundColor: Colors.transparent, // or your desired color
      elevation: 0,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
      border: InputBorder.none,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size.fromWidth(double.maxFinite),
        backgroundColor: AppColors.submitButton,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        fontFamily: 'Poppins_Regular',
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.amber,
    iconTheme: IconThemeData(
      color: Colors.white, // All icons will be white
    ),
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white), // AppBar icons white
      titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20), // AppBar title text white (optional)
      backgroundColor: Colors.transparent, // or your desired color
      elevation: 0,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      alignLabelWithHint: true,
      hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
      border: InputBorder.none,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size.fromWidth(double.maxFinite),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        fontFamily: 'Poppins_Regular',
      ),
    ),
  );
}
