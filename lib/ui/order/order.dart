import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
// import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:now_ui_flutter/globals.dart' as globals;
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:tasorderan/components/components.dart';
import 'package:tasorderan/models/pesanan_models.dart';

class Order extends StatefulWidget {
  //Asal
  // final String placeidasal;
  // final String latitude_place_asal;
  // final String longitude_place_asal;
  // final String pelabuhanidasal;
  // final String latitude_pelabuhan_asal;
  // final String longitude_pelabuhan_asal;
  // final String jarak_asal;
  // final String waktu_asal;
  // final String alamatasal;
  // final String pengirim;
  // final String notelppengirim;
  // final String notepengirim;
  // final String namapelabuhanmuat;
  // //Tujuan
  // final String placeidtujuan;
  // final String latitude_place_tujuan;
  // final String longitude_place_tujuan;
  // final String pelabuhanidtujuan;
  // final String latitude_pelabuhan_tujuan;
  // final String longitude_pelabuhan_tujuan;
  // final String jarak_tujuan;
  // final String waktu_tujuan;
  // final String alamattujuan;
  // final String penerima;
  // final String notelppenerima;
  // final String notepenerima;
  // final String namapelabuhanbongkar;
  // final String container_id;
  // final String nilaibarang;
  // final String qty;
  // final String jenisbarang;
  // final String namabarang;
  // final String keterangantambahan;
  //

  const Order({
    Key? key,
    // this.placeidasal,
    // this.pelabuhanidasal,
    // this.latitude_pelabuhan_asal,
    // this.longitude_pelabuhan_asal,
    // this.notelppengirim,
    // this.placeidtujuan,
    // this.pelabuhanidtujuan,
    // this.latitude_pelabuhan_tujuan,
    // this.longitude_pelabuhan_tujuan,
    // this.notelppenerima,
    // this.container_id,
    // this.nilaibarang,
    // this.qty,
    // this.jenisbarang,
    // this.namabarang,
    // this.keterangantambahan,
    // this.latitude_place_asal,
    // this.longitude_place_asal,
    // this.jarak_asal,
    // this.waktu_asal,
    // this.alamatasal,
    // this.pengirim,
    // this.latitude_place_tujuan,
    // this.longitude_place_tujuan,
    // this.jarak_tujuan,
    // this.waktu_tujuan,
    // this.alamattujuan,
    // this.penerima,
    // this.notepengirim,
    // this.namapelabuhanmuat,
    // this.notepenerima,
    // this.namapelabuhanbongkar,
  }) : super(key: key);
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  var size, height, width;
  // SimpleFontelicoProgressDialog _dialog;
  //Data Asal
  var _selectedprovinsiasal;
  var _selectedkotaasal;
  var _selectedkecamatanasal;
  var _selectedkelurahanasal;

  var _placeidasal;
  var _latitude_place_asal;
  var _longitude_place_asal;
  var _pelabuhanidasal;
  var _latitude_pelabuhan_asal;
  var _longitude_pelabuhan_asal;
  var _jarak_asal;
  var _waktu_asal;
  TextEditingController _alamatasal = new TextEditingController();
  var notepengirim;
  var namapelabuhanpengirim;

  var provinsiasal;
  var kotaasal;
  var kecamatanasal;
  var kelurahanasal;
  var pengirim;
  var notelppengirim;
  //Data Asal

  //Data Tujuan
  var _selectedprovinsitujuan;
  var _selectedkotatujuan;
  var _selectedkecamatantujuan;
  var _selectedkelurahantujuan;

  var _placeidtujuan;
  var _latitude_place_tujuan;
  var _longitude_place_tujuan;
  var _pelabuhanidtujuan;
  var _latitude_pelabuhan_tujuan;
  var _longitude_pelabuhan_tujuan;
  var _jarak_tujuan;
  var _waktu_tujuan;
  TextEditingController _alamattujuan = new TextEditingController();
  var notepenerima;
  var namapelabuhanpenerima;

  var provinsitujuan;
  var kotatujuan;
  var kecamatantujuan;
  var kelurahantujuan;
  var penerima;
  var notelppenerima;
  //Data Tujuan

  double _scaleFactor = 1.0;
  double _baseScaleFactor = 1.0;
  // List<String> _datacontainer = List();
  // List<String> _datapelayaran = List();
  TextEditingController _datatujuan = new TextEditingController();
  //Lain-lain
  // int _container_id;
  // String _selectedpelayaran;
  TextEditingController _selectedqty = new TextEditingController(text: '1');
  TextEditingController _selectednilaibarang = new TextEditingController();
  TextEditingController _selectedketerangantambahan =
      new TextEditingController();
  TextEditingController _selectednamabarang = new TextEditingController();
  TextEditingController _selectedjenisbarang = new TextEditingController();
  //Lain-lain
  // MoneyMaskedTextController _selectednilaibarang =
  //     new MoneyMaskedTextController(thousandSeparator: ',');
  // List<String> datatujuan;

