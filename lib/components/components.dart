import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class Tools extends StatelessWidget {
  const Tools({super.key});

  Widget? alert(BuildContext context, String message) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Oops...',
      text: message,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
