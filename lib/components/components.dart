import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class Tools extends StatelessWidget {
  Tools({Key? key});

  SimpleFontelicoProgressDialog? _dialog;

  Widget? alert(BuildContext context, String message) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Oops...',
      text: message,
    );
  }

  void showDia(BuildContext context, SimpleFontelicoProgressDialogType type,
      String text) async {
    _dialog ??= SimpleFontelicoProgressDialog(
        context: context, barrierDimisable: false);
    if (type == SimpleFontelicoProgressDialogType.custom) {
      _dialog!.show(
          message: text,
          type: type,
          width: 150.0,
          height: 75.0,
          loadingIndicator: const Text(
            'C',
            style: TextStyle(fontSize: 24.0),
          ));
    } else {
      _dialog!.show(
          message: text,
          type: type,
          horizontal: true,
          width: 150.0,
          height: 75.0,
          hideText: true,
          indicatorColor: Colors.blue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
