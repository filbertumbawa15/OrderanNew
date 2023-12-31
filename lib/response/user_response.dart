import 'package:tasorderan/models/user_models.dart';

class UserRegisterResponse {
  final Map<String, dynamic>? errors;
  final String? message;
  final Map<String, dynamic>? user;

  UserRegisterResponse({this.errors, this.message, this.user});

  factory UserRegisterResponse.fromJson(Map<String, dynamic> json) {
    return UserRegisterResponse(
      errors: json["errors"],
      message: json["message"],
      user: json["user"],
    );
  }
}

class SyaratdanKetentuanResponse {
  List<String?> listSyaratModel = [];

  SyaratdanKetentuanResponse.fromJson(json) {
    for (int i = 0; i < json.length; i++) {
      SyaratdanKetentuanModel model = SyaratdanKetentuanModel.fromJson(json[i]);
      listSyaratModel.add(model.syaratketentuan);
    }
  }
}
