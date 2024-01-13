import 'package:flutter/material.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({Key? key}) : super(key: key);

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/imgs/bg-login.jpg'),
          fit: BoxFit.cover,
        )),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/imgs/checklogo.png',
                fit: BoxFit.contain,
              ),
              Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, top: 5.0, right: 15.0, bottom: 18.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      text: 'Kami telah mengirimkan link verifikasi password',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                      // children: <TextSpan>[
                      //   TextSpan(
                      //     text: '${widget.email}',
                      //     style: TextStyle(
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 18.0,
                      //       color: Colors.black,
                      //     ),
                      //   ),
                      // ],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.pushReplacementNamed(context, '/login');
                    //   },
                    //   child: const Text(
                    //     "Kembali Ke Hal. Login",
                    //     style: TextStyle(
                    //       fontSize: 16.0,
                    //       fontWeight: FontWeight.bold,
                    //       color: Color(0xFF5599E9),
                    //     ),
                    //   ),
                    // ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      child: const Text(
                        "Kembali Ke Home",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5599E9),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   width: 350.0,
              //   child: Padding(
              //     padding: EdgeInsets.only(top: 15),
              //     child: ElevatedButton(
              //       onPressed: () {
              //         Navigator.pop(context);
              //       },
              //       child: Text('OK'),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
