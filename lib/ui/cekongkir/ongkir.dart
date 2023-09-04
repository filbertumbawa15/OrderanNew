import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:dio/dio.dart';
// import 'package:material_dialogs/widgets/buttons/icon_button.dart';
// import 'package:flutter_masked_text/flutter_masked_text.dart';
// import 'package:now_ui_flutter/constants/Theme.dart';
// import 'package:now_ui_flutter/models/dart_models.dart';
// import 'package:now_ui_flutter/screens/CekOngkir/asal_ongkir.dart';
// import 'package:now_ui_flutter/screens/CekOngkir/tujuan_ongkir.dart';
// import 'package:now_ui_flutter/screens/CekOngkir/harga.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:now_ui_flutter/globals.dart' as globals;
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class Ongkir extends StatefulWidget {
  @override
  _OngkirState createState() => _OngkirState();
}

class _OngkirState extends State<Ongkir> {
  var size, height, width;
  SimpleFontelicoProgressDialog? _dialog;
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
  String? alamatpengirim;
  var _nama_pelabuhan_asal;

  var provinsiasal;
  var kotaasal;
  var kecamatanasal;
  var kelurahanasal;
  String? pengirim;
  String? notelppengirim;
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
  String? alamatpenerima;
  var _nama_pelabuhan_tujuan;

  var provinsitujuan;
  var kotatujuan;
  var kecamatantujuan;
  var kelurahantujuan;
  String? penerima;
  String? notelppenerima;
  //Data Tujuan

  double _scaleFactor = 1.0;
  double _baseScaleFactor = 1.0;
  // List<String> _datacontainer = List();
  // List<String> _datapelayaran = List();
  TextEditingController _datatujuan = new TextEditingController();
  //Lain-lain
  int? _container_id;
  String? _selectedpelayaran;
  //Lain-lain
  TextEditingController _selectednilaibarang = new TextEditingController();
  TextEditingController _selectedqty = new TextEditingController(text: '1');
  // MoneyMaskedTextController _selectednilaibarang =
  //     new MoneyMaskedTextController(thousandSeparator: ',');
  List<String>? datatujuan;

  bool? _isButtonDisabled;

  // void getPelayaran() async {
  //   final response = await http
  //       .get(Uri.parse('${globals.url}/api-orderemkl/order/getpelayaranlist'));

  //   var pelayaran = json.decode(response.body);
  //   pelayaran['data']
  //       .forEach((value) => _datapelayaran.add(value['fnpelayaran']));
  // }

  void updateDataAsal(Object information_asal) async {
    // print(jsonDecode(jsonEncode(information_asal))['_selectedprovinsiasal']
    //     .toString());
    setState(() {
      _placeidasal =
          jsonDecode(jsonEncode(information_asal))['_placeidasal'].toString();
      _latitude_place_asal =
          jsonDecode(jsonEncode(information_asal))['_latitude_place_asal']
              .toString();
      _longitude_place_asal =
          jsonDecode(jsonEncode(information_asal))['_longitude_place_asal']
              .toString();
      _pelabuhanidasal =
          jsonDecode(jsonEncode(information_asal))['_pelabuhanidasal']
              .toString();
      _latitude_pelabuhan_asal =
          jsonDecode(jsonEncode(information_asal))['_latitude_pelabuhan_asal']
              .toString();
      _longitude_pelabuhan_asal =
          jsonDecode(jsonEncode(information_asal))['_longitude_pelabuhan_asal']
              .toString();
      _jarak_asal =
          jsonDecode(jsonEncode(information_asal))['_jarak_asal'].toString();
      _waktu_asal =
          jsonDecode(jsonEncode(information_asal))['_waktu_asal'].toString();
      _alamatasal.text =
          jsonDecode(jsonEncode(information_asal))['_alamatasal'].toString();
      alamatpengirim =
          jsonDecode(jsonEncode(information_asal))['alamatpengirim'].toString();
      _nama_pelabuhan_asal =
          jsonDecode(jsonEncode(information_asal))['_nama_pelabuhan_asal']
              .toString();
//

      _selectedprovinsiasal =
          jsonDecode(jsonEncode(information_asal))['_selectedprovinsiasal']
              .toString();
      _selectedkotaasal =
          jsonDecode(jsonEncode(information_asal))['_selectedkotaasal']
              .toString();
      _selectedkecamatanasal =
          jsonDecode(jsonEncode(information_asal))['_selectedkecamatanasal']
              .toString();
      _selectedkelurahanasal =
          jsonDecode(jsonEncode(information_asal))['_selectedkelurahanasal']
              .toString();
      notelppengirim =
          jsonDecode(jsonEncode(information_asal))['notelppengirim'].toString();
      pengirim =
          jsonDecode(jsonEncode(information_asal))['pengirim'].toString();
    });
    if (_selectednilaibarang.text.isNotEmpty &&
        _container_id != null &&
        _selectedqty.text.isNotEmpty &&
        _placeidasal != null &&
        _placeidtujuan != null) {
      setState(() {
        _isButtonDisabled = false;
      });
    } else {
      setState(() {
        _isButtonDisabled = true;
      });
    }
  }

