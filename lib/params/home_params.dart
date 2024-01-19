class ChatParams {
  String? email;
  String? username;
  String? fcmToken;

  ChatParams(
    this.email,
    this.username,
    this.fcmToken,
  );

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "username": email,
      'fcmToken': fcmToken,
    };
  }
}
