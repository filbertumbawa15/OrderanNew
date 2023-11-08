import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:tasorderan/bloc/user/otp/otp_bloc.dart';
import 'package:tasorderan/components/components.dart';

class OtpVerification extends StatefulWidget {
  final String? identifier;
  final String? sendOTPVia;
  final String? email;

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
  int levelClock = 5;
  final components = Tools();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey.shade50,
      body: BlocProvider(
        create: (context) => OtpBloc(),
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
                          'Mohon untuk mengecek OTP tersebut di email yang diinput sebelumnya.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      BlocConsumer<OtpBloc, OtpState>(
                        listener: (context, state) {
                          if (state is OtpSuccess) {
                            components.dia!.hide();
                            Future.delayed(const Duration(seconds: 0), () {
                              components.alertBerhasilPesan(
                                "Akun anda berhasil ter-verifikasi, silahkan login untuk melakukan pemesanan.",
                                "Register Berhasil",
                                "assets/imgs/updated-transaction.json",
                                IconsButton(
                                  onPressed: () async {
                                    await Navigator.pushReplacementNamed(
                                        context, "/login");
                                  },
                                  text: 'Ok',
                                  iconData: Icons.done,
                                  color: Colors.blue,
                                  textStyle:
                                      const TextStyle(color: Colors.white),
                                  iconColor: Colors.white,
                                ),
                              );
                            });
                            // Navigator.push(context, route)
                          }
                        },
                        builder: (context, state) {
                          if (state is OtpLoading) {
                            Future.delayed(const Duration(seconds: 0), () {
                              components.showDia();
                            });
                          } else if (state is OtpError) {
                            components.dia!.hide();
                            Future.delayed(const Duration(seconds: 0), () {
                              components.alert(state.message);
                            });
                          }
                          return OTPTextField(
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
                              context.read<OtpBloc>().add(CheckOtpEvent(
                                  otp: otp, identifier: widget.email!));
                            },
                          );
                        },
                      ),
                      BlocBuilder<OtpBloc, OtpState>(
                        builder: (context, state) {
                          if (state is OtpResendLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is OtpResendError) {
                            // components.dia!.hide();
                            return Center(child: Text(state.message));
                          }
                          return Padding(
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
                                    context.read<OtpBloc>().add(
                                        OtpResendEvent(email: widget.email!));
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

