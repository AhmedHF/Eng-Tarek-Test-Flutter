import 'package:value_client/entities/index.dart';
import 'package:value_client/models/index.dart';

class LoginModel {
  LoginData? data;
  String? error;
  UserModel? user;
  String? token;
  LoginModel({this.data, this.user});

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        data: LoginData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
  static LoginModel withErrorString(String error) {
    final LoginModel loginData = LoginModel();
    loginData.error = error;
    return loginData;
  }
}

class LoginData extends Login {
  const LoginData({
    required String phone,
    required String password,
  }) : super(
          phone: phone,
          password: password,
        );
  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      phone: json['phone'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() => {
        'phone': phone,
        'password': password,
      };
  @override
  String toString() => 'phone: $phone password: $password ';
}
