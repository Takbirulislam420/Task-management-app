import 'package:task_management_app/data/model/user_model.dart';

class LoginModel {
  late final String status;
  late final String token;
  late final UserModel userModel;

  LoginModel.fromJson(Map<String, dynamic> loginJsonData) {
    status = loginJsonData['status'] ?? '';
    token = loginJsonData['token'] ?? '';
    userModel = UserModel.fromjson(loginJsonData['data'] ?? {});
  }
}
