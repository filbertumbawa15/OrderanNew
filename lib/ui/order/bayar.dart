import 'dart:async';
// import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasorderan/bloc/pesanan/pesanan/bayar/bayar_cubit.dart';
import 'package:tasorderan/components/components.dart';
import 'package:tasorderan/core/api_client.dart';
// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
// import 'package:material_dialogs/material_dialogs.dart';
// import 'package:material_dialogs/widgets/buttons/icon_button.dart';
// import 'package:now_ui_flutter/models/dart_models.dart';
// import 'package:now_ui_flutter/providers/services.dart';
// import 'package:now_ui_flutter/screens/home.dart';
// import 'package:now_ui_flutter/screens/payment_success.dart';
// import 'package:http/http.dart' as http;
// import 'package:now_ui_flutter/globals.dart' as globals;
// import 'package:now_ui_flutter/screens/success_pay.dart';
// import 'package:provider/provider.dart';
// import 'package:pusher_client/pusher_client.dart';
// import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class Bayar extends StatefulWidget {
  const Bayar({
    Key? key,
  }) : super(key: key);
  @override
  State<Bayar> createState() => _BayarState();
}

class _BayarState extends State<Bayar> {
  Timer? myTimer;
  // ValueNotifier<Duration>? myDuration;
  int? time;
  // String payment;

  String? harga_bayar;
  String? noVA;
  String? payment_name;
  String? waktu_bayar;
  String? bill_no;
  String? endDate;
  String? link;
  String? lokasiMuat;
  String? lokasiBongkar;
  String? nobukti;

  BayarCubit cubit = BayarCubit();
  final apiClient = ApiClient();
  final components = Tools();

  @override
  void initState() {
    super.initState();
    // myDuration = ValueNotifier<Duration>(const Duration(seconds: 0));
    // _initCheckStatus();
    // print(widget.nobukti);
  }

  // void stopTimer() {
  //   setState(() => myTimer!.cancel());
  // }

  // void startTimer() {
  //   DateTime startDate = DateTime.parse(waktu_bayar!);
  //   DateTime endsDate = DateTime.parse(endDate!);
  //   final time = startDate.difference(endsDate).inSeconds;
  //   setState(() {
  //     myDuration = Duration(seconds: time);
  //   });

  //   // timer = Timer.periodic(
  //   //     Duration(seconds: 20), (Timer t) => checkStatusPayment());
  //   myTimer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  // }

  // void addTime() {
  //   const addSeconds = -1;
  //   setState(() {
  //     final seconds = myDuration.inSeconds + addSeconds;
  //     if (seconds < 0) {
  //       // setState(() {
  //       //   ListPesanan();
  //       // });
  //       myTimer!.cancel();
  //     } else {
  //       myDuration = Duration(seconds: seconds);
  //       // checkStatusPayment();
  //     }
  //   });
  // }

  // void _initCheckStatus() async {
  //   globals.channel.bind(
  //     'App\\Events\\CheckStatusOrder',
  //     (PusherEvent event) async {
  //       checkStatusPay();
  //     },
  //   );
  // }

  // Future<DonePayment> updateStatusPembayaran() async {
  //   var data = {
  //     "trx_id": widget.noVA,
  //     "payment_status": 2,
  //     "payment_date": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
  //   };
  //   final url = '${globals.url}/api-orderemkl/public/api/pesanan/update';

  //   final response = await http.post(Uri.parse(url), headers: {
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer ${globals.accessToken}',
  //   }, body: {
  //     'data': jsonEncode(data)
  //   });
  //   final result = jsonDecode(response.body);
  //   if (response.statusCode == 200) {
  //     print(DonePayment.fromJson(result['data']));
  //     return DonePayment.fromJson(result['data']);
  //   } else {
  //     throw Exception();
  //   }
  // }