  void updateDataTujuan(Object information_tujuan) async {
    setState(() {
      _placeidtujuan =
          jsonDecode(jsonEncode(information_tujuan))['_placeidtujuan']
              .toString();
      _latitude_place_tujuan =
          jsonDecode(jsonEncode(information_tujuan))['_latitude_place_tujuan']
              .toString();
      _longitude_place_tujuan =
          jsonDecode(jsonEncode(information_tujuan))['_longitude_place_tujuan']
              .toString();
      _pelabuhanidtujuan =
          jsonDecode(jsonEncode(information_tujuan))['_pelabuhanidtujuan']
              .toString();
      _latitude_pelabuhan_tujuan = jsonDecode(
              jsonEncode(information_tujuan))['_latitude_pelabuhan_tujuan']
          .toString();
      _longitude_pelabuhan_tujuan = jsonDecode(
              jsonEncode(information_tujuan))['_longitude_pelabuhan_tujuan']
          .toString();
      _jarak_tujuan =
          jsonDecode(jsonEncode(information_tujuan))['_jarak_tujuan']
              .toString();
      _waktu_tujuan =
          jsonDecode(jsonEncode(information_tujuan))['_waktu_tujuan']
              .toString();
      _alamattujuan.text =
          jsonDecode(jsonEncode(information_tujuan))['_alamattujuan']
              .toString();
      alamatpengirim =
          jsonDecode(jsonEncode(information_tujuan))['alamatpengirim']
              .toString();
//

      _selectedprovinsitujuan =
          jsonDecode(jsonEncode(information_tujuan))['_selectedprovinsitujuan']
              .toString();
      _selectedkotatujuan =
          jsonDecode(jsonEncode(information_tujuan))['_selectedkotatujuan']
              .toString();
      _selectedkecamatantujuan =
          jsonDecode(jsonEncode(information_tujuan))['_selectedkecamatantujuan']
              .toString();
      _selectedkelurahantujuan =
          jsonDecode(jsonEncode(information_tujuan))['_selectedkelurahantujuan']
              .toString();
      notelppengirim =
          jsonDecode(jsonEncode(information_tujuan))['notelppengirim']
              .toString();
      pengirim =
          jsonDecode(jsonEncode(information_tujuan))['pengirim'].toString();
    });
    if (_selectednilaibarang.text.isNotEmpty &&
        _container_id != null &&
        _selectedqty.text.isNotEmpty &&
        _placeidasal != null &&
        _placeidtujuan != null) {
      setState(() {
        _isButtonDisabled = false;
      });
    } else {
      setState(() {
        _isButtonDisabled = true;
      });
    }
  }

  // void MoveAsal() async {
  //   // final information_asal = await Navigator.push(
  //   //   context,
  //   //   CupertinoPageRoute(
  //   //       fullscreenDialog: true, builder: (context) => Asal_Ongkir()),
  //   // );
  //   final information_asal = await Navigator.pushNamed(context, '/asal_ongkir');
  //   updateDataAsal(information_asal);
  // }

