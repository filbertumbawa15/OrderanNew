import 'package:tasorderan/models/home_models.dart';

class NotificationsResponse {
  List<NotificationsModels> listNotification = [];

  NotificationsResponse.fromJson(json) {
    for (int i = 0; i < json.length; i++) {
      NotificationsModels notificationsModels =
          NotificationsModels.fromJson(json[i]);
      listNotification.add(notificationsModels);
    }
  }
}