  // MasterContainer _selectedcontainer;

  // bool _isButtonDisabled;

  // void getPelayaran() async {
  //   final response = await http
  //       .get(Uri.parse('${globals.url}/api-order/order/getpelayaranlist'));

  //   var pelayaran = json.decode(response.body);
  //   pelayaran['data']
  //       .forEach((value) => _datapelayaran.add(value['fnpelayaran']));
  // }

//   void updateDataAsal(Object information_asal) async {
//     setState(
//       () {
//         _placeidasal =
//             jsonDecode(jsonEncode(information_asal))['_placeidasal'].toString();
//         _latitude_place_asal =
//             jsonDecode(jsonEncode(information_asal))['_latitude_place_asal']
//                 .toString();
//         _longitude_place_asal =
//             jsonDecode(jsonEncode(information_asal))['_longitude_place_asal']
//                 .toString();
//         _pelabuhanidasal =
//             jsonDecode(jsonEncode(information_asal))['_pelabuhanidasal']
//                 .toString();
//         _latitude_pelabuhan_asal =
//             jsonDecode(jsonEncode(information_asal))['_latitude_pelabuhan_asal']
//                 .toString();
//         _longitude_pelabuhan_asal = jsonDecode(
//                 jsonEncode(information_asal))['_longitude_pelabuhan_asal']
//             .toString();
//         _jarak_asal =
//             jsonDecode(jsonEncode(information_asal))['_jarak_asal'].toString();
//         _waktu_asal =
//             jsonDecode(jsonEncode(information_asal))['_waktu_asal'].toString();
//         _alamatasal.text =
//             jsonDecode(jsonEncode(information_asal))['_alamatasal'].toString();
//         pengirim =
//             jsonDecode(jsonEncode(information_asal))['pengirim'].toString();
//         notelppengirim =
//             jsonDecode(jsonEncode(information_asal))['notelppengirim']
//                 .toString();
//         notepengirim =
//             jsonDecode(jsonEncode(information_asal))['notepengirim'].toString();
//         namapelabuhanpengirim =
//             jsonDecode(jsonEncode(information_asal))['namapelabuhanpengirim']
//                 .toString();
// //

//         _selectedprovinsiasal =
//             jsonDecode(jsonEncode(information_asal))['_selectedprovinsiasal']
//                 .toString();
//         _selectedkotaasal =
//             jsonDecode(jsonEncode(information_asal))['_selectedkotaasal']
//                 .toString();
//         _selectedkecamatanasal =
//             jsonDecode(jsonEncode(information_asal))['_selectedkecamatanasal']
//                 .toString();
//         _selectedkelurahanasal =
//             jsonDecode(jsonEncode(information_asal))['_selectedkelurahanasal']
//                 .toString();
//       },
//     );
//     if (_placeidasal != null &&
//         _placeidtujuan != null &&
//         _container_id != null &&
//         _selectednilaibarang.text.isNotEmpty &&
//         _selectedqty.text.isNotEmpty &&
//         _selectedjenisbarang.text.isNotEmpty &&
//         _selectednamabarang.text.isNotEmpty) {
//       setState(() {
//         _isButtonDisabled = false;
//       });
//     } else {
//       setState(() {
//         _isButtonDisabled = true;
//       });
//     }
//   }

//   void updateDataTujuan(Object information_tujuan) async {
//     setState(
//       () {
//         _placeidtujuan =
//             jsonDecode(jsonEncode(information_tujuan))['_placeidtujuan']
//                 .toString();
//         _latitude_place_tujuan =
//             jsonDecode(jsonEncode(information_tujuan))['_latitude_place_tujuan']
//                 .toString();
//         _longitude_place_tujuan = jsonDecode(
//                 jsonEncode(information_tujuan))['_longitude_place_tujuan']
//             .toString();
//         _pelabuhanidtujuan =
//             jsonDecode(jsonEncode(information_tujuan))['_pelabuhanidtujuan']
//                 .toString();
//         _latitude_pelabuhan_tujuan = jsonDecode(
//                 jsonEncode(information_tujuan))['_latitude_pelabuhan_tujuan']
//             .toString();
//         _longitude_pelabuhan_tujuan = jsonDecode(
//                 jsonEncode(information_tujuan))['_longitude_pelabuhan_tujuan']
//             .toString();
//         _jarak_tujuan =
//             jsonDecode(jsonEncode(information_tujuan))['_jarak_tujuan']
//                 .toString();
//         _waktu_tujuan =
//             jsonDecode(jsonEncode(information_tujuan))['_waktu_tujuan']
//                 .toString();
//         _alamattujuan.text =
//             jsonDecode(jsonEncode(information_tujuan))['_alamattujuan']
//                 .toString();
//         penerima =
//             jsonDecode(jsonEncode(information_tujuan))['penerima'].toString();
//         notelppenerima =
//             jsonDecode(jsonEncode(information_tujuan))['notelppenerima']
//                 .toString();
//         notepenerima =
//             jsonDecode(jsonEncode(information_tujuan))['notepenerima']
//                 .toString();
//         namapelabuhanpenerima =
//             jsonDecode(jsonEncode(information_tujuan))['namapelabuhanpenerima']
//                 .toString();
// //

//         _selectedprovinsitujuan = jsonDecode(
//                 jsonEncode(information_tujuan))['_selectedprovinsitujuan']
//             .toString();
//         _selectedkotatujuan =
//             jsonDecode(jsonEncode(information_tujuan))['_selectedkotatujuan']
//                 .toString();
//         _selectedkecamatantujuan = jsonDecode(
//                 jsonEncode(information_tujuan))['_selectedkecamatantujuan']
//             .toString();
//         _selectedkelurahantujuan = jsonDecode(
//                 jsonEncode(information_tujuan))['_selectedkelurahantujuan']
//             .toString();
//       },
//     );
//     if (_placeidasal != null &&
//         _placeidtujuan != null &&
//         _container_id != null &&
//         _selectednilaibarang.text.isNotEmpty &&
//         _selectedqty.text.isNotEmpty &&
//         _selectedjenisbarang.text.isNotEmpty &&
//         _selectednamabarang.text.isNotEmpty) {
//       setState(() {
//         _isButtonDisabled = false;
//       });
//     } else {
//       setState(() {
//         _isButtonDisabled = true;
//       });
//     }
//   }