  // void EditAsal() async {
  //   final information_asal = await Navigator.push(
  //     context,
  //     CupertinoPageRoute(
  //         fullscreenDialog: true,
  //         builder: (context) => Asal_Ongkir(
  //               selectedplaceidasal: _placeidasal,
  //               selectedlatitudeplaceasal: _latitude_place_asal,
  //               selectedlongitudeplaceasal: _longitude_place_asal,
  //               selectedpelabuhanidasal: _pelabuhanidasal,
  //               selectedalamatasal: _alamatasal.text,
  //               selectednamapelabuhan: _nama_pelabuhan_asal,
  //             )),
  //   );
  //   updateDataAsal(information_asal);
  // }

  // void MoveTujuan() async {
  //   // final information_tujuan = await Navigator.push(
  //   //   context,
  //   //   CupertinoPageRoute(
  //   //       fullscreenDialog: true, builder: (context) => Tujuan_Ongkir()),
  //   // );
  //   final information_tujuan =
  //       await Navigator.pushNamed(context, '/tujuan_ongkir');
  //   updateDataTujuan(information_tujuan);
  // }

  // void EditTujuan() async {
  //   final information_tujuan = await Navigator.push(
  //     context,
  //     CupertinoPageRoute(
  //         fullscreenDialog: true,
  //         builder: (context) => Tujuan_Ongkir(
  //               selectedplaceidtujuan: _placeidtujuan,
  //               selectedlatitudeplacetujuan: _latitude_place_tujuan,
  //               selectedlongitudeplacetujuan: _longitude_place_tujuan,
  //               selectedpelabuhanidtujuan: _pelabuhanidtujuan,
  //               selectedalamattujuan: _alamattujuan.text,
  //               selectednamapelabuhan: _nama_pelabuhan_asal,
  //             )),
  //   );
  //   updateDataTujuan(information_tujuan);
  // }

