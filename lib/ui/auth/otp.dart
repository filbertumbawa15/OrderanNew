import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:tasorderan/bloc/user/otp/otp_bloc.dart';
import 'package:tasorderan/bloc/user/otp_resend/otp_resend_cubit.dart';

class OtpVerification extends StatefulWidget {
  final String? identifier;
  final String? sendOTPVia;
  final String? email;
  static SimpleFontelicoProgressDialog? _dialog;
  static bool show_resend = true;
  static bool hide_timer = false;

  const OtpVerification({
    Key? key,
    this.identifier,
    this.sendOTPVia,
    this.email,
  }) : super(key: key);
  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  int levelClock = 5;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(
            seconds:
                levelClock) // gameData.levelClock is a user entered number elsewhere in the applciation
        )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            OtpVerification.show_resend = true;
            OtpVerification.hide_timer = false;
          });
          _controller!.reset();
        }
      });
  }

  @override
  void dispose() {
    // _controller.dispose();
    OtpVerification.show_resend = true;
    OtpVerification.hide_timer = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey.shade50,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => OtpBloc(),
          ),
          BlocProvider(
            create: (context) =>
                OtpResendCubit(widget.email ?? 'nonong@gmail.com'),
          ),
        ],
        // create: (context) => SubjectBloc(),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/imgs/bg-login.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/imgs/taslogo.png',
                        fit: BoxFit.contain,
                        width: 100,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          'Mohon cek email anda',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                            left: 15.0, top: 0.0, right: 15.0, bottom: 18.0),
                        child: Text(
                          'Kami telah mengirimkan kode verifikasi kepada email example@gmail.com',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      OTPTextField(
                        length: 4,
                        width: MediaQuery.of(context).size.width,
                        textFieldAlignment: MainAxisAlignment.spaceAround,
                        fieldWidth: 55,
                        fieldStyle: FieldStyle.box,
                        outlineBorderRadius: 15,
                        style: const TextStyle(fontSize: 17),
                        onChanged: (pin) {
                          // print("Changed: " + pin);
                        },
                        onCompleted: (otp) {
                          // _showDialog(
                          //     context,
                          //     SimpleFontelicoProgressDialogType.normal,
                          //     'Normal');
                          // print('otp id: ' + widget.identifier);
                          // verifyOtp(
                          //   context,
                          //   otp,
                          //   widget.identifier,
                          //   widget.sendOTPVia,
                          //   OtpVerification._dialog,
                          // );
                        },
                      ),
                      BlocConsumer<OtpResendCubit, OtpResendState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return Visibility(
                            visible: OtpVerification.show_resend,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Tidak mendapatkan kode? ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  GestureDetector(
                                    child: const Text(
                                      "Klik untuk resend",
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Color(0xFF5599E9),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onTap: () async {
                                      // _showDialog(
                                      //     context,
                                      //     SimpleFontelicoProgressDialogType.normal,
                                      //     'Normal');
                                      // await resend(
                                      //   context,
                                      //   widget.email,
                                      //   OtpVerification._dialog,
                                      // );
                                      // setState(() {
                                      //   OtpVerification.show_resend = false;
                                      //   OtpVerification.hide_timer = true;
                                      // });
                                      // _controller.forward();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      // Visibility(
                      //   visible: OtpVerification.hide_timer,
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(top: 20),
                      //     child: Countdown(
                      //       animation: StepTween(
                      //         begin:
                      //             levelClock, // THIS IS A USER ENTERED NUMBER
                      //         end: 0,
                      //       ).animate(_controller),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // void _showDialog(BuildContext context, SimpleFontelicoProgressDialogType type,
  //     String text) async {
  //   if (OtpVerification._dialog == null) {
  //     OtpVerification._dialog = SimpleFontelicoProgressDialog(
  //         context: context, barrierDimisable: false);
  //   }
  //   if (type == SimpleFontelicoProgressDialogType.custom) {
  //     OtpVerification._dialog.show(
  //         message: text,
  //         type: type,
  //         width: 150.0,
  //         height: 75.0,
  //         loadingIndicator: Text(
  //           'C',
  //           style: TextStyle(fontSize: 24.0),
  //         ));
  //   } else {
  //     OtpVerification._dialog.show(
  //         message: text,
  //         type: type,
  //         horizontal: true,
  //         width: 150.0,
  //         height: 75.0,
  //         hideText: true,
  //         indicatorColor: Colors.blue);
  //   }
  // }
}

void reset() {
  // setState(() {
  //   OtpVerification.show_resend = true;
  //   OtpVerification.hide_timer = false;
  // });
}

class Countdown extends AnimatedWidget {
  Countdown({Key? key, required this.animation})
      : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Kirim ulang setelah ",
          style: TextStyle(),
        ),
        Text(
          "$timerText",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}

    // onWillPop: () {
    //   return showDialog<void>(
    //     context: context,
    //     barrierDismissible: false, // user must tap button!
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: const Text('Peringatan'),
    //         content: SingleChildScrollView(
    //           child: ListBody(
    //             children: const <Widget>[
    //               Text(
    //                   'Anda tidak bisa keluar dari halaman ini sebelum melakukan verifikasi terhadap akun anda.'),
    //               // Text('Would you like to approve of this message?'),
    //             ],
    //           ),
    //         ),
    //         actions: <Widget>[
    //           TextButton(
    //             onPressed: () {
    //               Navigator.of(context).pop('Kembali');
    //             },
    //             child: const Text('Kembali'),
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // },


    // print('animation.value  ${animation.value} ');
    // print('inMinutes ${clockTimer.inMinutes.toString()}');
    // print('inSeconds ${clockTimer.inSeconds.toString()}');
    // print(
    //     'inSeconds.remainder ${clockTimer.inSeconds.remainder(60).toString()}');