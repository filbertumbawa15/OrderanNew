import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class Tools extends StatelessWidget {
  Tools({Key? key});

  SimpleFontelicoProgressDialog? dia;

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
    dia ??= SimpleFontelicoProgressDialog(
        context: context, barrierDimisable: false);
    if (type == SimpleFontelicoProgressDialogType.custom) {
      dia!.show(
          message: text,
          type: type,
          width: 150.0,
          height: 75.0,
          loadingIndicator: const Text(
            'C',
            style: TextStyle(fontSize: 24.0),
          ));
    } else {
      dia!.show(
          message: text,
          type: type,
          horizontal: true,
          width: 150.0,
          height: 75.0,
          hideText: true,
          indicatorColor: Colors.blue);
    }
  }

  Future<void> alertBerhasilPesan(BuildContext context, String keterangan,
      String title, String path, Widget action) {
    return Dialogs.materialDialog(
        color: Colors.white,
        msg: keterangan,
        title: title,
        lottieBuilder: Lottie.asset(
          path,
          fit: BoxFit.contain,
        ),
        context: context,
        actions: [action]);
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
