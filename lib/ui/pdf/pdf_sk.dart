import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:tasorderan/components/pdf_api.dart';
import 'package:tasorderan/models/pdf_models.dart';

class PdfSKApi {
  static Future<File> generate(SyaratKetentuan syaratKetentuan) async {
    final pdf = Document();
    final imageJpg =
        (await rootBundle.load('assets/imgs/taslogo.png')).buffer.asUint8List();

    pdf.addPage(MultiPage(
      pageFormat: PdfPageFormat.legal,
      build: (context) => [
        buildHeader(imageJpg),
        buildTitle(syaratKetentuan),
        pw.Padding(
          padding: const pw.EdgeInsets.only(top: 15.0, bottom: 15.0),
          child: pw.Text(
              "DENGAN HORMAT, \nSYARAT DAN KETENTUAN DALAM PEMESANAN ORDERAN"),
        ),
        buildSupplierAddress(syaratKetentuan),
        SizedBox(height: 1 * PdfPageFormat.mm),
        buildPengirim(syaratKetentuan),
        // buildInvoice(invoice),
        // Divider(),
        // buildTotal(invoice),
      ],
      footer: (context) => buildFooter(),
    ));

    return PdfApi.saveDocument(
        name: 'Bukti-Pengesahan ${syaratKetentuan.nobukti}.pdf', pdf: pdf);
  }

  static Widget buildHeader(var imageJpg) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              pw.Container(
                width: 80,
                child: Image(pw.MemoryImage(imageJpg)),
              ),
              Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  Text(
                    "JASA PENGURUSAN TRANSPORTASI",
                  ),
                  Text('PT. TRANSPORINDO AGUNG SEJAHTERA',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  Text(
                    '- EMKL - Export-Import - Inter Island - Trucking - Warehouse',
                  ),
                ],
              )
              // buildInvoiceInfo(invoice.info),
            ],
          ),
          pw.Divider(
            color: PdfColors.grey,
            indent: 0,
            endIndent: 0,
            height: 10.0,
          ),
        ],
      );

  static Widget buildCustomerAddress(SyaratKetentuan syaratKetentuan) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Kepada: ${syaratKetentuan.nama}',
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text('No Bukti: ${syaratKetentuan.nobukti}',
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Telp/Fax: ${syaratKetentuan.notelp}',
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Email: test@gmail.com',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      );

  static Widget buildTgl(SyaratKetentuan syaratKetentuan) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('Medan, ${syaratKetentuan.tanggal}',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      );

  static Widget buildSupplierAddress(SyaratKetentuan syaratKetentuan) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Lokasi Muat : ${syaratKetentuan.lokmuat}",
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text("Lokasi Bongkar : ${syaratKetentuan.lokbongkar}",
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text("Harga : ${syaratKetentuan.harga}"),
        ],
      );

  static Widget buildTitle(SyaratKetentuan syaratKetentuan) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          pw.Container(
            width: 200,
            child: buildCustomerAddress(syaratKetentuan),
          ),
          pw.Container(
            width: 200,
            child: buildTgl(syaratKetentuan),
          ),
          // SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildPengirim(SyaratKetentuan syaratKetentuan) {
    final headers = [
      'ADAPUN HARGA TERSEBUT DIATAS BERLAKU DENGAN KONDISI SEBAGAI BERIKUT: ',
    ];
    final data = syaratKetentuan.syaratketentuan!.asMap().entries.map((val) {
      int idx = val.key + 1;
      return [
        '$idx. ${val.value}',
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: const BoxDecoration(color: PdfColors.grey300),
      cellHeight: 15,
      cellAlignments: {
        0: Alignment.centerLeft,
      },
    );
  }

  static Widget buildFooter() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          pw.RichText(
            text: pw.TextSpan(
              children: <TextSpan>[
                pw.TextSpan(
                  text: "Medan: ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text: "Jl.Pulau Menjangan No.3 KIM II, MEDAN 20242",
                ),
              ],
            ),
          ),
          pw.RichText(
            text: pw.TextSpan(
              children: <TextSpan>[
                pw.TextSpan(
                  text: "Jakarta: ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text:
                      "Jl.Gorontalo III No.10 Tanjung Priok, JAKARTA UTARA 14330",
                ),
              ],
            ),
          ),
          pw.RichText(
            text: pw.TextSpan(
              children: <TextSpan>[
                pw.TextSpan(
                  text: "Surabaya: ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text: "Jl. Margomulyo No 44 Blok DD No 12, SURABAYA ",
                ),
              ],
            ),
          ),
          pw.RichText(
            text: pw.TextSpan(
              children: <TextSpan>[
                pw.TextSpan(
                  text: "Makassar: ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text:
                      "Jl.Cakalang III Blok A No.24 Komplek Mall Cakalang MAKASSAR",
                ),
              ],
            ),
          ),
        ],
      );
}