  // void ConfirmOrder(
  //   var _placeidasal,
  //   var _pelabuhanidasal,
  //   var _latitude_pelabuhan_asal,
  //   var _longitude_pelabuhan_asal,
  //   var _jarak_asal,
  //   var _waktu_asal,
  //   var _alamatasal,
  //   var _placeidtujuan,
  //   var _pelabuhanidtujuan,
  //   var _latitude_pelabuhan_tujuan,
  //   var _longitude_pelabuhan_tujuan,
  //   var _jarak_tujuan,
  //   var _waktu_tujuan,
  //   var _alamattujuan,
  //   int _container_id,
  //   String nilaibarang,
  //   String qty,
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
  //     "placeidtujuan": _placeidtujuan,
  //     "pelabuhanidtujuan": _pelabuhanidtujuan,
  //     "latitude_pelabuhan_tujuan": _latitude_pelabuhan_tujuan,
  //     "longitude_pelabuhan_tujuan": _longitude_pelabuhan_tujuan,
  //     "jarak_tujuan": _jarak_tujuan,
  //     "waktu_tujuan": _waktu_tujuan,
  //     "container_id": _container_id,
  //     "nilaibarang_asuransi": nilaibarang_asuransi,
  //     "qty": qty,
  //     "key": '${globals.apikey}',
  //   };
  //   var encode = jsonEncode(data);
  //   print(encode);
  //   final response = await http.get(
  //     Uri.parse(
  //         '${globals.url}/api-orderemkl/public/api/pesanan/cekongkoskirim?data=$encode'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //       'Authorization': 'Bearer ${globals.accessToken}',
  //     },
  //   );
  //   final harga = jsonDecode(response.body)['harga'];
  //   final harga_satuan = jsonDecode(response.body)['hargasatuan'];
  //   await Future.delayed(Duration(seconds: 2));
  //   _dialog.hide();
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => Harga(
  //                 origincontroller: _alamatasal,
  //                 pelabuhanasal:
  //                     '$_latitude_pelabuhan_asal,$_longitude_pelabuhan_asal',
  //                 pelabuhanidasal: _pelabuhanidasal,
  //                 jarakasal: _jarak_asal,
  //                 waktuasal: _waktu_asal,
  //                 destinationcontroller: _alamattujuan,
  //                 pelabuhantujuan:
  //                     '$_latitude_pelabuhan_tujuan,$_longitude_pelabuhan_tujuan',
  //                 pelabuhanidtujuan: _pelabuhanidtujuan,
  //                 container: _container_id,
  //                 nilaibarang: _selectednilaibarang.text,
  //                 jaraktujuan: _jarak_tujuan,
  //                 waktutujuan: _waktu_tujuan,
  //                 harga: harga,
  //                 qty: qty,
  //                 hargasatuan: harga_satuan,
  //               )));
  // }

  void _showDialog(BuildContext context, SimpleFontelicoProgressDialogType type,
      String text) async {
    if (_dialog == null) {
      _dialog = SimpleFontelicoProgressDialog(
          context: context, barrierDimisable: false);
    }
    if (type == SimpleFontelicoProgressDialogType.custom) {
      _dialog!.show(
          message: text,
          type: type,
          width: 150.0,
          height: 75.0,
          loadingIndicator: Text(
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
    // await Future.delayed(Duration(seconds: 2));
    // _dialog.hide();
  }

  // String test = ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getPelayaran();
    // print(globals.loggedinId);
    _isButtonDisabled = true;
    // if (globals.loggedIn == false) {
    //   // ScaffoldMessenger.of(context).showSnackBar(
    //   //   SnackBar(content: Text('Anda harus login terlebih dahulu')),
    //   // );
    //   Navigator.pushReplacementNamed(context, '/login');
    // }
  }

  void dispose() {
    print("test");
    super.dispose();
  }

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
          "Cek Ongkir",
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
      backgroundColor: Colors.white,
      body: ListView(
        children: [
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
                        left: 17.0, top: 7.0, right: 17.0, bottom: 18.0),
                    child: Text(
                      "Lokasi Pengantaran",
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
                          label: Text('Data Pengirim'),
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          if (_alamatasal.text != null) {
                            // EditAsal();
                          } else {
                            // MoveAsal();
                          }
                        },
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
                          label: Text('Data Penerima'),
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          if (_alamattujuan.text != null) {
                            // EditTujuan();
                          } else {
                            // MoveTujuan();
                          }
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
                        left: 17.0, top: 7.0, right: 17.0, bottom: 18.0),
                    child: Text(
                      "Tambahan Lainnya",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito-Medium',
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       top: 3.0, bottom: 8.0, left: 17.0, right: 17.0),
                  //   child: SizedBox(
                  //     height: 36.0,
                  //     child: DropdownSearch<MasterContainer>(
                  //       showAsSuffixIcons: true,
                  //       mode: Mode.BOTTOM_SHEET,
                  //       dropdownBuilder: (context, _selectedcontainer) {
                  //         return Text(
                  //           _selectedcontainer == null
                  //               ? ""
                  //               : _selectedcontainer.toString(),
                  //           style: TextStyle(
                  //             fontSize: 13.0,
                  //             fontWeight: FontWeight.bold,
                  //             color: _selectedcontainer == null
                  //                 ? Color.fromARGB(255, 114, 114, 114)
                  //                 : Colors.black,
                  //           ),
                  //         );
                  //       },
                  //       dropdownSearchDecoration: InputDecoration(
                  //         label: Text("Container"),
                  //         labelStyle: TextStyle(
                  //           fontSize: 14.0,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //         prefixIcon: Icon(
                  //           Icons.book,
                  //           color: Color(0xFF5599E9),
                  //         ),
                  //         contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                  //         border: OutlineInputBorder(),
                  //       ),
                  //       onFind: (String filter) async {
                  //         var response = await Dio().get(
                  //           "${globals.url}/api-orderemkl/public/api/container/combokodecontainer",
                  //           options: Options(
                  //             headers: {
                  //               'Accept': 'application/json',
                  //               'Content-type': 'application/json',
                  //               'Authorization':
                  //                   'Bearer ${globals.accessToken}',
                  //             },
                  //           ),
                  //         );
                  //         var models = MasterContainer.fromJsonList(
                  //             response.data['data']);
                  //         return models;
                  //       },
                  //       onChanged: (data) {
                  //         // print(data);
                  //         _container_id = data.id;
                  //         if (_placeidasal != null &&
                  //             _placeidtujuan != null &&
                  //             _container_id != null &&
                  //             _selectednilaibarang.text.isNotEmpty &&
                  //             _selectedqty.text.isNotEmpty) {
                  //           setState(() {
                  //             _isButtonDisabled = false;
                  //           });
                  //         } else {
                  //           setState(() {
                  //             _isButtonDisabled = true;
                  //           });
                  //         }
                  //       },
                  //       popupTitle: Container(
                  //         height: 50,
                  //         decoration: BoxDecoration(
                  //           color: Theme.of(context).primaryColorDark,
                  //         ),
                  //         child: Center(
                  //           child: Text(
                  //             'Container',
                  //             style: TextStyle(
                  //               fontSize: 24,
                  //               fontWeight: FontWeight.bold,
                  //               color: Colors.white,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
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
                          label: Text(
                            "Nilai Barang (Asuransi)",
                          ),
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        controller: _selectednilaibarang,
                        onChanged: (val) {
                          if (_placeidasal != null &&
                              _placeidtujuan != null &&
                              _container_id != null &&
                              val.isNotEmpty &&
                              _selectedqty.text.isNotEmpty) {
                            setState(() {
                              _isButtonDisabled = false;
                            });
                          } else {
                            setState(() {
                              _isButtonDisabled = true;
                            });
                          }
                        },
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
                          label: Text('Qty'),
                          border: OutlineInputBorder(),
                        ),
                        controller: _selectedqty,
                        onChanged: (val) {
                          if (_placeidasal != null &&
                              _placeidtujuan != null &&
                              _container_id != null &&
                              _selectednilaibarang.text.isNotEmpty &&
                              val.isNotEmpty) {
                            setState(() {
                              _isButtonDisabled = false;
                            });
                          } else {
                            setState(() {
                              _isButtonDisabled = true;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        width: width,
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
                // _isButtonDisabled
                //     ? null
                //     :
                () {
              _showDialog(
                  context, SimpleFontelicoProgressDialogType.normal, 'Normal');
              // _dialog.hide();
              Future.delayed(const Duration(milliseconds: 2000), () {
                // ConfirmOrder(
                //   _placeidasal,
                //   _pelabuhanidasal,
                //   _latitude_pelabuhan_asal,
                //   _longitude_pelabuhan_asal,
                //   _jarak_asal,
                //   _waktu_asal,
                //   _alamatasal.text,
                //   _placeidtujuan,
                //   _pelabuhanidtujuan,
                //   _latitude_pelabuhan_tujuan,
                //   _longitude_pelabuhan_tujuan,
                //   _jarak_tujuan,
                //   _waktu_tujuan,
                //   _alamattujuan.text,
                //   _container_id,
                //   _selectednilaibarang.text,
                //   _selectedqty.text,
                // );

                // alert();
                // Navigator.pushReplacementNamed(context, '/harga');
              });
              // print(_selectednilaibarang.text);
            },
            child: Padding(
                padding: EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 12, bottom: 12),
                child: Text("Cek Ongkir", style: TextStyle(fontSize: 14.0))),
          ),
        ),
      ),
    );
  }

