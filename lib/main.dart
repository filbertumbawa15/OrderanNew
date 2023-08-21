import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tasorderan/ui/auth/login.dart';
import 'package:tasorderan/ui/auth/otp.dart';
import 'package:tasorderan/ui/auth/register.dart';
import 'package:tasorderan/ui/home.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage? message) async {
//   print("Handling background message ${message.messageId}");
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await MaskForCameraView.initialize();
  // await Firebase.initializeApp();
  // await FirebaseMessaging.instance.getInitialMessage();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // NotificationService().init();
  // HttpOverrides.global = MyHttpOverrides();
  await Hive.initFlutter();
  await Hive.openBox('session');
  runApp(const MyApp());
}

// Future<void> _isAndroidPermissionGranted() async {
//   if (Platform.isAndroid) {
//     await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin>();
//   }
// }

// initInfo() {
//   var androidInitialize =
//       const AndroidInitializationSettings('@mipmap/ic_launcher');
//   var iOSInitialize = const IOSInitializationSettings();
//   var initInitializationSettings =
//       InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
//   flutterLocalNotificationsPlugin.initialize(initInitializationSettings,
//       onSelectNotification: (String payload) async {
//     try {
//       if (payload != null && payload.isNotEmpty) {
//       } else {}
//     } catch (e) {}
//     return;
//   });

//   FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//     print("----------------------onMessage----------------------");
//     print(
//         'onMessage : ${message.notification?.title}/${message.notification?.body}');

//     BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
//       message.notification.body.toString(),
//       htmlFormatBigText: true,
//       contentTitle: message.notification.title.toString(),
//       htmlFormatContentTitle: true,
//     );
//     AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'dbfood',
//       'dbfood',
//       importance: Importance.max,
//       styleInformation: bigTextStyleInformation,
//       priority: Priority.max,
//       playSound: false,
//     );
//     NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(0, message.notification?.title,
//         message.notification?.body, platformChannelSpecifics,
//         payload: message.data['body']);
//   });
// }

// void requestPermission() async {
//   FirebaseMessaging messaging = FirebaseMessaging.instance;

//   NotificationSettings settings = await messaging.requestPermission(
//     alert: true,
//     announcement: true,
//     badge: true,
//     carPlay: true,
//     criticalAlert: true,
//     provisional: true,
//     sound: true,
//   );

//   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//     print("User granted permission");
//   } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
//     print("User granted provosional permission");
//   } else {
//     print("User declined or has not accepted permission");
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TAS Orderan',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Nunito-Medium',
          primarySwatch: Colors.blue,
          inputDecorationTheme: const InputDecorationTheme(
            contentPadding: EdgeInsets.symmetric(vertical: 15),
          ),
          useMaterial3: true,
        ),
        initialRoute: '/login',
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => const Home(),
          // '/harga': (BuildContext context) => new Harga(),
          // "/onboarding": (BuildContext context) => new Onboarding(),
          // "/profiles": (BuildContext context) => new Profiles(),
          // "/ongkir": (BuildContext context) => new Ongkir(),
          // "/order": (BuildContext context) => new Order(),
          // "/asal_ongkir": (BuildContext context) => new Asal_Ongkir(),
          // "/tujuan_ongkir": (BuildContext context) => new Tujuan_Ongkir(),
          "/login": (BuildContext context) => Login(),
          "/register": (BuildContext context) => Register(),
          // "/total": (BuildContext context) => new Total(),
          // "/bayar": (BuildContext context) => new Bayar(),
          "/otp_verification": (BuildContext context) =>
              const OtpVerification(),
          // "/payment_success": (BuildContext context) => new PaymentSuccess(),
          // "/list_pesanan": (BuildContext context) => new ListPesanan(),
          // "/chats": (BuildContext context) => new Chats(),
          // "/syaratdanketentuan": (BuildContext context) =>
          //     new SyaratKetentuanWidget(),
          // "/faq": (BuildContext context) => new Faq(),
          // "/favoritesList": (BuildContext context) => new FavoritesList(),
          // "/notifications": (BuildContext context) => new Notifications(),
          // "/homeverifikasi": (BuildContext context) => new HomeVerifikasi(),
          // "/asal": (BuildContext context) => new Asal(),
          // "/tujuan": (BuildContext context) => new Tujuan(),
        });
  }
}
