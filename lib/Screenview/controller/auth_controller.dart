import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management_app/data/model/user_model.dart';

class AuthController {
  static String? token;
  static UserModel? userModel;

  static const String _tokenKey = 'token';
  static const String _userDataKey = 'user-data';

  //save user information
  static Future<void> saveUserInformation(
      String accessToken, UserModel userModelData) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_tokenKey, accessToken);
    sharedPreferences.setString(
        _userDataKey, jsonEncode(userModelData.toJson()));
    token = accessToken;
    userModel = userModelData;
  }

  //get userinformation
  static Future<void> getUserInformation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? accessToken = sharedPreferences.getString(_tokenKey);
    String? savedUserModelString = sharedPreferences.getString(_userDataKey);
    if (savedUserModelString != null) {
      UserModel savedUserModel =
          UserModel.fromjson(jsonDecode(savedUserModelString));
      userModel = savedUserModel;
    }
    token = accessToken;
  }

  // i will check here user already login or not
  static Future<bool> checkIfUserLogIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? accessToken = sharedPreferences.getString(_tokenKey);
    if (accessToken != null) {
      await getUserInformation();
      return true;
    } else {
      return false;
    }
  }

  // clear all from cash
  static Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    token = null;
    userModel = null;
  }
}
