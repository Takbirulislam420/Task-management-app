import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management_app/data/model/user_model.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  String? token;
  UserModel? userModel;

  static const String _tokenKey = 'token';
  static const String _userDataKey = 'user-data';

  Future<void> saveUserInformation(
      String accessToken, UserModel userModelData) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_tokenKey, accessToken);
    await sharedPreferences.setString(
        _userDataKey, jsonEncode(userModelData.toJson()));
    token = accessToken;
    userModel = userModelData;
    update(); // notify listeners
  }

  Future<void> getUserInformation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString(_tokenKey);
    String? savedUserModelString = sharedPreferences.getString(_userDataKey);
    if (savedUserModelString != null) {
      userModel = UserModel.fromjson(jsonDecode(savedUserModelString));
    }
    update(); // notify listeners
  }

  Future<bool> checkIfUserLogIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString(_tokenKey);
    if (token != null) {
      await getUserInformation();
      return true;
    } else {
      return false;
    }
  }

  Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    token = null;
    userModel = null;
    update();
  }
}
