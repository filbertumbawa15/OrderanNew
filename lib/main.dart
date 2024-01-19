import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tasorderan/bloc/user/verifikasi/verifikasi_cubit.dart';
import 'package:tasorderan/components/components.dart';
import 'package:tasorderan/core/api_client.dart';
import 'package:tasorderan/core/app_setting/app_setting_bloc.dart';
import 'package:tasorderan/core/session_manager.dart';
import 'package:tasorderan/ui/auth/email_verification.dart';
import 'package:tasorderan/ui/auth/forgot.dart';
import 'package:tasorderan/ui/auth/login.dart';
import 'package:tasorderan/ui/auth/otp.dart';
import 'package:tasorderan/ui/auth/register.dart';
import 'package:tasorderan/ui/cekongkir/asal.dart';
import 'package:tasorderan/ui/cekongkir/harga.dart';
import 'package:tasorderan/ui/cekongkir/ongkir.dart';
import 'package:tasorderan/ui/cekongkir/tujuan.dart';
import 'package:tasorderan/ui/faq.dart';
import 'package:tasorderan/ui/favorites_list.dart';
import 'package:tasorderan/ui/home.dart';
import 'package:tasorderan/ui/hubung_detail.dart';
import 'package:tasorderan/ui/hubungikami.dart';
import 'package:tasorderan/ui/notifications.dart';
import 'package:tasorderan/ui/order/asal_order.dart';
import 'package:tasorderan/ui/order/bayar.dart';
import 'package:tasorderan/ui/order/list_order.dart';
import 'package:tasorderan/ui/order/list_status_pesanan.dart';
import 'package:tasorderan/ui/order/listqty.dart';
import 'package:tasorderan/ui/order/order.dart';
import 'package:tasorderan/ui/order/payment_success.dart';
import 'package:tasorderan/ui/order/success_pay.dart';
import 'package:tasorderan/ui/order/total.dart';
import 'package:tasorderan/ui/order/tujuan_order.dart';
import 'package:tasorderan/ui/pdf/pdfviewer.dart';
import 'package:tasorderan/ui/syaratketentuan.dart';
import 'package:tasorderan/ui/verifikasi/camera_verifikasi.dart';
import 'package:tasorderan/ui/verifikasi/data_verifikasi.dart';
import 'package:tasorderan/ui/verifikasi/home_verifikasi.dart';
import 'package:tasorderan/ui/verifikasi/ktp_verifikasi.dart';
import 'package:tasorderan/ui/verifikasi/npwp_verifikasi.dart';
import 'package:tasorderan/ui/verifikasi/waiting_verifikasi.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling background message ${message.messageId}");
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
String fcmToken = "";

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Hive.initFlutter();
  await Hive.openBox('session');
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
          apiKey: 'AIzaSyBUbvVC5NnXpAF0Oet2MJQKcCCEHxFkNd8',
          appId: '1:725352137575:android:50e25ebe059210fc3fa5c2',
          messagingSenderId: '725352137575',
          projectId: 'chat-app-project-b6130',
        ))
      : await Firebase.initializeApp();
  // await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  if (Platform.isAndroid) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  runApp(MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final sessionManager = SessionManager();
  final apiClient = ApiClient();
  final components = Tools();

  @override
  void initState() {
    FirebaseMessaging.instance.getToken().then((newToken) {
      fcmToken = newToken!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppSettingBloc(),
        ),
        BlocProvider(
          create: (context) => VerifikasiCubit(),
        ),
      ],
      child: BlocBuilder<AppSettingBloc, AppSettingState>(
          builder: (context, state) {
        if (state is AppSettingLoading) {
          apiClient.channel!.bind("App\\Events\\UserVerified", (event) async {
            final result = jsonDecode(
                jsonDecode(event!.data!)["message"])['verifikasiuser'];
            if (result['id'] == sessionManager.getActiveId()) {
              BlocProvider.of<VerifikasiCubit>(context).cekVerifikasi(
                  result['keteranganverifikasi'],
                  sessionManager.getActiveId()!);
            }
          });
        }
        return BlocConsumer<VerifikasiCubit, VerifikasiState>(
          listener: (context, state) {
            if (state is VerifikasiCekSuccess) {
              Future.delayed(const Duration(seconds: 0), () {
                components.dia!.hide();
                components.alertBerhasilPesan(
                    state.message!, state.title!, state.path!, state.action!);
              });
            }
          },
          builder: (context, state) {
            if (state is VerifikasiCekFailed) {
              Future.delayed(const Duration(seconds: 0), () {
                components.dia!.hide();
              });
            } else if (state is VerifikasiCekLoading) {
              Future.delayed(const Duration(seconds: 0), () {
                components.showDia();
              });
            }
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
                  "/ongkir": (BuildContext context) => const Ongkir(),
                  "/order": (BuildContext context) => const Order(),
                  // "/asal_ongkir": (BuildContext context) => new Asal_Ongkir(),
                  // "/tujuan_ongkir": (BuildContext context) => new Tujuan_Ongkir(),
                  "/login": (BuildContext context) => const Login(),
                  "/register": (BuildContext context) => const Register(),
                  "/total": (BuildContext context) => const Total(),
                  "/bayar": (BuildContext context) => const Bayar(),
                  "/otp_verification": (BuildContext context) =>
                      const OtpVerification(),
                  "/payment_success": (BuildContext context) =>
                      const PaymentSuccess(),
                  "/list_order": (BuildContext context) => const ListOrder(),
                  "/list_status_pesanan": (BuildContext context) =>
                      const ListStatusPesanan(),
                  "/hubungi_kami": (BuildContext context) =>
                      const HubungiKami(),
                  "/hubungi_kami_detail": (BuildContext context) =>
                      const HubungiKamiDetail(),
                  "/syaratdanketentuan": (BuildContext context) =>
                      const SyaratKetentuanWidget(),
                  "/faq": (BuildContext context) => const Faq(),
                  "/favoritesList": (BuildContext context) =>
                      const FavoritesList(),
                  "/notifications": (BuildContext context) =>
                      const Notifications(),
                  // "/homeverifikasi": (BuildContext context) => new HomeVerifikasi(),
                  "/pdfviewer": (BuildContext context) => const PdfViewerPage(),
                  "/asal": (BuildContext context) => const AsalOngkir(),
                  "/asal_order": (BuildContext context) => const Asal(),
                  "/tujuan": (BuildContext context) => const TujuanOngkir(),
                  "/tujuan_order": (BuildContext context) => const Tujuan(),
                  "/home_verifikasi": (BuildContext context) =>
                      const HomeVerifikasi(),
                  "/camera_verifikasi": (BuildContext context) =>
                      const CameraVerifikasi(),
                  "/ktp_verifikasi": (BuildContext context) =>
                      const KtpVerifikasi(),
                  "/npwp_verifikasi": (BuildContext context) =>
                      const NpwpVerifikasi(),
                  "/data_verifikasi": (BuildContext context) =>
                      const DataVerifikasi(),
                  "/waiting_verifikasi": (BuildContext context) =>
                      const WaitingVerifikasi(),
                  "/success_pay": (BuildContext context) => const SuccessPay(),
                  "/forgot": (BuildContext context) => const ForgotPassword(),
                  "/email_verification": (BuildContext context) =>
                      const EmailVerification(),
                  "/list_qty": (BuildContext context) => const ListQty(),
                });
          },
        );
      }),
    );
  }
}
