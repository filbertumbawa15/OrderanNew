import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:tasorderan/components/pdf_api.dart';
import 'package:tasorderan/core/session_manager.dart';
import 'package:tasorderan/models/pdf_models.dart';

class PdfInvoiceApi {
  static Future<File> generate(Invoice invoice) async {
    final pdf = Document();
    final sessionManager = SessionManager();

    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(invoice, sessionManager),
        SizedBox(height: 3 * PdfPageFormat.cm),
        buildTitle(invoice),
        buildPengirim(invoice),
        buildPenerima(invoice),
        buildInvoice(invoice),
        Divider(),
        buildTotal(invoice),
      ],
      footer: (context) => buildFooter(invoice),
    ));

    return PdfApi.saveDocument(name: 'Bukti-Pembayaran.pdf', pdf: pdf);
  }

  static Widget buildHeader(Invoice invoice, SessionManager sessionManager) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              pw.Container(
                width: 200,
                child: buildCustomerAddress(invoice.penerima!, sessionManager),
              ),
              buildInvoiceInfo(invoice.info!),
            ],
          ),
        ],
      );

  static Widget buildCustomerAddress(
          Penerima penerima, SessionManager sessionManager) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nama: ${sessionManager.getActiveName()}',
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Email: ${sessionManager.getActiveEmail()}',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      );

  static Widget buildInvoiceInfo(InvoiceInfo info) {
    final titles = <String>[
      'No. Pesanan',
      'Tgl Pesan',
      'Tgl Bayar',
      'Pembayaran',
    ];
    final data = <String>[
      info.number!,
      info.date!,
      info.payDate!,
      info.payment!,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildPesanan(title: title, value: value, width: 200);
      }),
    );
  }

  static Widget buildSupplierAddress(Pengirim pengirim) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(pengirim.name!, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(pengirim.notelp!, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(pengirim.address!),
        ],
      );

  static Widget buildTitle(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'BUKTI PEMBAYARAN',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          // Text(invoice.info.description),
          // SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildInvoice(Invoice invoice) {
    final headers = [
      'Uk. Cont',
      'Qty',
      'Total',
    ];
    final data = invoice.items!.map((item) {
      // final total = item.unitPrice * item.quantity * (1 + item.vat);

      return [
        item.uk_container,
        '${item.quantity}',
        item.total,
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: const BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerLeft,
        2: Alignment.centerRight,
      },
    );
  }

  static Widget buildPengirim(Invoice invoice) {
    final headers = [
      'Pengirim',
    ];
    final data = invoice.items!.map((item) {
      // final total = item.unitPrice * item.quantity * (1 + item.vat);

      return [
        item.pengirim,
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: const BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
      },
    );
  }

  static Widget buildPenerima(Invoice invoice) {
    final headers = [
      'Penerima',
    ];
    final data = invoice.items!.map((item) {
      // final total = item.unitPrice * item.quantity * (1 + item.vat);

      return [
        item.penerima,
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: const BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
      },
    );
  }

  static Widget buildTotal(Invoice invoice) {
    invoice.items!
        .map((item) =>
            //  item.quantity)
            int.parse(item.total!.substring(4).replaceAll('.', '')))
        .reduce((item1, item2) => item1 + item2);
    // final vatPercent = invoice.items.first.vat;
    // final vat = netTotal * vatPercent;

    return Container();
  }

  static Widget buildFooter(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
        ],
      );

  static buildSimpleText({
    String? title,
    String? value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title!, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value!),
      ],
    );
  }

  static buildText({
    String? title,
    String? value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return pw.Padding(
        padding: const pw.EdgeInsets.only(right: 15.0),
        child: Container(
          width: width,
          child: Row(
            children: [
              pw.Expanded(child: Text(title!, style: style)),
              Text(value!, style: unite ? style : null),
            ],
          ),
        ));
  }

  static buildPesanan({
    String? title,
    String? value,
    double? width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return pw.Padding(
        padding: const pw.EdgeInsets.only(right: 0.0),
        child: Container(
          width: width,
          child: Table(
            columnWidths: {
              0: const FlexColumnWidth(6),
              1: const FlexColumnWidth(1),
              2: const FlexColumnWidth(9),
            },
            children: [
              TableRow(children: [
                Text(title!, style: style),
                Text(' : '),
                pw.Expanded(child: Text(value!, style: unite ? style : null)),
              ]),
            ],
          ),
        ));
  }
}