  // void MoveAsal() async {
  //   // final information_asal = await Navigator.push(
  //   //   context,
  //   //   CupertinoPageRoute(fullscreenDialog: true, builder: (context) => Asal()),
  //   final information_asal = await Navigator.pushNamed(context, '/asal');
  //   if (information_asal != null) {
  //     updateDataAsal(information_asal);
  //   }
  // }

  // void EditAsal() async {
  //   final information_asal = await Navigator.push(
  //     context,
  //     CupertinoPageRoute(
  //         fullscreenDialog: true,
  //         builder: (context) => Asal(
  //               selectedplaceidasal: _placeidasal,
  //               selectedlatitudeplaceasal: _latitude_place_asal,
  //               selectedlongitudeplaceasal: _longitude_place_asal,
  //               selectedpelabuhanidasal: _pelabuhanidasal,
  //               selectedalamatasal: _alamatasal.text,
  //               selectedpengirim: pengirim,
  //               selectednotelppengirim: notelppengirim,
  //               selectednotepengirim: notepengirim,
  //               selectednamapelabuhanpengirim: namapelabuhanpengirim,
  //             )),
  //   );
  //   if (information_asal != null) {
  //     updateDataAsal(information_asal);
  //   }
  // }

  // void EditTujuan() async {
  //   final information_tujuan = await Navigator.push(
  //     context,
  //     CupertinoPageRoute(
  //         fullscreenDialog: true,
  //         builder: (context) => Tujuan(
  //               selectedplaceidtujuan: _placeidtujuan,
  //               selectedlatitudeplacetujuan: _latitude_place_tujuan,
  //               selectedlongitudeplacetujuan: _longitude_place_tujuan,
  //               selectedpelabuhanidtujuan: _pelabuhanidtujuan,
  //               selectedalamattujuan: _alamattujuan.text,
  //               selectedpenerima: penerima,
  //               selectednotelppenerima: notelppenerima,
  //               selectednotepenerima: notepenerima,
  //               selectednamapelabuhanpenerima: namapelabuhanpenerima,
  //             )),
  //   );
  //   if (information_tujuan != null) {
  //     updateDataTujuan(information_tujuan);
  //   }
  // }

  // void MoveTujuan() async {
  //   // final information_tujuan = await Navigator.push(
  //   //   context,
  //   //   CupertinoPageRoute(
  //   //       fullscreenDialog: true, builder: (context) => Tujuan()),
  //   final information_tujuan = await Navigator.pushNamed(context, '/tujuan');
  //   if (information_tujuan != null) {
  //     updateDataTujuan(information_tujuan);
  //   }
  // }

