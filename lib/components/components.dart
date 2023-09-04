import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
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

  void bottomDialog(
      BuildContext context, String msg, String title, List<Widget> action) {
    return Dialogs.bottomMaterialDialog(
        msg: msg, title: title, context: context, actions: action);
  }

  Future<void> trySomething(BuildContext context, String message) async {
    await Future.delayed(const Duration(milliseconds: 200));
    alert(context, message);
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
