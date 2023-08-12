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