  // void ConfirmOrder(
  //   var _placeidasal,
  //   var _pelabuhanidasal,
  //   var _latitude_pelabuhan_asal,
  //   var _longitude_pelabuhan_asal,
  //   var _jarak_asal,
  //   var _waktu_asal,
  //   var _alamatasal,
  //   var pengirim,
  //   var notelppengirim,
  //   var _placeidtujuan,
  //   var _pelabuhanidtujuan,
  //   var _latitude_pelabuhan_tujuan,
  //   var _longitude_pelabuhan_tujuan,
  //   var _jarak_tujuan,
  //   var _waktu_tujuan,
  //   var _alamattujuan,
  //   var penerima,
  //   var notelppenerima,
  //   int _container_id,
  //   String nilaibarang,
  //   String qty,
  //   String jenisbarang,
  //   String namabarang,
  //   String keterangantambahan,
  // ) async {
  //   final nilaibarang_asuransi =
  //       int.parse(nilaibarang.substring(4).replaceAll('.', '')).toString();
  //   var data = {
  //     "placeidasal": _placeidasal,
  //     "pelabuhanidasal": _pelabuhanidasal,
  //     "latitude_pelabuhan_asal": _latitude_pelabuhan_asal,
  //     "longitude_pelabuhan_asal": _longitude_pelabuhan_asal,
  //     "jarak_asal": _jarak_asal,
  //     "waktu_asal": _waktu_asal,
  //     "alamat_asal": _alamatasal,
  //     "pengirim": pengirim,
  //     "notelp_pengirim": notelppengirim,
  //     "placeidtujuan": _placeidtujuan,
  //     "pelabuhanidtujuan": _pelabuhanidtujuan,
  //     "latitude_pelabuhan_tujuan": _latitude_pelabuhan_tujuan,
  //     "longitude_pelabuhan_tujuan": _longitude_pelabuhan_tujuan,
  //     "jarak_tujuan": _jarak_tujuan,
  //     "waktu_tujuan": _waktu_tujuan,
  //     "alamat_tujuan": _alamattujuan,
  //     "penerima": penerima,
  //     "notelp_penerima": notelppenerima,
  //     "container_id": _container_id,
  //     "nilaibarang_asuransi": nilaibarang_asuransi,
  //     "qty": qty,
  //     "jenis_barang": jenisbarang,
  //     "nama_barang": namabarang,
  //     "keterangan_tambahan": keterangantambahan,
  //     "key": '${globals.apikey}',
  //   };
  //   print(jsonEncode(data));
  //   // _dialog.hide();
  //   var encode = jsonEncode(data);
  //   final response = await http.get(
  //       Uri.parse(
  //           '${globals.url}/api-orderemkl/public/api/pesanan/cekongkoskirim?data=$encode'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //         'Authorization': 'Bearer ${globals.accessToken}',
  //       });
  //   final harga = jsonDecode(response.body)['harga'];
  //   final harga_satuan = jsonDecode(response.body)['hargasatuan'];
  //   await Future.delayed(Duration(seconds: 2));
  //   _dialog.hide();
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => Total(
  //                 origincontroller: _alamatasal,
  //                 placeidasal: _placeidasal,
  //                 pelabuhanidasal: _pelabuhanidasal,
  //                 latitude_pelabuhan_asal: _latitude_pelabuhan_asal,
  //                 longitude_pelabuhan_asal: _longitude_pelabuhan_asal,
  //                 jarakasal: _jarak_asal,
  //                 waktuasal: _waktu_asal,
  //                 namapengirim: pengirim,
  //                 notelppengirim: notelppengirim,
  //                 notepengirim: notepengirim,
  //                 //
  //                 destinationcontroller: _alamattujuan,
  //                 placeidtujuan: _placeidtujuan,
  //                 pelabuhanidtujuan: _pelabuhanidtujuan,
  //                 latitude_pelabuhan_tujuan: _latitude_pelabuhan_tujuan,
  //                 longitude_pelabuhan_tujuan: _longitude_pelabuhan_tujuan,
  //                 jaraktujuan: _jarak_tujuan,
  //                 waktutujuan: _waktu_tujuan,
  //                 namapenerima: penerima,
  //                 notelppenerima: notelppenerima,
  //                 notepenerima: notepenerima,
  //                 //
  //                 container_id: _container_id,
  //                 nilaibarang: nilaibarang,
  //                 nilaibarang_asuransi: nilaibarang_asuransi,
  //                 qty: qty,
  //                 jenisbarang: jenisbarang,
  //                 namabarang: namabarang,
  //                 harga: harga,
  //                 keterangantambahan: keterangantambahan,
  //                 hargasatuan: harga_satuan,
  //               )));
  // }

  // String test = ;
  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  // Future<void> reOrder() async {
  //   setState(() {
  //     _isButtonDisabled = true;
  //   });
  //   setContainer();
  //   //asal
  //   _placeidasal = widget.placeidasal;
  //   _latitude_place_asal = widget.latitude_place_asal;
  //   _longitude_place_asal = widget.longitude_place_asal;
  //   _pelabuhanidasal = widget.pelabuhanidasal;
  //   _latitude_pelabuhan_asal = widget.latitude_pelabuhan_asal;
  //   _longitude_pelabuhan_asal = widget.longitude_pelabuhan_asal;
  //   _alamatasal.text = widget.alamatasal;
  //   pengirim = widget.pengirim;
  //   notelppengirim = widget.notelppengirim;
  //   notepengirim = widget.notepengirim;
  //   namapelabuhanpengirim = widget.namapelabuhanmuat;
  //   //tujuan
  //   _placeidtujuan = widget.placeidtujuan;
  //   _latitude_place_tujuan = widget.latitude_place_tujuan;
  //   _longitude_place_tujuan = widget.longitude_place_tujuan;
  //   _pelabuhanidtujuan = widget.pelabuhanidtujuan;
  //   _latitude_pelabuhan_tujuan = widget.latitude_pelabuhan_tujuan;
  //   _longitude_pelabuhan_tujuan = widget.longitude_pelabuhan_tujuan;
  //   _alamattujuan.text = widget.alamattujuan;
  //   penerima = widget.penerima;
  //   notelppenerima = widget.notelppenerima;
  //   notepenerima = widget.notepenerima;
  //   namapelabuhanpenerima = widget.namapelabuhanbongkar;
  //   //lainnya
  //   _container_id = int.parse(widget.container_id);
  //   _selectedqty = new TextEditingController(text: widget.qty);
  //   _selectedketerangantambahan =
  //       new TextEditingController(text: widget.keterangantambahan);
  //   _selectednamabarang = new TextEditingController(text: widget.namabarang);
  //   _selectedjenisbarang = new TextEditingController(text: widget.jenisbarang);
  //   _selectednilaibarang.text =
  //       NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 0)
  //           .format(double.tryParse(widget.nilaibarang));
  //   await showPlacePicker(_placeidasal, _latitude_pelabuhan_asal,
  //       _longitude_pelabuhan_asal, _alamatasal.text, "asal");
  //   await showPlacePicker(_placeidtujuan, _latitude_pelabuhan_tujuan,
  //       _longitude_pelabuhan_tujuan, _alamattujuan.text, "tujuan");

  //   if (_placeidasal != null &&
  //       _placeidtujuan != null &&
  //       _container_id != null &&
  //       _selectednilaibarang.text.isNotEmpty &&
  //       _selectedqty.text.isNotEmpty &&
  //       _selectedjenisbarang.text.isNotEmpty &&
  //       _selectednamabarang.text.isNotEmpty) {
  //     setState(() {
  //       _isButtonDisabled = false;
  //     });
  //   } else {
  //     setState(() {
  //       _isButtonDisabled = true;
  //     });
  //   }
  // }

  // void setContainer() async {
  //   var response = await http.get(
  //     Uri.parse(
  //         "${globals.url}/api-orderemkl/public/api/container/combokodecontainer?id=${widget.container_id}"),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //       'Authorization': 'Bearer ${globals.accessToken}',
  //     },
  //   );
  //   var container = await jsonDecode(response.body);
  //   print(container['data'][0]);
  //   // setState(() {
  //   //   _selectedcontainer = MasterContainer.fromJson(container['data'][0]);
  //   // });
  //   getMerchant();
  // }

  // void getMerchant() async {
  //   try {
  //     var response = await http.get(
  //         Uri.parse(
  //             '${globals.url}/api-orderemkl/public/api/pesanan/getpelabuhan?data={"place_id":"${widget.placeidasal}", "key":"${globals.apikey}"}'),
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'Accept': 'application/json',
  //           'Authorization': 'Bearer ${globals.accessToken}',
  //         });
  //     if (response.statusCode == 200) {
  //       var maps = await jsonDecode(response.body);
  //       print(maps);
  //       globals.merchantid = maps['data']['merchant_id'];
  //       globals.merchantpassword = maps['data']['merchant_password'];
  //       print(globals.merchantid);
  //     } else {
  //       print(response.body);
  //     }
  //   } catch (e) {
  //     print("error response");
  //     print(e.toString());
  //   }
  // }

  // void showPlacePicker(String placeId, var latitudePelabuhan,
  //     var longitudePelabuhan, String location, String condition) async {
  //   try {
  //     String _originController;
  //     var response = await http.get(
  //         Uri.parse(
  //             '${globals.url}/api-orderemkl/public/api/pesanan/getpelabuhan?data={"place_id":"$placeId", "key":"${globals.apikey}"}'),
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'Accept': 'application/json',
  //           'Authorization': 'Bearer ${globals.accessToken}',
  //         });
  //     if (response.statusCode == 500) {
  //       await globals.alertBerhasilPesan(
  //           context,
  //           "Mohon cek kembali koneksi internet WiFi/Data anda",
  //           'Tidak ada koneksi',
  //           'assets/imgs/no-internet.json');
  //     } else if (response.statusCode == 200) {
  //       var maps = await jsonDecode(response.body);
  //       if (maps['data'] == null) {
  //         await globals.alertBerhasilPesan(
  //             context,
  //             "Area belum masuk dalam daftar pengiriman",
  //             'Area tidak terdaftar',
  //             'assets/imgs/not-found.json');
  //       }
  //       print("masuk latitude");
  //       _originController = '$latitudePelabuhan, $longitudePelabuhan';
  //     }
  //     setDirection(_originController, location, condition);
  //   } catch (e) {
  //     print("error response");
  //     print(e.toString());
  //   }
  // }

  // void setDirection(String originController, String destinationController,
  //     String condition) async {
  //   var directions = await LocationService().getDirections(
  //     originController,
  //     destinationController,
  //   );
  //   if (condition == "asal") {
  //     _goToPlaceAsal(
  //       directions['start_location']['lat'],
  //       directions['start_location']['lng'],
  //       directions['end_location']['lat'],
  //       directions['end_location']['lng'],
  //       directions['distance']['text'],
  //       directions['duration']['text'],
  //       directions['bounds_ne'],
  //       directions['bounds_sw'],
  //     );
  //   } else {
  //     _goToPlaceTujuan(
  //       directions['start_location']['lat'],
  //       directions['start_location']['lng'],
  //       directions['end_location']['lat'],
  //       directions['end_location']['lng'],
  //       directions['distance']['text'],
  //       directions['duration']['text'],
  //       directions['bounds_ne'],
  //       directions['bounds_sw'],
  //     );
  //   }
  // }

  // Future<void> _goToPlaceAsal(
  //   double lat_origin,
  //   double lng_origin,
  //   double lat_destination,
  //   double lng_destination,
  //   String totalDistance,
  //   String totalDuration,
  //   Map<String, dynamic> boundsNe,
  //   Map<String, dynamic> boundsSw,
  // ) async {
  //   setState(() {
  //     _jarak_asal = totalDistance;
  //     _waktu_asal = totalDuration;
  //   });
  // }

  // Future<void> _goToPlaceTujuan(
  //   double lat_origin,
  //   double lng_origin,
  //   double lat_destination,
  //   double lng_destination,
  //   String totalDistance,
  //   String totalDuration,
  //   Map<String, dynamic> boundsNe,
  //   Map<String, dynamic> boundsSw,
  // ) async {
  //   setState(() {
  //     _jarak_tujuan = totalDistance;
  //     _waktu_tujuan = totalDuration;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xFFB7B7B7),
            )),
        title: Text(
          "Order",
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
      backgroundColor: Color(0xFFF1F1EF),
      body: ListView(
        children: [
          tracking(),
          SizedBox(height: 17.0),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 17.0, top: 7.0, right: 17.0),
                    child: Text(
                      "Lokasi Muat",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito-Medium',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 8.0, left: 17.0, right: 17.0),
                    child: SizedBox(
                      height: 36.0,
                      child: TextField(
                        controller: _alamatasal,
                        readOnly: true,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 15.0),
                          prefixIcon: Icon(
                            Icons.location_on,
                            color: Color(0xFF5599E9),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'Masukkan Data Pengirim',
                          hintStyle: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          // if (_alamatasal.text != null) {
                          //   EditAsal();
                          // } else {
                          //   MoveAsal();
                          // }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 17.0, top: 3.0, right: 17.0),
                    child: Text(
                      "Lokasi Bongkar",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito-Medium',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 3.0, bottom: 8.0, left: 17.0, right: 17.0),
                    child: SizedBox(
                      height: 36.0,
                      child: TextField(
                        controller: _alamattujuan,
                        readOnly: true,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 15.0),
                          prefixIcon: Icon(
                            Icons.flag,
                            color: Color(0xFFE95555),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'Masukkan Data Penerima',
                          hintStyle: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          // if (_alamattujuan.text != null) {
                          //   EditTujuan();
                          // } else {
                          //   MoveTujuan();
                          // }
                        },
                      ),
                    ),
                  ),
                  Divider(
                    color: Color(0xFFC3C3C3),
                    thickness: 1.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 17.0, top: 3.0, right: 17.0),
                    child: Text(
                      "Container",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito-Medium',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 3.0, bottom: 8.0, left: 17.0, right: 17.0),
                    child: SizedBox(
                      height: 36.0,
                      child: DropdownSearch<MasterContainer>(
                        showAsSuffixIcons: true,
                        mode: Mode.BOTTOM_SHEET,
                        // selectedItem: _selectedcontainer,
                        dropdownBuilder: (context, _selectedcontainer) {
                          return Text(
                            _selectedcontainer == null
                                ? "Masukkan Container"
                                : _selectedcontainer.toString(),
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: _selectedcontainer == null
                                  ? Color.fromARGB(255, 114, 114, 114)
                                  : Colors.black,
                            ),
                          );
                        },
                        dropdownSearchDecoration: const InputDecoration(
                          hintText: "Container",
                          hintStyle: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                          prefixIcon: Icon(
                            Icons.book,
                            color: Color(0xFF5599E9),
                          ),
                          contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                          border: OutlineInputBorder(),
                        ),
                        // onFind: (String filter) async {
                        //   var response = await Dio().get(
                        //     "${globals.url}/api-orderemkl/public/api/container/combokodecontainer",
                        //     options: Options(
                        //       headers: {
                        //         'Accept': 'application/json',
                        //         'Content-type': 'application/json',
                        //         'Authorization':
                        //             'Bearer ${globals.accessToken}',
                        //       },
                        //     ),
                        //   );
                        //   var models = MasterContainer.fromJsonList(
                        //       response.data['data']);
                        //   return models;
                        // },
                        onChanged: (data) {
                          // print(data);
                          // _container_id = data!.id!;
                          // if (_placeidasal != null &&
                          //     _placeidtujuan != null &&
                          //     _container_id != null &&
                          //     _selectednilaibarang.text.isNotEmpty &&
                          //     _selectedqty.text.isNotEmpty &&
                          //     _selectedjenisbarang.text.isNotEmpty &&
                          //     _selectednamabarang.text.isNotEmpty) {
                          //   setState(() {
                          //     _isButtonDisabled = false;
                          //   });
                          // } else {
                          //   setState(() {
                          //     _isButtonDisabled = true;
                          //   });
                          // }
                        },
                        popupTitle: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorDark,
                          ),
                          child: Center(
                            child: Text(
                              'Container',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 17.0, top: 4.0, right: 17.0),
                    child: Text(
                      "Nilai Barang",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito-Medium',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 3.0, bottom: 8.0, left: 17.0, right: 17.0),
                    child: SizedBox(
                      height: 36.0,
                      child: TextFormField(
                        inputFormatters: [
                          CurrencyTextInputFormatter(
                              locale: 'id', decimalDigits: 0, symbol: 'Rp. ')
                        ],
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                          prefixIcon: Icon(
                            Icons.attach_money,
                            color: Color(0xFF5599E9),
                          ),
                          hintText: "Nilai Barang (Asuransi)",
                          hintStyle: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        controller: _selectednilaibarang,
                        onChanged: (val) {
                          // if (_placeidasal != null &&
                          //     _placeidtujuan != null &&
                          //     _container_id != null &&
                          //     val.isNotEmpty &&
                          //     _selectedqty.text.isNotEmpty &&
                          //     _selectedjenisbarang.text.isNotEmpty &&
                          //     _selectednamabarang.text.isNotEmpty) {
                          //   setState(() {
                          //     _isButtonDisabled = false;
                          //   });
                          // } else {
                          //   setState(() {
                          //     _isButtonDisabled = true;
                          //   });
                          // }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 17.0, top: 4.0, right: 17.0),
                    child: Text(
                      "Qty",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito-Medium',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 3.0, bottom: 8.0, left: 17.0, right: 17.0),
                    child: SizedBox(
                      height: 36.0,
                      child: TextField(
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(new RegExp(
                              "^(([1-9][0-9]{2})|([1-9][0-9]{1})|([1-9]))"))
                        ],
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.line_style,
                            color: Color(0xFF5599E9),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                          hintText: 'Qty',
                          border: OutlineInputBorder(),
                        ),
                        controller: _selectedqty,
                        onChanged: (val) {
                          // if (_placeidasal != null &&
                          //     _placeidtujuan != null &&
                          //     _container_id != null &&
                          //     _selectednilaibarang.text.isNotEmpty &&
                          //     val.isNotEmpty &&
                          //     _selectedjenisbarang.text.isNotEmpty &&
                          //     _selectednamabarang.text.isNotEmpty) {
                          //   setState(() {
                          //     _isButtonDisabled = false;
                          //   });
                          // } else {
                          //   setState(() {
                          //     _isButtonDisabled = true;
                          //   });
                          // }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 17.0, top: 4.0, right: 17.0),
                    child: Text(
                      "Jenis Barang",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito-Medium',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 3.0, bottom: 8.0, left: 17.0, right: 17.0),
                    child: SizedBox(
                      height: 36.0,
                      child: TextFormField(
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.view_list,
                              color: Color(0xFF5599E9),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                            hintText: 'Jenis Barang',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          controller: _selectedjenisbarang,
                          inputFormatters: [
                            UpperCaseTextFormatter(),
                          ],
                          onChanged: (val) {
                            // if (_placeidasal != null &&
                            //     _placeidtujuan != null &&
                            //     _container_id != null &&
                            //     _selectednilaibarang.text.isNotEmpty &&
                            //     _selectedqty.text.isNotEmpty &&
                            //     val.isNotEmpty &&
                            //     _selectednamabarang.text.isNotEmpty) {
                            //   setState(() {
                            //     _isButtonDisabled = false;
                            //   });
                            // } else {
                            //   setState(() {
                            //     _isButtonDisabled = true;
                            //   });
                            // }
                          },
                          textCapitalization: TextCapitalization.sentences),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 17.0, top: 4.0, right: 17.0),
                    child: Text(
                      "Nama Barang",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito-Medium',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 3.0, bottom: 8.0, left: 17.0, right: 17.0),
                    child: SizedBox(
                      height: 36.0,
                      child: TextFormField(
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.view_list,
                              color: Color(0xFF5599E9),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                            hintText: 'Nama Barang',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          controller: _selectednamabarang,
                          inputFormatters: [
                            UpperCaseTextFormatter(),
                          ],
                          onChanged: (val) {
                            // if (_placeidasal != null &&
                            //     _placeidtujuan != null &&
                            //     _container_id != null &&
                            //     _selectednilaibarang.text.isNotEmpty &&
                            //     _selectedqty.text.isNotEmpty &&
                            //     _selectedjenisbarang.text.isNotEmpty &&
                            //     val.isNotEmpty) {
                            //   setState(() {
                            //     _isButtonDisabled = false;
                            //   });
                            // } else {
                            //   setState(() {
                            //     _isButtonDisabled = true;
                            //   });
                            // }
                          },
                          textCapitalization: TextCapitalization.sentences),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 17.0, top: 4.0, right: 17.0),
                    child: Text(
                      "Keterangan Tambahan",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito-Medium',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 3.0, bottom: 8.0, left: 17.0, right: 17.0),
                    child: SizedBox(
                      height: 36.0,
                      child: TextFormField(
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.note_alt,
                              color: Color(0xFF5599E9),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                            hintText: 'Keterangan Tambahan',
                            border: OutlineInputBorder(),
                          ),
                          inputFormatters: [
                            UpperCaseTextFormatter(),
                          ],
                          controller: _selectedketerangantambahan,
                          textCapitalization: TextCapitalization.sentences),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 3.0, bottom: 8.0, left: 17.0, right: 17.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(
                color: Colors.white,
              ),
              backgroundColor: Color(0xFF5599E9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
            onPressed:
                // _isButtonDisabled == true
                //     ? null :
                () async {
              // _showDialog(context,
              //     SimpleFontelicoProgressDialogType.normal, 'Normal');
              // if (_pelabuhanidasal == _pelabuhanidtujuan) {
              // } else {
              //   Future.delayed(const Duration(seconds: 0), () {
              //     ConfirmOrder(
              //       _placeidasal,
              //       _pelabuhanidasal,
              //       _latitude_pelabuhan_asal,
              //       _longitude_pelabuhan_asal,
              //       _jarak_asal,
              //       _waktu_asal,
              //       _alamatasal.text,
              //       pengirim,
              //       notelppengirim,
              //       _placeidtujuan,
              //       _pelabuhanidtujuan,
              //       _latitude_pelabuhan_tujuan,
              //       _longitude_pelabuhan_tujuan,
              //       _jarak_tujuan,
              //       _waktu_tujuan,
              //       _alamattujuan.text,
              //       penerima,
              //       notelppenerima,
              //       _container_id,
              //       _selectednilaibarang.text,
              //       _selectedqty.text,
              //       _selectedjenisbarang.text,
              //       _selectednamabarang.text,
              //       _selectedketerangantambahan.text,
              //     );

              //     // alert();
              //     // Navigator.pushReplacementNamed(context, '/harga');
              //   });
              // }
              // // print(_selectednilaibarang.text);
            },
            child: Padding(
                padding: EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 12, bottom: 12),
                child: Text("Order", style: TextStyle(fontSize: 14.0))),
          ),
        ),
      ),
    );
  }

  Widget tracking() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20.0),
            const CircleAvatar(
              backgroundColor: Color(0xFF5599E9),
              child: Text(
                '1',
                style: TextStyle(
                  color: Colors.white,
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
        Column(
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
        Column(
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
            Text("Bayar", style: TextStyle(fontSize: 14.0)),
          ],
        ),
      ],
    );
  }
}
