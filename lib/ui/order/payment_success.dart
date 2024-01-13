import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tasorderan/bloc/pesanan/pesanan/listorderdetail/listorderdetail_cubit.dart';
import 'package:tasorderan/components/components.dart';
import 'package:tasorderan/components/pdf_api.dart';
import 'package:tasorderan/core/api_client.dart';
import 'package:tasorderan/models/pdf_models.dart';
import 'package:tasorderan/ui/pdf/pdf_invoiceapi.dart';

class PaymentSuccess extends StatefulWidget {
  const PaymentSuccess({
    Key? key,
  }) : super(key: key);

  @override
  State<PaymentSuccess> createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
  final double circleRadius = 120.0;
  final components = Tools();
  final apiClient = ApiClient();
  final pdfApi = PdfApi();
  double invoiceTambahanSum = 0;

  String? harga_bayar;
  String? noVA;
  String? nobukti;
  int? payment_status;
  String? alamat_asal;
  String? note_pengirim;
  String? pengirim;
  String? notelppengirim;
  String? alamat_tujuan;
  String? note_penerima;
  String? penerima;
  String? notelppenerima;
  String? order_date;
  String? payment_date;
  String? payment_code;
  String? link;
  String? latitude_pelabuhan_asal;
  String? longitude_pelabuhan_asal;
  String? latitude_pelabuhan_tujuan;
  String? longitude_pelabuhan_tujuan;
  String? latitude_muat;
  String? longitude_muat;
  String? latitude_bongkar;
  String? longitude_bongkar;
  double? nominalrefund;
  String? buktipdf;
  String? lampiraninvoice;
  String? placeidasal;
  String? pelabuhanidasal;
  String? jarak_asal;
  String? waktu_asal;
  String? namapelabuhanmuat;
  String? namapelabuhanbongkar;
  String? placeidtujuan;
  String? pelabuhanidtujuan;
  String? jarak_tujuan;
  String? waktu_tujuan;
  String? container_id;
  String? nilaibarang;
  String? qty;
  String? jenisbarang;
  String? namabarang;
  String? keterangantambahan;
  List<dynamic>? invoicetambahan;
  String? merchant_id;
  String? merchant_password;
  int? totalNominal;

  @override
  void initState() {
    super.initState();
    // getBuktiPdf(widget.buktipdf);
    // invoicetambahan = widget.invoicetambahan;
  }

  // Future<File> getBuktiPdf(String buktiPdf) async {
  //   var rng = new Random();
  //   Directory tempDir = await getTemporaryDirectory();
  //   String tempPath = tempDir.path;
  //   File bukti_pdf =
  //       new File('$tempPath' + (rng.nextInt(10000000)).toString() + '.pdf');
  //   http.Response response = await http.get(
  //     Uri.parse(
  //         '${globals.url}/api-orderemkl/public/api/syaratdanketentuan/bukti_pdf/$buktiPdf'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //       'Authorization': 'Bearer ${globals.accessToken}',
  //     },
  //   );
  //   await bukti_pdf.writeAsBytes(response.bodyBytes);
  //   pdfFile = bukti_pdf;
  // }

