class NotificationsModels {
  String? tgl;
  List<dynamic>? dataNotification;

  NotificationsModels({
    this.tgl,
    this.dataNotification,
  });

  // FORMAT TO JSON
  factory NotificationsModels.fromJson(Map<String, dynamic> json) =>
      NotificationsModels(
        tgl: json["tglbukti"],
        dataNotification: json["list"],
      );
}

class ChatUsers {
  String name;
  String messageText;
  String imageURL;
  String time;
  String email;
  ChatUsers({
    required this.name,
    required this.messageText,
    required this.imageURL,
    required this.time,
    required this.email,
  });
}

class ChatMessage {
  String msgText;
  String msgSender;
  bool user;
  dynamic timestamp;
  ChatMessage({
    required this.msgText,
    required this.msgSender,
    required this.user,
    required this.timestamp,
  });
}
