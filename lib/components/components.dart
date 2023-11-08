import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:tasorderan/main.dart';

class Tools extends StatelessWidget {
  Tools({Key? key});

  SimpleFontelicoProgressDialog? dia;

  Widget? alert(String message) {
    QuickAlert.show(
      context: navigatorKey.currentContext!,
      type: QuickAlertType.error,
      title: 'Oops...',
      text: message,
    );
  }

  void showDia() async {
    dia ??= SimpleFontelicoProgressDialog(
        context: navigatorKey.currentContext!, barrierDimisable: false);
    if (SimpleFontelicoProgressDialogType.normal ==
        SimpleFontelicoProgressDialogType.custom) {
      dia!.show(
          message: 'Normal',
          type: SimpleFontelicoProgressDialogType.normal,
          width: 150.0,
          height: 75.0,
          loadingIndicator: const Text(
            'C',
            style: TextStyle(fontSize: 24.0),
          ));
    } else {
      dia!.show(
          message: 'Normal',
          type: SimpleFontelicoProgressDialogType.normal,
          horizontal: true,
          width: 150.0,
          height: 75.0,
          hideText: true,
          indicatorColor: Colors.blue);
    }
  }

  Future<void> alertBerhasilPesan(
      String keterangan, String title, String path, Widget action) {
    return Dialogs.materialDialog(
        color: Colors.white,
        msg: keterangan,
        title: title,
        lottieBuilder: Lottie.asset(
          path,
          fit: BoxFit.contain,
        ),
        context: navigatorKey.currentContext!,
        actions: [action]);
  }

  void bottomDialog(
      BuildContext context, String msg, String title, List<Widget> action) {
    return Dialogs.bottomMaterialDialog(
        msg: msg, title: title, context: context, actions: action);
  }

  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}');
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  Widget? bottomSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: navigatorKey.currentContext!,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.9,
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(100.0),
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  titleSpacing: 15.0,
                  title: const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Syarat dan Ketentuan",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Last Updated 12 Juli 2022",
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey,
                            fontFamily: 'Nunito-Medium',
                          ),
                        ),
                      ],
                    ),
                  ),
                  bottom: const PreferredSize(
                    preferredSize: Size.fromHeight(0.0),
                    child: Divider(
                      color: Color.fromARGB(255, 145, 145, 145),
                      indent: 0,
                      endIndent: 0,
                      height: 10.0,
                    ),
                  ),
                ),
              ),
              body: const SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Adapun Harga tersebut diatas berlaku dengan kondisi sebagai berikut:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "1. HARGA BELUM TERMASUK BIAYA KAWAL (JIKA ADA)",
                                    style: TextStyle(
                                      fontFamily: 'Nunito-Medium',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "2. BELUM TERMASUK BIAYA BONGKAR MUAT DI LOKASI STUFFING / STRIPPING",
                                    style: TextStyle(
                                      fontFamily: 'Nunito-Medium',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "3. BERLAKU UNTUK LOKASI YANG DAPAT MASUK CONTAINER ATAU TRAILER TANPA ADA LARANGAN (TIDAK TERMASUK UANG KAWAL)",
                                    style: TextStyle(
                                      fontFamily: 'Nunito-Medium',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "4. MUATAN MAKSIMUM PETI KEMAS BESERTA ISINYA (BRUTTO) ADALAH 23 TON (20') & 26 TON (40').",
                                    style: TextStyle(
                                      fontFamily: 'Nunito-Medium',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "5. FREETIME STORAGE DAN DEMURRAGE ADALAH 3 (TIGA) HARI DI TEMPAT TUJUAN (PEMBONGKARAN), APABILA LEBIH DARI 3 (TIGA) HARI MAKA SEGALA BIAYA DILUAR TANGGUNG JAWAB EKSPEDISI.",
                                    style: TextStyle(
                                      fontFamily: 'Nunito-Medium',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "6. EKSPEDISI TIDAK BERTANGGUNG JAWAB ATAS KERUGIAN AKIBAT FORCE MAJEUR (BENCANA ALAM), HURU - HARA, PERAMPOKAN, KERUSUHAN, PENJARAHAN / PEMBAJAKAN.",
                                    style: TextStyle(
                                      fontFamily: 'Nunito-Medium',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "7. EKSPEDISI TIDAK BERTANGGUNG JAWAB ATAS KEHILANGAN BARANG, KEKURANGAN, JIKA SEAL / PENGAMAN DALAM KEADAAN BAGUS.",
                                    style: TextStyle(
                                      fontFamily: 'Nunito-Medium',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "8. EKSPEDISI TIDAK BERTANGGUNG JAWAB ATAS PERUBAHAN KUALITAS BARANG DIKARENAKAN OLEH SIFAT BARANG ITU.",
                                    style: TextStyle(
                                      fontFamily: 'Nunito-Medium',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "9. DIANJURKAN PIHAK SHIPPER UNTUK MENGASURANSIKAN BARANGNYA DALAM KEADAAN ALL RISK WARE HOUSE TO WARE HOUSE.",
                                    style: TextStyle(
                                      fontFamily: 'Nunito-Medium',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "10. MUATAN TIDAK BOLEH BERAT SEBELAH, APABILA TERJADI MAKA SEGALA BIAYA DITANGGUNG PEMILIK BARANG.",
                                    style: TextStyle(
                                      fontFamily: 'Nunito-Medium',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "11.PEMILIK BARANG BERTANGGUNG JAWAB TERHADAP ISI MUATAN DARI AKIBAT HUKUM YANG TIMBUL DENGAN MEMBEBASKAN PERUSAHAAN PENGANGKUTAN DARI SEGALA INSTANSI YANG BERSANGKUTAN DAN BERSEDIA MENANGGUNG SEGALA BIAYA KERUGIAN YANG TIMBUL.",
                                    style: TextStyle(
                                      fontFamily: 'Nunito-Medium',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "12. PELUNASAN JASA EKSPEDISI PALING LAMBAT 1 (SATU) BULAN DARI TANGGAL KAPAL BERANGKAT SESUAI YANG TERCANTUM DI BL PELAYARAN.",
                                    style: TextStyle(
                                      fontFamily: 'Nunito-Medium',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "13. HARGA TIDAK MENGIKAT SEWAKTU WAKTU DAPAT BERUBAH.",
                                    style: TextStyle(
                                      fontFamily: 'Nunito-Medium',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
