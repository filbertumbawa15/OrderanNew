import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pusher_client/pusher_client.dart';
// import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
// import 'package:pusher_client/pusher_client.dart';

class ApiClient {
  final Dio _dio = Dio();
  final String apiKey = "AIzaSyDBc9RaIaig6eEiiCKpEf1qYKpEyyKgpe4";
  final int utcTime = DateTime.now().timeZoneOffset.inHours;
  final String appUrl = 'https://web.transporindo.com/';
  String? fcmToken;
  PusherClient pusher = PusherClient(
    '776e5cc231a6b28caf4b',
    PusherOptions(
      cluster: 'ap1',
    ),
  );
  Channel? channel;

  ApiClient() {
    FirebaseMessaging.instance.getToken().then((newToken) {
      fcmToken = newToken!;
    });
    channel = pusher.subscribe("data-channel");
    _dio.options.baseUrl = 'https://web.transporindo.com/';
    _dio.options.headers['content-type'] = 'application/json';
    _dio.options.headers['accept'] = 'application/json';
  }
  Dio get dio => _dio;
}