  // void getStatusOrderan(String nobukti, String qty) async {
  //   var data = {"nobukti": nobukti, "qty": qty};
  //   final response = await http.get(
  //       Uri.parse(
  //           '${globals.url}/api-orderemkl/public/api/pesanan/getstatusorderan?data=${jsonEncode(data)}'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //         'Authorization': 'Bearer ${globals.accessToken}',
  //       });
  //   final result = jsonDecode(response.body);
  //   if (response.statusCode == 200) {
  //     await Future.delayed(Duration(seconds: 2));
  //     _dialog.hide();
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => Tracking(
  //                   kode_container: result['data'][0]['nocont'],
  //                   nobukti: result['data'][0]['nobukti'],
  //                   qty: result['data'][0]['qty'],
  //                 )));
  //   }
  // }

  // void openPdf(BuildContext context, File file) {
  //   Navigator.push(context,
  //       MaterialPageRoute(builder: ((context) => PdfViewer(pdfUrl: file))));
  // }

  // Future<String> getPembayaran(String payment_code) async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse(
  //           '${globals.url}/api-orderemkl/public/api/faspay/listofpayment'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //         'Authorization': 'Bearer ${globals.accessToken}',
  //       },
  //     );
  //     final result = jsonDecode(response.body);
  //     List<dynamic> pg_data = result['payment_channel'];
  //     List<dynamic> payment_name =
  //         pg_data.where((el) => el['pg_code'] == payment_code).toList();
  //     return payment_name[0]['pg_name'];
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      harga_bayar = args["harga_bayar"];
      noVA = args["noVA"];
      nobukti = args["nobukti"];
      payment_status = args["payment_status"];
      alamat_asal = args["alamat_asal"];
      note_pengirim = args["note_pengirim"];
      pengirim = args["pengirim"];
      notelppengirim = args["notelppengirim"];
      alamat_tujuan = args["alamat_tujuan"];
      note_penerima = args["note_penerima"];
      penerima = args["penerima"];
      notelppenerima = args["notelppenerima"];
      order_date = args["order_date"];
      payment_date = args["payment_date"];
      payment_code = args["payment_code"];
      link = args["link"];
      latitude_pelabuhan_asal = args["latitude_pelabuhan_asal"];
      longitude_pelabuhan_asal = args["longitude_pelabuhan_asal"];
      latitude_pelabuhan_tujuan = args["latitude_pelabuhan_tujuan"];
      longitude_pelabuhan_tujuan = args["longitude_pelabuhan_tujuan"];
      latitude_muat = args["latitude_muat"];
      longitude_muat = args["longitude_muat"];
      latitude_bongkar = args["latitude_bongkar"];
      longitude_bongkar = args["longitude_bongkar"];
      nominalrefund = args["nominalrefund"];
      buktipdf = args["buktipdf"];
      lampiraninvoice = args["lampiraninvoice"];
      placeidasal = args["placeidasal"];
      pelabuhanidasal = args["pelabuhanidasal"];
      jarak_asal = args["jarak_asal"];
      waktu_asal = args["waktu_asal"];
      namapelabuhanmuat = args["namapelabuhanmuat"];
      namapelabuhanbongkar = args["namapelabuhanbongkar"];
      placeidtujuan = args["placeidtujuan"];
      pelabuhanidtujuan = args["pelabuhanidtujuan"];
      jarak_tujuan = args["jarak_tujuan"];
      waktu_tujuan = args["waktu_tujuan"];
      container_id = args["container_id"];
      nilaibarang = args["nilaibarang"];
      qty = args["qty"];
      jenisbarang = args["jenisbarang"];
      namabarang = args["namabarang"];
      keterangantambahan = args["keterangantambahan"];
      invoicetambahan = args["invoicetambahan"];
      merchant_id = args["merchant_id"];
      merchant_password = args["merchant_password"];
      totalNominal = args["totalNominal"];
    }
    return WillPopScope(
      onWillPop: () async {
        if (link == "ListPesanan") {
          Navigator.pop(context);
        } else {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        }
        return false;
      },
      child: BlocProvider(
        create: (context) => ListorderdetailCubit(),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Color(0xFF747474),
              ),
            ),
            title: const Text(
              "Detail Order",
              style: TextStyle(
                color: Color(0xFF747474),
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                fontFamily: 'Nunito-Medium',
              ),
            ),
            backgroundColor: Colors.white,
            actions: [
              if (payment_status == 2) ...[
                InkWell(
                  onTap: () {
                    // Future.delayed(const Duration(seconds: 0), (() async {
                    //   final data_refund = await Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => RefundForm(
                    //         nobukti: widget.nobukti,
                    //         harga: widget.harga_bayar,
                    //       ),
                    //     ),
                    //   );
                    //   // if (data_refund != null) {
                    //   //   Future.delayed(Duration.zero, () {
                    //   //     _showDialog(context,
                    //   //         SimpleFontelicoProgressDialogType.normal, 'Normal');
                    //   //     getDataMaster();
                    //   //   });
                    //   // }
                    // }));
                  },
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.money,
                        color: Color(0xFF747474),
                      ),
                      Text(
                        "Refund",
                        style: TextStyle(
                          color: Color(0xFF747474),
                        ),
                      ), // <-- Text
                    ],
                  ),
                ),
                const SizedBox(width: 15.0),
                InkWell(
                  onTap: () async {
                    if (int.parse(qty!) > 1) {
                      Navigator.pushNamed(context, '/list_qty', arguments: {
                        'nobukti': nobukti,
                      });
                    } else {
                      Navigator.pushNamed(context, '/list_status_pesanan',
                          arguments: {
                            'nobukti': nobukti,
                            'qty': int.parse(qty!),
                          });
                    }
                    // if (int.parse(widget.qty) > 1) {
                    //   _showDialog(context,
                    //       SimpleFontelicoProgressDialogType.normal, 'Normal');
                    //   _dialog.hide();
                    //   await Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: ((context) => ListQty(
                    //             nobukti: widget.nobukti,
                    //           )),
                    //     ),
                    //   );
                    // } else {
                    //   _showDialog(context,
                    //       SimpleFontelicoProgressDialogType.normal, 'Normal');
                    //   getStatusOrderan(widget.nobukti, widget.qty);
                    // }
                  },
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.local_shipping,
                        color: Color(0xFF747474),
                      ),
                      Text(
                        "Status",
                        style: TextStyle(
                          color: Color(0xFF747474),
                        ),
                      ), // <-- Text
                    ],
                  ),
                ),
              ],
              const SizedBox(width: 15.0),
              InkWell(
                onTap: () async {
                  // if (globals.verificationStatus == "0" ||
                  //     globals.verificationStatus == "12" ||
                  //     globals.verificationStatus == "14") {
                  //   globals.alertBerhasilPesan(
                  //       context,
                  //       "Anda belum menyelesaikan status verifikasi anda/belum login",
                  //       'Orderan',
                  //       'assets/imgs/updated-transaction.json');
                  // } else {
                  //   _showDialog(context, SimpleFontelicoProgressDialogType.normal,
                  //       'Normal');
                  //   await Future.delayed(const Duration(seconds: 2));
                  //   _dialog.hide();
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => Order(
                  //                 placeidasal: widget.placeidasal,
                  //                 latitude_place_asal: widget.latitude_muat,
                  //                 longitude_place_asal: widget.longitude_muat,
                  //                 pelabuhanidasal: widget.pelabuhanidasal,
                  //                 latitude_pelabuhan_asal:
                  //                     widget.latitude_pelabuhan_asal,
                  //                 longitude_pelabuhan_asal:
                  //                     widget.longitude_pelabuhan_asal,
                  //                 jarak_asal: widget.jarak_asal,
                  //                 waktu_asal: widget.waktu_asal,
                  //                 alamatasal: widget.alamat_asal,
                  //                 pengirim: widget.pengirim,
                  //                 notelppengirim: widget.notelppengirim,
                  //                 notepengirim: widget.note_pengirim,
                  //                 namapelabuhanmuat: widget.namapelabuhanmuat,
                  //                 //Tujuan
                  //                 placeidtujuan: widget.placeidtujuan,
                  //                 latitude_place_tujuan: widget.latitude_bongkar,
                  //                 longitude_place_tujuan:
                  //                     widget.longitude_bongkar,
                  //                 pelabuhanidtujuan: widget.pelabuhanidtujuan,
                  //                 latitude_pelabuhan_tujuan:
                  //                     widget.latitude_pelabuhan_tujuan,
                  //                 longitude_pelabuhan_tujuan:
                  //                     widget.longitude_pelabuhan_tujuan,
                  //                 jarak_tujuan: widget.jarak_tujuan,
                  //                 waktu_tujuan: widget.waktu_tujuan,
                  //                 alamattujuan: widget.alamat_tujuan,
                  //                 penerima: widget.penerima,
                  //                 notelppenerima: widget.notelppenerima,
                  //                 notepenerima: widget.note_penerima,
                  //                 namapelabuhanbongkar:
                  //                     widget.namapelabuhanbongkar,
                  //                 //Lainnya
                  //                 container_id: widget.container_id,
                  //                 nilaibarang: widget.nilaibarang,
                  //                 qty: widget.qty,
                  //                 jenisbarang: widget.jenisbarang,
                  //                 namabarang: widget.namabarang,
                  //                 keterangantambahan: widget.keterangantambahan,
                  //               )));
                  // }
                },
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.replay,
                      color: Color(0xFF747474),
                    ),
                    Text(
                      "Re-Order",
                      style: TextStyle(
                        color: Color(0xFF747474),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15.0),
            ],
          ),
          backgroundColor: const Color(0xFFE6E6E6),
          body: BlocConsumer<ListorderdetailCubit, ListorderdetailState>(
            listener: (context, state) async {
              if (state is ListorderdetailSuccess) {
                final url =
                    "${apiClient.appUrl}orderemkl-api/public/api/pesanan/bukti_pdf/${state.result}";
                print(url);
                final file = await pdfApi.loadNetworkFile(url);
                pdfApi.openPdf(file);
              } else if (state is ListorderdetailFailed) {
                Future.delayed(const Duration(seconds: 0), () {
                  components.alert("Invoice Belum Terbit");
                });
              }
            },
            builder: (context, state) {
              return ListView(
                children: [
                  const SizedBox(height: 10.0),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Column(
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const SizedBox(width: 0.0),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Text(
                                      'Lokasi Muat',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Color(0xFF666666),
                                        fontFamily: 'Nunito-Medium',
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: GestureDetector(
                                              onTap: () {
                                                // setMap(
                                                //     '${widget.latitude_pelabuhan_asal},${widget.longitude_pelabuhan_asal}',
                                                //     widget.origincontroller);
                                                // setState(() {
                                                //   distance = widget.jarakasal;
                                                //   duration = widget.waktuasal;
                                                // });
                                              },
                                              child: Text(
                                                alamat_asal!,
                                                style: const TextStyle(
                                                  fontFamily: 'Nunito-Medium',
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                softWrap: true,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Column(
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const SizedBox(width: 0.0),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Text(
                                      'Lokasi Bongkar',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Color(0xFF666666),
                                        fontFamily: 'Nunito-Medium',
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: GestureDetector(
                                              onTap: () {
                                                // setMap(
                                                //     '${widget.latitude_pelabuhan_asal},${widget.longitude_pelabuhan_asal}',
                                                //     widget.origincontroller);
                                                // setState(() {
                                                //   distance = widget.jarakasal;
                                                //   duration = widget.waktuasal;
                                                // });
                                              },
                                              child: Text(
                                                alamat_tujuan!,
                                                style: const TextStyle(
                                                  fontFamily: 'Nunito-Medium',
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                softWrap: true,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  if (payment_status == 2) ...[
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Card(
                        elevation: 2,
                        child: ClipPath(
                          clipper: ShapeBorderClipper(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3))),
                          child: Container(
                            height: 30,
                            decoration: const BoxDecoration(
                                color: Color(0xFFD2FFD9),
                                border: Border(
                                    left: BorderSide(
                                        color: Color(0xFF039600), width: 8))),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 8.0, top: 4.0),
                              child: Text(
                                "Pembayaran Berhasil",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Color(0xFF039600),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ] else if (payment_status == 8) ...[
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Card(
                        elevation: 2,
                        child: ClipPath(
                          clipper: ShapeBorderClipper(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3))),
                          child: Container(
                            height: 30,
                            decoration: const BoxDecoration(
                                color: Color(0xFFFFD2D2),
                                border: Border(
                                    left: BorderSide(
                                        color: Color(0xFFE95555), width: 8))),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 8.0, top: 4.0),
                              child: Text(
                                "Pembayaran Dibatalkan",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Color(0xFF960000),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 10.0),
                  Container(
                    padding: const EdgeInsets.only(left: 15.0, right: 8.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              const TextSpan(
                                text: 'No. Order: ',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Nunito-Medium',
                                ),
                              ),
                              TextSpan(
                                text: '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  fontFamily: 'Nunito-Medium',
                                ),
                                children: [
                                  TextSpan(
                                    text: nobukti!,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.local_phone),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ExpansionTile(
                      title: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            const TextSpan(
                              text: 'Total Invoice: ',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'Nunito-Medium',
                              ),
                            ),
                            TextSpan(
                              text: '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                fontFamily: 'Nunito-Medium',
                              ),
                              children: [
                                TextSpan(
                                  text: NumberFormat.currency(
                                          locale: 'id',
                                          symbol: 'Rp. ',
                                          decimalDigits: 00)
                                      .format(
                                    double.tryParse(harga_bayar!)! +
                                        (totalNominal ?? 0),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 18.0, top: 5.0, bottom: 5.0, right: 18.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const SizedBox(width: 0.0),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const Text(
                                        'INVOICE UTAMA',
                                        style: TextStyle(
                                          fontSize: 17.0,
                                          fontFamily: 'Nunito-Medium',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                            child: GestureDetector(
                                                onTap: () {
                                                  // setMap(
                                                  //     '${widget.latitude_pelabuhan_asal},${widget.longitude_pelabuhan_asal}',
                                                  //     widget.origincontroller);
                                                  // setState(() {
                                                  //   distance = widget.jarakasal;
                                                  //   duration = widget.waktuasal;
                                                  // });
                                                },
                                                child: const Text(
                                                  "Biaya tersebut adalah biaya utama yang sudah dibayarkan pada saat ingin melakukan orderan",
                                                  style: TextStyle(
                                                    fontFamily: 'Nunito-Medium',
                                                  ),
                                                  softWrap: true,
                                                )),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Invoice Utama"),
                                  Text(
                                    NumberFormat.currency(
                                            locale: 'id',
                                            symbol: 'Rp. ',
                                            decimalDigits: 00)
                                        .format(double.tryParse(
                                            harga_bayar.toString())),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5.0),
                              if (payment_status == 2) ...[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height: 28,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          textStyle: const TextStyle(
                                            color: Colors.white,
                                          ),
                                          backgroundColor:
                                              const Color(0xFFD9D9D9),
                                        ),
                                        onPressed: () async {
                                          BlocProvider.of<ListorderdetailCubit>(
                                                  context)
                                              .loadBuktiInvoice(nobukti!);
                                        },
                                        child: const Text(
                                          "Lihat Invoice",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Nunito-Medium'),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 28,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          textStyle: const TextStyle(
                                            color: Colors.white,
                                          ),
                                          backgroundColor:
                                              const Color(0xFFD9D9D9),
                                        ),
                                        onPressed: () async {
                                          components.showDia();
                                          final invoice = Invoice(
                                            pengirim: Pengirim(
                                              name: pengirim,
                                              address: alamat_asal,
                                              notelp: notelppengirim,
                                              paymentInfo: payment_code,
                                            ),
                                            penerima: Penerima(
                                              name: penerima,
                                              address: alamat_tujuan,
                                              notelp: notelppenerima,
                                            ),
                                            info: InvoiceInfo(
                                              date: order_date,
                                              payDate: payment_date,
                                              number: nobukti,
                                              payment: payment_code,
                                            ),
                                            items: [
                                              InvoiceItem(
                                                pengirim:
                                                    '$pengirim\n$alamat_asal\n$notelppengirim',
                                                penerima:
                                                    '$penerima\n$alamat_tujuan\n$notelppenerima',
                                                quantity: int.parse(qty!),
                                                uk_container:
                                                    container_id == "1"
                                                        ? '20 ft'
                                                        : '40 ft',
                                                total: NumberFormat.currency(
                                                        locale: 'id',
                                                        symbol: 'Rp. ',
                                                        decimalDigits: 00)
                                                    .format(double.tryParse(
                                                        harga_bayar
                                                            .toString())),
                                              ),
                                            ],
                                          );

                                          final pdfFile =
                                              await PdfInvoiceApi.generate(
                                                  invoice);
                                          components.dia!.hide();
                                          pdfApi.openPdf(pdfFile);
                                        },
                                        child: const Text(
                                          "Lihat Bukti Bayar",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Nunito-Medium'),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                              const SizedBox(height: 5.0),
                              const Divider(
                                color: Color(0xFFD6D6D6),
                                thickness: 1,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const SizedBox(width: 0.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const Text(
                                          'INVOICE TAMBAHAN',
                                          style: TextStyle(
                                            fontSize: 17.0,
                                            fontFamily: 'Nunito-Medium',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                              child: GestureDetector(
                                                  onTap: () {},
                                                  // Then wrap your text widget with expanded
                                                  child: const Text(
                                                    "Biaya tersebut adalah biaya yang ditambahkan pada saat proses perjalanan bongkar muat",
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Nunito-Medium',
                                                    ),
                                                    softWrap: true,
                                                  )),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text("Invoice Tambahan"),
                                            Text(
                                              NumberFormat.currency(
                                                      locale: 'id',
                                                      symbol: 'Rp. ',
                                                      decimalDigits: 00)
                                                  .format(totalNominal ?? 0),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5.0),
                                        ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount: invoicetambahan!.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            String tglbayar = DateFormat(
                                                    "dd-MM-yyyy")
                                                .format(DateFormat(
                                                        "yyyy-MM-dd HH:mm:ss")
                                                    .parse(
                                                        invoicetambahan![index]
                                                            ["paymentdate"]));
                                            invoiceTambahanSum +=
                                                double.tryParse(
                                                    invoicetambahan![index]
                                                        ['nominal'])!;
                                            return GestureDetector(
                                              onTap: () async {
                                                // if (tglbayar == "01-01-1900") {
                                                //   final data_invoice =
                                                //       await Navigator.push(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //       builder: (context) =>
                                                //           PaymentInvoiceTambahan(
                                                //         harga:
                                                //             invoicetambahan[index]
                                                //                 ['nominal'],
                                                //         tglinvoice:
                                                //             invoicetambahan[index]
                                                //                 ['tglinvoice'],
                                                //         keterangan:
                                                //             invoicetambahan[index]
                                                //                 ['keterangan'],
                                                //         lampiran1:
                                                //             invoicetambahan[index]
                                                //                 ['lampiran1'],
                                                //         lampiran2:
                                                //             invoicetambahan[index]
                                                //                 ['lampiran2'],
                                                //         paymentstatus:
                                                //             invoicetambahan[index]
                                                //                 ['paymentstatus'],
                                                //         noinvoice:
                                                //             invoicetambahan[index]
                                                //                 ['noinvoice'],
                                                //         nobukti:
                                                //             invoicetambahan[index]
                                                //                 ['nobukti'],
                                                //         trxid:
                                                //             invoicetambahan[index]
                                                //                 ['trxid'],
                                                //         tglbayar:
                                                //             invoicetambahan[index]
                                                //                 ['paymentdate'],
                                                //         tglexpired:
                                                //             invoicetambahan[index]
                                                //                 ['billexpired'],
                                                //         billno:
                                                //             invoicetambahan[index]
                                                //                 ['billno'],
                                                //         norekap:
                                                //             invoicetambahan[index]
                                                //                 ['norekap'],
                                                //         paymentcode:
                                                //             invoicetambahan[index]
                                                //                 ['paymentcode'],
                                                //         merchant_id:
                                                //             widget.merchant_id,
                                                //         merchant_password: widget
                                                //             .merchant_password,
                                                //       ),
                                                //     ),
                                                //   );
                                                //   // if (data_invoice != null) {
                                                //   //   _showDialog(
                                                //   //       context,
                                                //   //       SimpleFontelicoProgressDialogType
                                                //   //           .normal,
                                                //   //       'Normal');
                                                //   //   print(jsonDecode(jsonEncode(
                                                //   //           data_invoice))[
                                                //   //       'data_invoiceTambahan']);
                                                //   //   print(invoicetambahan);
                                                //   //   print(invoicetambahanLength);
                                                //   //   setState(() {
                                                //   //     invoicetambahan.clear();
                                                //   //     for (var i = 0;
                                                //   //         i < invoicetambahanLength;
                                                //   //         i++) {
                                                //   //       invoicetambahan.add(jsonDecode(
                                                //   //               jsonEncode(
                                                //   //                   data_invoice))[
                                                //   //           'data_invoiceTambahan'][i]);
                                                //   //     }
                                                //   //     // invoicetambahan[0];
                                                //   //   });
                                                //   //   print(invoicetambahan);
                                                //   //   _dialog.hide();
                                                //   // }
                                                // }
                                              },
                                              child: Column(
                                                children: [
                                                  const Divider(
                                                    color: Color(0xFFD6D6D6),
                                                    thickness: 1,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text("No. Invoice"),
                                                      Text(
                                                          "${invoicetambahan![index]["noinvoice"]}"),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 5.0),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 15.0),
                                                        child: Text(
                                                            "${invoicetambahan![index]["keterangan"]}"),
                                                      ),
                                                      Text(NumberFormat
                                                              .currency(
                                                                  locale: 'id',
                                                                  symbol:
                                                                      'Rp. ',
                                                                  decimalDigits:
                                                                      00)
                                                          .format(double.tryParse(
                                                              invoicetambahan![
                                                                      index][
                                                                  "nominal"]))),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 5.0),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 15.0),
                                                        child: Text(
                                                            "Tanggal Bayar"),
                                                      ),
                                                      Text(
                                                        tglbayar != "01-01-1900"
                                                            ? DateFormat(
                                                                    "dd-MM-yyyy")
                                                                .format(DateFormat(
                                                                        "yyyy-MM-dd HH:mm:ss")
                                                                    .parse(invoicetambahan![
                                                                            index]
                                                                        [
                                                                        "paymentdate"]))
                                                            : "",
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 5.0),
                                                  if (tglbayar !=
                                                      "01-01-1900") ...[
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          height: 28,
                                                          child: ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              textStyle:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              backgroundColor:
                                                                  const Color(
                                                                      0xFFD9D9D9),
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              // Future.delayed(
                                                              //     const Duration(
                                                              //         seconds: 0),
                                                              //     (() async {
                                                              //   if (invoicetambahan[
                                                              //               index][
                                                              //           "lampiraninvoice"] ==
                                                              //       "") {
                                                              //     globals.alert(
                                                              //         context,
                                                              //         'Invoice Belum Terbit');
                                                              //   } else {
                                                              //     var url = 'https://web.transporindo.com/api-orderemkl/public/api/pesanan/bukti_pdfInvoiceTambahan/' +
                                                              //         invoicetambahan[
                                                              //                 index]
                                                              //             [
                                                              //             "lampiraninvoice"];
                                                              //     final file =
                                                              //         await PdfApi()
                                                              //             .loadNetworkFile(
                                                              //                 url);
                                                              //     openPdf(context,
                                                              //         file);
                                                              //   }
                                                              // }));
                                                            },
                                                            child: const Text(
                                                              "Lihat Invoice",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      'Nunito-Medium'),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 28,
                                                          child: ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              textStyle:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              backgroundColor:
                                                                  const Color(
                                                                      0xFFD9D9D9),
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              // _showDialog(
                                                              //     context,
                                                              //     SimpleFontelicoProgressDialogType
                                                              //         .normal,
                                                              //     'Normal');
                                                              // payment = await getPembayaran(
                                                              //     invoicetambahan[
                                                              //             index][
                                                              //         "paymentcode"]);
                                                              // final date =
                                                              //     DateTime.now();
                                                              // final dueDate =
                                                              //     date.add(Duration(
                                                              //         days: 7));

                                                              // final invoice =
                                                              //     Invoice(
                                                              //   penerima: Penerima(
                                                              //     name:
                                                              //         widget.invoicetambahan[
                                                              //                 index]
                                                              //             [
                                                              //             'norekap'],
                                                              //     address: widget
                                                              //         .nobukti,
                                                              //   ),
                                                              //   info: InvoiceInfo(
                                                              //     date: DateFormat(
                                                              //             'dd MMM yyyy')
                                                              //         .format(DateFormat(
                                                              //                 'yyyy-MM-dd')
                                                              //             .parse(widget
                                                              //                     .invoicetambahan[index]
                                                              //                 [
                                                              //                 'tglinvoice'])),
                                                              //     payDate: DateFormat(
                                                              //             'dd MMM yyyy HH:mm:ss')
                                                              //         .format(DateFormat(
                                                              //                 'yyyy-MM-dd HH:mm:ss')
                                                              //             .parse(widget
                                                              //                     .invoicetambahan[index]
                                                              //                 [
                                                              //                 'paymentdate'])),
                                                              //     payment: payment,
                                                              //   ),
                                                              //   items: [
                                                              //     InvoiceItem(
                                                              //       pengirim:
                                                              //           '${widget.pengirim}\n${widget.alamat_asal}\n${widget.notelppengirim}',
                                                              //       penerima:
                                                              //           '${widget.penerima}\n${widget.alamat_tujuan}\n${widget.notelppenerima}',
                                                              //       uk_container: widget
                                                              //                   .invoicetambahan[
                                                              //               index][
                                                              //           'keterangan'],
                                                              //       total: NumberFormat.currency(
                                                              //               locale:
                                                              //                   'id',
                                                              //               symbol:
                                                              //                   'Rp. ',
                                                              //               decimalDigits:
                                                              //                   00)
                                                              //           .format(double.tryParse(widget
                                                              //               .invoicetambahan[
                                                              //                   index]
                                                              //                   [
                                                              //                   'nominal']
                                                              //               .toString())),
                                                              //     ),
                                                              //   ],
                                                              // );

                                                              // final pdfFile =
                                                              //     await PdfInvoiceTambahApi
                                                              //         .generate(
                                                              //             invoice);

                                                              // _dialog.hide();

                                                              // PdfApi.openFile(
                                                              //     pdfFile);
                                                            },
                                                            child: const Text(
                                                              "Lihat Bukti Bayar",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      'Nunito-Medium'),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ]
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                        const SizedBox(height: 15.0),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ExpansionTile(
                      title: const Text("Data Orderan"),
                      children: <Widget>[
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 13.0,
                                    backgroundColor: Color(0xFF8BC8F4),
                                    child: CircleAvatar(
                                      radius: 10.0,
                                      backgroundColor: Color(0xFF0A5B96),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 60.0,
                                    child: VerticalDivider(
                                      color: Color(0xFFAEAEAE),
                                      thickness: 1,
                                    ),
                                  ),
                                  Icon(
                                    Icons.flag,
                                    size: 30.0,
                                    color: Color(0xFF219C02),
                                  ),
                                  SizedBox(
                                    height: 105.0,
                                    child: VerticalDivider(
                                      color: Color(0xFFAEAEAE),
                                      thickness: 1,
                                    ),
                                  ),
                                  CircleAvatar(
                                    radius: 13.0,
                                    backgroundColor: Color(0xFF8BC8F4),
                                    child: CircleAvatar(
                                      radius: 10.0,
                                      backgroundColor: Color(0xFF0A5B96),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Data Muat",
                                        style: TextStyle(fontSize: 17.0),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Table(
                                          defaultColumnWidth:
                                              const FixedColumnWidth(120.0),
                                          border: null,
                                          children: [
                                            TableRow(children: [
                                              const Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Nama Pengirim')
                                                  ]),
                                              Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      pengirim!,
                                                      style: const TextStyle(
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ]),
                                            ]),
                                            TableRow(children: [
                                              const Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('No. Telepon'),
                                                  ]),
                                              Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      notelppengirim!,
                                                      style: const TextStyle(
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ]),
                                            ]),
                                            TableRow(children: [
                                              const Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Note Pengirim')
                                                  ]),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    note_pengirim!,
                                                    style: const TextStyle(
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ]),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 15.0),
                                      SizedBox(
                                        height: 28,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            textStyle: const TextStyle(
                                              color: Colors.white,
                                            ),
                                            backgroundColor:
                                                const Color(0xFFD9D9D9),
                                          ),
                                          onPressed: () {
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) => MapAsal(
                                            //               origincontroller:
                                            //                   '${widget.latitude_pelabuhan_asal},${widget.longitude_pelabuhan_asal}',
                                            //               destinationcontroller:
                                            //                   '${widget.latitude_muat},${widget.longitude_muat}',
                                            //             )));
                                          },
                                          child: const Text(
                                            "Tampilkan Peta Lokasi Muat",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Data Bongkar",
                                        style: TextStyle(fontSize: 17.0),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Table(
                                          defaultColumnWidth:
                                              const FixedColumnWidth(120.0),
                                          border: null,
                                          children: [
                                            TableRow(children: [
                                              const Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Nama Penerima')
                                                  ]),
                                              Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      penerima!,
                                                      style: const TextStyle(
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ]),
                                            ]),
                                            TableRow(children: [
                                              const Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('No. Telepon'),
                                                  ]),
                                              Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      notelppenerima!,
                                                      style: const TextStyle(
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ]),
                                            ]),
                                            TableRow(children: [
                                              const Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Note Penerima')
                                                  ]),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    note_penerima!,
                                                    style: const TextStyle(
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ]),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      SizedBox(
                                        height: 28,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            textStyle: const TextStyle(
                                              color: Colors.white,
                                            ),
                                            backgroundColor:
                                                const Color(0xFFD9D9D9),
                                          ),
                                          onPressed: () {
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) => MapAsal(
                                            //               origincontroller:
                                            //                   '${widget.latitude_pelabuhan_tujuan},${widget.longitude_pelabuhan_tujuan}',
                                            //               destinationcontroller:
                                            //                   '${widget.latitude_bongkar},${widget.longitude_bongkar}',
                                            //             )));
                                          },
                                          child: const Text(
                                            "Tampilkan Peta Lokasi Bongkar",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(3.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    "Tanggal Order",
                                    style: TextStyle(fontSize: 14.0),
                                  ),
                                  Text(
                                    order_date!,
                                    style: const TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(3.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    payment_status == 2
                                        ? "Tanggal Bayar"
                                        : "Tanggal Batal",
                                    style: const TextStyle(fontSize: 14.0),
                                  ),
                                  Text(
                                    payment_date!,
                                    style: const TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(3.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    "Pembayaran",
                                    style: TextStyle(fontSize: 14.0),
                                  ),
                                  Text(
                                    payment_code!,
                                    style: const TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

// class _IndicatorExample extends StatelessWidget {
//   const _IndicatorExample({Key key, this.color}) : super(key: key);

//   final Color color;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         border: Border.fromBorderSide(
//           BorderSide(
//             color: Colors.green,
//             width: 4,
//           ),
//         ),
//       ),
//       child: Center(
//         child: Container(
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: color,
//           ),
//         ),
//       ),
//     );
//   }
// }
