import 'package:flutter/material.dart';

class SuccessPay extends StatefulWidget {
  const SuccessPay({
    Key? key,
  }) : super(key: key);

  @override
  State<SuccessPay> createState() => _SuccessPayState();
}

class _SuccessPayState extends State<SuccessPay> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1F1EF),
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (route) => false);
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF1F1EF),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              backgroundColor: Color(0xFF5599E9),
              radius: 60.0,
              child: Icon(
                Icons.check,
                size: 90.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              "Payment Success !",
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Nunito-Extrabold',
                fontSize: 30.0,
              ),
            ),
            const SizedBox(height: 180.0),
            InkWell(
              onTap: () => Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (route) => false),
              child: const Text(
                "Kembali Ke Home",
                style: TextStyle(
                  color: Color(0xFF5599E9),
                  fontFamily: 'Nunito-Medium',
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
