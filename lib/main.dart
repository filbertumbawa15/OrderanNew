import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tasorderan/core/app_setting/app_setting_bloc.dart';
import 'package:tasorderan/core/session_manager.dart';
import 'package:tasorderan/ui/auth/login.dart';
import 'package:tasorderan/ui/auth/otp.dart';
import 'package:tasorderan/ui/auth/register.dart';
import 'package:tasorderan/ui/cekongkir/asal.dart';
import 'package:tasorderan/ui/cekongkir/harga.dart';
import 'package:tasorderan/ui/cekongkir/ongkir.dart';
import 'package:tasorderan/ui/cekongkir/tujuan.dart';
import 'package:tasorderan/ui/home.dart';
import 'package:tasorderan/ui/order/order.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Hive.initFlutter();
  await Hive.openBox('session');
  runApp(const MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
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
        initialRoute: '/home',
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => const Home(),
          '/harga': (BuildContext context) => const Harga(),
          // "/onboarding": (BuildContext context) => new Onboarding(),
          // "/profiles": (BuildContext context) => new Profiles(),
          "/ongkir": (BuildContext context) => Ongkir(),
          "/order": (BuildContext context) => const Order(),
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
          "/asal": (BuildContext context) => const AsalOngkir(),
          "/tujuan": (BuildContext context) => const TujuanOngkir(),
        });
  }
}