  // void getPembayaran(String payment_code) async {
  //   try {
  //     print(payment_code);
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
  //     payment = payment_name[0]['pg_name'];
  //     // pg_data.map((title) {
  //     //   if (title['pg_code'] == widget.payment_code) {
  //     //     print('berhasil');
  //     //   } else {
  //     //     print("ngga ada");
  //     //   }
  //     // });
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  // void checkStatusPayment() async {
  //   try {
  //     var data_pembayaran = {
  //       'noVA': widget.noVA,
  //       'bill_no': widget.bill_no,
  //       "merchantid": globals.merchantid,
  //       "merchantpassword": globals.merchantpassword,
  //     };
  //     final response = await http.post(
  //         Uri.parse('${globals.url}/faspay/status.php'),
  //         body: {'data_pembayaran': json.encode(data_pembayaran)});
  //     var hasil = json.decode(response.body);
  //     if (hasil['payment_status_code'] == '2') {
  //       var tmp = await updateStatusPembayaran();
  //       myTimer.cancel();
  //       _showDialog(
  //           context, SimpleFontelicoProgressDialogType.normal, 'Normal');
  //       await getPembayaran(tmp.payment_code);
  //       await Future.delayed(const Duration(seconds: 3), () {
  //         _dialog.hide();
  //         Navigator.pushAndRemoveUntil(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) => SuccessPay(
  //                       harga_bayar: tmp.harga,
  //                       noVA: tmp.trx_id,
  //                       nobukti: tmp.nobukti,
  //                       payment_status: tmp.payment_status,
  //                       alamat_asal: tmp.alamat_asal,
  //                       alamat_tujuan: tmp.alamat_tujuan,
  //                       order_date: tmp.order_date,
  //                       payment_date: tmp.payment_date,
  //                       payment_code: payment,
  //                       link: 'Orderan',
  //                       latitude_pelabuhan_asal: tmp.latitude_pelabuhan_asal,
  //                       longitude_pelabuhan_asal: tmp.longitude_pelabuhan_asal,
  //                       latitude_pelabuhan_tujuan:
  //                           tmp.latitude_pelabuhan_tujuan,
  //                       longitude_pelabuhan_tujuan:
  //                           tmp.longitude_pelabuhan_tujuan,
  //                       latitude_muat: tmp.latitude_muat,
  //                       longitude_muat: tmp.longitude_muat,
  //                       latitude_bongkar: tmp.latitude_bongkar,
  //                       longitude_bongkar: tmp.longitude_bongkar,
  //                       notelppengirim: tmp.notelppengirim,
  //                       pengirim: tmp.pengirim,
  //                       penerima: tmp.penerima,
  //                       notelppenerima: tmp.notelppenerima,
  //                       buktipdf: tmp.buktipdf,
  //                       note_pengirim: tmp.notepengirim,
  //                       note_penerima: tmp.notepenerima,
  //                     )),
  //             (route) => false);
  //       });
  //     } else {
  //       print(hasil['payment_status_desc']);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // void checkStatusPay() async {
  //   await Provider.of<MasterProvider>(context, listen: false)
  //       .listPesananRow(widget.nobukti)
  //       .then((value) async {
  //     if (value.payment_status == "2") {
  //       var tmp = await updateStatusPembayaran();
  //       myTimer.cancel();
  //       _showDialog(
  //           context, SimpleFontelicoProgressDialogType.normal, 'Normal');
  //       await getPembayaran(tmp.payment_code);
  //       await Future.delayed(const Duration(seconds: 2), () {
  //         _dialog.hide();
  //         Navigator.pushAndRemoveUntil(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) => SuccessPay(
  //                       harga_bayar: tmp.harga,
  //                       noVA: tmp.trx_id,
  //                       nobukti: tmp.nobukti,
  //                       payment_status: tmp.payment_status,
  //                       alamat_asal: tmp.alamat_asal,
  //                       alamat_tujuan: tmp.alamat_tujuan,
  //                       order_date: tmp.order_date,
  //                       payment_date: tmp.payment_date,
  //                       payment_code: payment,
  //                       link: 'Orderan',
  //                       latitude_pelabuhan_asal: tmp.latitude_pelabuhan_asal,
  //                       longitude_pelabuhan_asal: tmp.longitude_pelabuhan_asal,
  //                       latitude_pelabuhan_tujuan:
  //                           tmp.latitude_pelabuhan_tujuan,
  //                       longitude_pelabuhan_tujuan:
  //                           tmp.longitude_pelabuhan_tujuan,
  //                       latitude_muat: tmp.latitude_muat,
  //                       longitude_muat: tmp.longitude_muat,
  //                       latitude_bongkar: tmp.latitude_bongkar,
  //                       longitude_bongkar: tmp.longitude_bongkar,
  //                       notelppengirim: tmp.notelppengirim,
  //                       pengirim: tmp.pengirim,
  //                       penerima: tmp.penerima,
  //                       notelppenerima: tmp.notelppenerima,
  //                       buktipdf: tmp.buktipdf,
  //                       note_pengirim: tmp.notepengirim,
  //                       note_penerima: tmp.notepenerima,
  //                     )),
  //             (route) => false);
  //       });
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      final orderbayar = args['listOrderBayar'];
      harga_bayar = orderbayar.harga;
      noVA = orderbayar.noVA;
      payment_name = orderbayar.payment_name;
      waktu_bayar = orderbayar.waktu_bayar;
      bill_no = orderbayar.bill_no;
      endDate = orderbayar.endDate;
      link = args['param'];
      lokasiMuat = orderbayar.lokasiMuat;
      lokasiBongkar = orderbayar.lokasiBongkar;
      nobukti = orderbayar.nobukti;
      DateTime startDate = DateTime.parse(waktu_bayar!);
      DateTime endsDate = DateTime.parse(endDate!);
      time = startDate.difference(endsDate).inSeconds;
      cubit.startTimer(time!);
    }
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BayarCubit(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Color(0xFFB7B7B7),
              )),
          title: const Text(
            "Bayar",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              fontFamily: 'Nunito-Medium',
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        backgroundColor: const Color(0xFFF1F1EF),
        body: BlocConsumer<BayarCubit, BayarState>(
          listener: (context, state) {
            if (state is BayarComplete) {
              Future.delayed(const Duration(seconds: 0), () {
                components.dia!.hide();
                Navigator.pushNamed(context, '/success_pay');
              });
            }
          },
          builder: (context, state) {
            if (state is BayarLoading) {
              Future.delayed(const Duration(seconds: 0), () {
                components.showDia();
              });
            } else if (state is BayarFailed) {
              print("Gagalkan ke success pay, cek gagalnya apaan");
            }
            return ListView(
              children: [
                tracking(),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 15.0),
                  child: Container(
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
                                    // Wrap this column inside an expanded widget so that framework allocates max width for this column inside this row
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
                                                //     '////${widget.latitude_pelabuhan_asal},${widget.longitude_pelabuhan_asal}',
                                                //     widget.origincontroller);
                                                // setState(() {
                                                //   distance = widget.jarakasal;
                                                //   duration = widget.waktuasal;
                                                // });
                                              },
                                              // Then wrap your text widget with expanded
                                              child: Text(
                                                lokasiMuat!,
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
                                    // Wrap this column inside an expanded widget so that framework allocates max width for this column inside this row
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
                                              // Then wrap your text widget with expanded
                                              child: Text(
                                                lokasiBongkar!,
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
                                    // Wrap this column inside an expanded widget so that framework allocates max width for this column inside this row
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Text(
                                      'Pembayaran',
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
                                              // Then wrap your text widget with expanded
                                              child: Text(
                                                payment_name!,
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
                                    // Wrap this column inside an expanded widget so that framework allocates max width for this column inside this row
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Text(
                                      'No. Virtual Account',
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
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: noVA,
                                                style: const TextStyle(
                                                  fontFamily: 'Nunito-Medium',
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              WidgetSpan(
                                                child: InkWell(
                                                  onTap: () async {
                                                    // await Clipboard.setData(
                                                    //     ClipboardData(
                                                    //         text: widget.noVA));
                                                    // Fluttertoast.showToast(
                                                    //     msg:
                                                    //         "No. Virtual Acount sudah di copy ke clipboard",
                                                    //     toastLength:
                                                    //         Toast.LENGTH_SHORT,
                                                    //     gravity: ToastGravity.BOTTOM,
                                                    //     timeInSecForIosWeb: 1,
                                                    //     textColor: Colors.white,
                                                    //     fontSize: 16.0);
                                                  },
                                                  child: const Icon(
                                                      Icons.content_copy,
                                                      size: 18),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 15.0),
                        Column(
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                const SizedBox(width: 0.0),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    const Text(
                                      'Total Harga',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Color(0xFF666666),
                                        fontFamily: 'Nunito-Medium',
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                              // Then wrap your text widget with expanded
                                              child: Text(
                                                // "asdf",
                                                NumberFormat.currency(
                                                        locale: 'id',
                                                        symbol: 'Rp.',
                                                        decimalDigits: 00)
                                                    .format(double.tryParse(
                                                        harga_bayar
                                                            .toString())),
                                                style: const TextStyle(
                                                  fontSize: 18.0,
                                                  fontFamily: 'Nunito-Medium',
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                                softWrap: true,
                                              )),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 7.0),
                                    const Text(
                                      'Harga belum terhitung biaya tambahan',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Color(0xFF666666),
                                        fontFamily: 'Nunito-Medium',
                                      ),
                                    ),
                                  ],
                                )),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        const Divider(
                          thickness: 5,
                          color: Color(0xFFE6E6E6),
                        ),
                        const Text(
                          "Waktu Pembayaran",
                          style: TextStyle(
                              fontSize: 16.0, color: Color(0xFF666666)),
                        ),
                        BlocBuilder<BayarCubit, BayarState>(
                            builder: (context, state) {
                          if (state is BayarInitial) {
                            apiClient.channel!.bind(
                                "App\\Events\\CheckStatusOrder", (event) async {
                              BlocProvider.of<BayarCubit>(context)
                                  .cekPayment(nobukti!);
                            });
                            BlocProvider.of<BayarCubit>(context)
                                .startTimer(time!);
                            return const Padding(
                              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (state is BayarInProgress) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                          "${state.elapsed!.inHours.toString().padLeft(2, '0')}:",
                                          style: const TextStyle(
                                              fontFamily: "Oxanium-Reguler",
                                              color: Colors.black,
                                              fontSize: 40)),
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                          "${state.elapsed!.inMinutes.remainder(60).toString().padLeft(2, '0')}:",
                                          style: const TextStyle(
                                              fontFamily: "Oxanium-Reguler",
                                              color: Colors.black,
                                              fontSize: 40)),
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                          state.elapsed!.inSeconds
                                              .remainder(60)
                                              .toString()
                                              .padLeft(2, '0'),
                                          style: const TextStyle(
                                              fontFamily: "Oxanium-Reguler",
                                              color: Colors.black,
                                              fontSize: 40)),
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              ],
                            );
                          }
                          return Container();
                        }),
                        const Text(
                          "NB: Nomor VA akan hangus setelah waktu pembayaran telah dilewati, maka lakukan pembayaran dan anda dapat mengecek status pesanan anda.",
                          style: TextStyle(
                            fontSize: 13.0,
                            fontFamily: "Nunito-Medium",
                            color: Color(0xFF666666),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
              ],
            );
          },
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // setState(() {
                    //   myTimer.cancel();
                    // });
                    link == "ListPesanan"
                        ? Navigator.pop(context)
                        : Navigator.pushNamedAndRemoveUntil(
                            context, '/home', (route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5599E9),
                  ),
                  icon: link == "ListPesanan"
                      ? const Icon(Icons.list)
                      : const Icon(Icons.home),
                  label: link == "ListPesanan"
                      ? const Text(
                          "Kembali Ke List Pesanan",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Nunito-Medium',
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : const Text(
                          "Kembali Ke Home",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Nunito-Medium',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // showDialog(
                    //   context: context,
                    //   builder: (BuildContext context) {
                    //     // return object of type Dialog
                    //     return AlertDialog(
                    //       title: new Text(
                    //         "Apakah anda yakin?",
                    //         style: TextStyle(
                    //             fontFamily: 'Nunito-Medium',
                    //             fontWeight: FontWeight.bold),
                    //       ),
                    //       content: new Text(
                    //         "Jika anda melakukan pembatalan, semua data yang anda kirim akan dibatalkan",
                    //         style: TextStyle(fontFamily: 'Nunito-Medium'),
                    //       ),
                    //       actions: <Widget>[
                    //         new TextButton(
                    //           child: new Text(
                    //             "BATALKAN",
                    //             style: TextStyle(
                    //               fontFamily: 'Nunito-ExtraBold',
                    //             ),
                    //           ),
                    //           onPressed: () async {
                    //             setState(() {
                    //               myTimer.cancel();
                    //             });
                    //             _showDialog(
                    //                 context,
                    //                 SimpleFontelicoProgressDialogType.normal,
                    //                 'Normal');
                    //             final url =
                    //                 '${globals.url}/api-orderemkl/public/api/pesanan/batalTransaksi';
                    //             var data = {
                    //               "trx_id": widget.noVA,
                    //               "paymentdate": DateFormat('yyyy-MM-dd HH:mm:ss')
                    //                   .format(DateTime.now()),
                    //             };
                    //             final response = await http.post(
                    //               Uri.parse(url),
                    //               headers: {
                    //                 'Accept': 'application/json',
                    //                 'Authorization':
                    //                     'Bearer ${globals.accessToken}',
                    //               },
                    //               body: {'data': json.encode(data)},
                    //             );
                    //             if (response.statusCode == 200) {
                    //               Future.delayed(const Duration(seconds: 2),
                    //                   () async {
                    //                 await _dialog.hide();
                    //                 Dialogs.materialDialog(
                    //                     color: Colors.white,
                    //                     msg:
                    //                         "Orderan berhasil dibatalkan, cek list pesanan anda untuk melihat status pesanan tersebut",
                    //                     title: 'Pembatalan Orderan Berhasil',
                    //                     lottieBuilder: Lottie.asset(
                    //                       'assets/imgs/cancel-order.json',
                    //                       fit: BoxFit.contain,
                    //                     ),
                    //                     context: context,
                    //                     actions: [
                    //                       IconsButton(
                    //                         onPressed: () async {
                    //                           Navigator.pushAndRemoveUntil(
                    //                               context,
                    //                               MaterialPageRoute(
                    //                                   builder: ((context) =>
                    //                                       Home())),
                    //                               (route) => false);
                    //                         },
                    //                         text: 'Ok',
                    //                         iconData: Icons.done,
                    //                         color: Colors.blue,
                    //                         textStyle: TextStyle(
                    //                           color: Colors.white,
                    //                           fontFamily: 'Nunito-ExtraBold',
                    //                         ),
                    //                         iconColor: Colors.white,
                    //                       ),
                    //                     ]);
                    //               });
                    //             } else {
                    //               await _dialog.hide();
                    //               globals.alert(context, 'Gagal');
                    //               throw Exception();
                    //             }
                    //           },
                    //         ),
                    //         // usually buttons at the bottom of the dialog
                    //         new TextButton(
                    //           child: new Text(
                    //             "TIDAK",
                    //             style: TextStyle(
                    //               fontFamily: 'Nunito-ExtraBold',
                    //             ),
                    //           ),
                    //           onPressed: () {
                    //             Navigator.of(context).pop();
                    //           },
                    //         ),
                    //       ],
                    //     );
                    //   },
                    // );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE95555),
                  ),
                  icon: const Icon(Icons.close),
                  label: const Text(
                    "Batalkan Pesanan",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Nunito-Medium',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tracking() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20.0),
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                '1',
                style: TextStyle(
                  color: Color(0xFFA5A5A5),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Text("Pesan", style: TextStyle(fontSize: 14.0)),
          ],
        ),
        Container(
          width: 5.0,
        ),
        Container(
          color: const Color(0xFFC2C2C2),
          height: 1.0,
          width: 70.0,
        ),
        Container(
          width: 5.0,
        ),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20.0),
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                '2',
                style: TextStyle(
                  color: Color(0xFFA5A5A5),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Text("Total", style: TextStyle(fontSize: 14.0)),
          ],
        ),
        Container(
          width: 5.0,
        ),
        Container(
          color: const Color(0xFFC2C2C2),
          height: 1.0,
          width: 70.0,
        ),
        Container(
          width: 5.0,
        ),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20.0),
            CircleAvatar(
              backgroundColor: Color(0xFF5599E9),
              child: Text(
                '3',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Text("Bayar", style: TextStyle(fontSize: 14.0)),
          ],
        ),
      ],
    );
  }

  Widget displayTimer(Duration elapsed) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final hours = strDigits(elapsed.inHours);
    final minutes = strDigits(elapsed.inMinutes.remainder(60));
    final seconds = strDigits(elapsed.inSeconds.remainder(60));
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      displayTimerUI(time: '$hours:'),
      const SizedBox(
        width: 8,
      ),
      displayTimerUI(time: '$minutes:'),
      const SizedBox(
        width: 8,
      ),
      displayTimerUI(time: seconds),
    ]);
  }

  Widget displayTimerUI({@required String? time}) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: Text(time!,
                style: const TextStyle(
                    fontFamily: "Oxanium-Reguler",
                    color: Colors.black,
                    fontSize: 40)),
          ),
          const SizedBox(height: 20),
        ],
      );
}
