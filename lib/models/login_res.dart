import 'package:value_client/models/index.dart';

class LoginResModel {
  UserModel? user;
  String? token;
  LoginResModel({this.token, this.user});

  factory LoginResModel.fromJson(Map<String, dynamic> json) {
    return LoginResModel(
      user: UserModel.fromJson(json["user"]),
      token: json["token"],
    );
  }
}
