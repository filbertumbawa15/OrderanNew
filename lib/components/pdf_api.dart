import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:path/path.dart';
import 'package:tasorderan/main.dart';
import 'package:tasorderan/ui/pdf/pdfviewer.dart';

class PdfApi {
  static Future<File> saveDocument({
    String? name,
    Document? pdf,
  }) async {
    final bytes = await pdf!.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  Future<File> loadNetworkFile(String url) async {
    final response = await Dio()
        .get(url, options: Options(responseType: ResponseType.bytes));
    final bytes = response.data;

    return _storeFile(url, bytes);
  }

  static Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  void openPdf(File file) {
    navigatorKey.currentState?.push(
        MaterialPageRoute(builder: ((context) => PdfViewerPage(pdfUrl: file))));
    // navigatorKey.currentState?.pushNamed('/pdfviewer', arguments: {
    //   'pdfUrl': file,
    // });
  }
}