  Widget lainnya() {
    return Padding(
        padding: EdgeInsets.only(top: 15),
        child: Container(
            padding: EdgeInsets.only(right: 24, left: 24, bottom: 36),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 32),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Lainnya",
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                              fontSize: 16)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: SizedBox(
                      height: 40,
                      child: DropdownSearch<String>(
                        // showAsSuffixIcons: true,
                        // mode: Mode.BOTTOM_SHEET,
                        // dropdownSearchDecoration: InputDecoration(
                        //   labelText: "Container",
                        //   contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                        //   border: OutlineInputBorder(),
                        // ),
                        // // ignore: missing_return
                        // onFind: (String filter) async {
                        //   Response response;
                        //   try {
                        //     response = await Dio().get(
                        //       "${globals.url}/api-orderemkl/public/api/container/combokodecontainer",
                        //       options: Options(
                        //         headers: {
                        //           'Accept': 'application/json',
                        //           'Content-type': 'application/json',
                        //           'Authorization':
                        //               'Bearer ${globals.accessToken}',
                        //         },
                        //       ),
                        //     );
                        //     var models = MasterContainer.fromJsonList(
                        //         response.data['data']);
                        //     return models;
                        //   } on DioError catch (e) {
                        //     if (e.response.statusCode == 500) {}
                        //   }
                        // },
                        onChanged: (data) {
                          // print(data);
                          // _container_id = data.id;
                          // if (_selectednilaibarang.text.isNotEmpty &&
                          //     _container_id != null &&
                          //     _selectedqty.text.isNotEmpty &&
                          //     _placeidasal != null &&
                          //     _placeidtujuan != null) {
                          //   setState(() {
                          //     _isButtonDisabled = false;
                          //   });
                          // } else {
                          //   setState(() {
                          //     _isButtonDisabled = true;
                          //   });
                          // }
                        },
                        // showSearchBox: true,
                        // searchFieldProps: TextFieldProps(
                        //   decoration: InputDecoration(
                        //     border: OutlineInputBorder(),
                        //     contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                        //     labelText: "Cari Container",
                        //   ),
                        // ),
                        // popupTitle: Container(
                        //   height: 50,
                        //   decoration: BoxDecoration(
                        //     color: Theme.of(context).primaryColorDark,
                        //     borderRadius: BorderRadius.only(
                        //       topLeft: Radius.circular(0),
                        //       topRight: Radius.circular(0),
                        //     ),
                        //   ),
                        //   child: Center(
                        //     child: Text(
                        //       'Container',
                        //       style: TextStyle(
                        //         fontSize: 24,
                        //         fontWeight: FontWeight.bold,
                        //         color: Colors.white,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // popupShape: const RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.only(
                        //     topLeft: Radius.circular(0),
                        //     topRight: Radius.circular(0),
                        //   ),
                        // ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: SizedBox(
                      height: 50,
                      child: TextFormField(
                        textAlign: TextAlign.right,
                        inputFormatters: [
                          CurrencyTextInputFormatter(
                              locale: 'id', decimalDigits: 0, symbol: 'Rp. ')
                        ],
                        decoration: InputDecoration(
                          labelText: 'Nilai Barang (Asuransi)',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        controller: _selectednilaibarang,
                        onChanged: (val) {
                          if (val.isNotEmpty &&
                              _container_id != null &&
                              _selectedqty.text.isNotEmpty &&
                              _placeidasal != null &&
                              _placeidtujuan != null) {
                            setState(() {
                              _isButtonDisabled = false;
                            });
                          } else {
                            setState(() {
                              _isButtonDisabled = true;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: SizedBox(
                      height: 50,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(new RegExp(
                              "^(([1-9][0-9]{2})|([1-9][0-9]{1})|([1-9]))"))
                        ],
                        decoration: InputDecoration(
                            label: Text('Qty'), border: OutlineInputBorder()),
                        controller: _selectedqty,
                        onChanged: (val) {
                          if (val.isNotEmpty &&
                              _container_id != null &&
                              _selectednilaibarang.text.isNotEmpty &&
                              _placeidasal != null &&
                              _placeidtujuan != null) {
                            setState(() {
                              _isButtonDisabled = false;
                            });
                          } else {
                            setState(() {
                              _isButtonDisabled = true;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
