import 'package:equatable/equatable.dart';
import 'package:value_client/models/index.dart';

class UserDataModel extends Equatable {
  final UserModel? user;
  final String? token;
  const UserDataModel({this.token, this.user});

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      user: UserModel.fromJson(json["user"]),
      token: json["token"],
    );
  }

  Map<String, dynamic> toJson() => {
        'token': token,
        'user': user,
      };

  @override
  List<Object?> get props => [user, token];
}
