import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'dart:convert';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:tasorderan/bloc/pesanan/ongkir/datapengirim/datapengirim_cubit.dart';
import 'package:tasorderan/bloc/pesanan/ongkir/ongkir/ongkir_bloc.dart';
import 'package:tasorderan/components/components.dart';
import 'package:tasorderan/core/api_client.dart';
import 'package:tasorderan/main.dart';
import 'package:tasorderan/models/pesanan_models.dart';

class Ongkir extends StatefulWidget {
  @override
  _OngkirState createState() => _OngkirState();
}

class _OngkirState extends State<Ongkir> {
  Size? size;
  double? height, width;
  SimpleFontelicoProgressDialog? _dialog;
  //Data Asal
  String? _selectedprovinsiasal;
  String? _selectedkotaasal;
  String? _selectedkecamatanasal;
  String? _selectedkelurahanasal;

  String? _placeidasal;
  String? _latitude_place_asal;
  String? _longitude_place_asal;
  String? _pelabuhanidasal;
  String? _latitude_pelabuhan_asal;
  String? _longitude_pelabuhan_asal;
  String? _jarak_asal;
  String? _waktu_asal;
  final _alamatasal = TextEditingController();
  String? alamatpengirim;
  String? _nama_pelabuhan_asal;

  String? provinsiasal;
  String? kotaasal;
  String? kecamatanasal;
  String? kelurahanasal;
  String? pengirim;
  String? notelppengirim;
  //Data Asal

  //Data Tujuan
  String? _selectedprovinsitujuan;
  String? _selectedkotatujuan;
  String? _selectedkecamatantujuan;
  String? _selectedkelurahantujuan;

  String? _placeidtujuan;
  String? _latitude_place_tujuan;
  String? _longitude_place_tujuan;
  String? _pelabuhanidtujuan;
  String? _latitude_pelabuhan_tujuan;
  String? _longitude_pelabuhan_tujuan;
  String? _jarak_tujuan;
  String? _waktu_tujuan;
  final _alamattujuan = TextEditingController();
  String? alamatpenerima;
  String? _nama_pelabuhan_tujuan;

  String? provinsitujuan;
  String? kotatujuan;
  String? kecamatantujuan;
  String? kelurahantujuan;
  String? penerima;
  String? notelppenerima;
  //Data Tujuan

  //Lain-lain
  int? _container_id;
  final _selectednilaibarang = TextEditingController();
  final _selectedqty = TextEditingController(text: '1');

  ValueNotifier<bool>? _isButtonDisabled;

  final components = Tools();
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

//   void updateDataAsal(Object information_asal) async {
//     setState(() {
//       _placeidasal =
//           jsonDecode(jsonEncode(information_asal))['_placeidasal'].toString();
//       _latitude_place_asal =
//           jsonDecode(jsonEncode(information_asal))['_latitude_place_asal']
//               .toString();
//       _longitude_place_asal =
//           jsonDecode(jsonEncode(information_asal))['_longitude_place_asal']
//               .toString();
//       _pelabuhanidasal =
//           jsonDecode(jsonEncode(information_asal))['_pelabuhanidasal']
//               .toString();
//       _latitude_pelabuhan_asal =
//           jsonDecode(jsonEncode(information_asal))['_latitude_pelabuhan_asal']
//               .toString();
//       _longitude_pelabuhan_asal =
//           jsonDecode(jsonEncode(information_asal))['_longitude_pelabuhan_asal']
//               .toString();
//       _jarak_asal =
//           jsonDecode(jsonEncode(information_asal))['_jarak_asal'].toString();
//       _waktu_asal =
//           jsonDecode(jsonEncode(information_asal))['_waktu_asal'].toString();
//       _alamatasal.text =
//           jsonDecode(jsonEncode(information_asal))['_alamatasal'].toString();
//       alamatpengirim =
//           jsonDecode(jsonEncode(information_asal))['alamatpengirim'].toString();
//       _nama_pelabuhan_asal =
//           jsonDecode(jsonEncode(information_asal))['_nama_pelabuhan_asal']
//               .toString();
// //

//       _selectedprovinsiasal =
//           jsonDecode(jsonEncode(information_asal))['_selectedprovinsiasal']
//               .toString();
//       _selectedkotaasal =
//           jsonDecode(jsonEncode(information_asal))['_selectedkotaasal']
//               .toString();
//       _selectedkecamatanasal =
//           jsonDecode(jsonEncode(information_asal))['_selectedkecamatanasal']
//               .toString();
//       _selectedkelurahanasal =
//           jsonDecode(jsonEncode(information_asal))['_selectedkelurahanasal']
//               .toString();
//       notelppengirim =
//           jsonDecode(jsonEncode(information_asal))['notelppengirim'].toString();
//       pengirim =
//           jsonDecode(jsonEncode(information_asal))['pengirim'].toString();
//     });
//     if (_selectednilaibarang.text.isNotEmpty &&
//         _container_id != null &&
//         _selectedqty.text.isNotEmpty &&
//         _placeidasal != null &&
//         _placeidtujuan != null) {
//       _isButtonDisabled!.value = false;
//     } else {
//       _isButtonDisabled!.value = true;
//     }
//   }

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
      _isButtonDisabled!.value = false;
    } else {
      _isButtonDisabled!.value = true;
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

  // String test = ;
  @override
  void initState() {
    super.initState();
    _isButtonDisabled = ValueNotifier<bool>(true);
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size!.height;
    width = size!.width;
    return Scaffold(
      key: _navigatorKey,
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
      body: BlocProvider(
        create: (context) => DatapengirimCubit(),
        // MultiBlocProvider(
        //   providers: [
        //     BlocProvider(
        //       create: (context) => DatapengirimCubit(),
        //     ),
        //   ],
        child: ListView(
          children: [
            const SizedBox(height: 17.0),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
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
                    BlocConsumer<DatapengirimCubit, DatapengirimState>(
                      listener: (context, state) {
                        if (state is AsalSuccess) {
                          Map<String, dynamic> datapengirim =
                              jsonDecode(jsonEncode(state.result));
                          _placeidasal = datapengirim['_placeidasal'];
                          _latitude_place_asal =
                              datapengirim['_latitude_place_asal'].toString();
                          _longitude_place_asal =
                              datapengirim['_longitude_place_asal'].toString();
                          _pelabuhanidasal = datapengirim['_pelabuhanidasal'];
                          _latitude_pelabuhan_asal =
                              datapengirim['_latitude_pelabuhan_asal'];
                          _longitude_pelabuhan_asal =
                              datapengirim['_longitude_pelabuhan_asal'];
                          _jarak_asal = datapengirim['_jarak_asal'];
                          _waktu_asal = datapengirim['_waktu_asal'];
                          _alamatasal.text = datapengirim['_alamatasal'];
                          _nama_pelabuhan_asal =
                              datapengirim['_nama_pelabuhan_asal'];
                          // _placeidasal = "asdfasdf";
                          // print(_placeidasal);
                          // print("ddd");
                        }
                      },
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 8.0, left: 17.0, right: 17.0),
                          child: SizedBox(
                            height: 36.0,
                            child: TextField(
                              controller: _alamatasal,
                              readOnly: true,
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: const InputDecoration(
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
                                if (_placeidasal == null) {
                                  BlocProvider.of<DatapengirimCubit>(context)
                                      .navigatorPushAsal(route: '/asal');
                                } else {
                                  BlocProvider.of<DatapengirimCubit>(context)
                                      .navigatorPushAsal(
                                    route: '/asal',
                                    param: {
                                      '_placeidasal': _placeidasal,
                                      '_latitude_place_asal':
                                          _latitude_place_asal,
                                      '_longitude_place_asal':
                                          _longitude_place_asal,
                                      '_pelabuhanidasal': _pelabuhanidasal,
                                      '_latitude_pelabuhan_asal':
                                          _latitude_pelabuhan_asal,
                                      '_longitude_pelabuhan_asal':
                                          _longitude_pelabuhan_asal,
                                      '_jarak_asal': _jarak_asal,
                                      '_waktu_asal': _waktu_asal,
                                      '_alamatasal': _alamatasal.text,
                                      '_nama_pelabuhan_asal':
                                          _nama_pelabuhan_asal,
                                    },
                                  );
                                }
                                // if (_alamatasal!.text != null) {
                                //   // EditAsal();
                                // } else {
                                //   // MoveAsal();
                                // }
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    BlocConsumer<DatapengirimCubit, DatapengirimState>(
                      listener: (context, state) {
                        if (state is TujuanSuccess) {
                          Map<String, dynamic> datapengirim =
                              jsonDecode(jsonEncode(state.result));
                          _placeidtujuan = datapengirim['_placeidtujuan'];
                          _latitude_place_tujuan =
                              datapengirim['_latitude_place_tujuan'].toString();
                          _longitude_place_tujuan =
                              datapengirim['_longitude_place_tujuan']
                                  .toString();
                          _pelabuhanidtujuan =
                              datapengirim['_pelabuhanidtujuan'];
                          _latitude_pelabuhan_tujuan =
                              datapengirim['_latitude_pelabuhan_tujuan'];
                          _longitude_pelabuhan_tujuan =
                              datapengirim['_longitude_pelabuhan_tujuan'];
                          _jarak_tujuan = datapengirim['_jarak_tujuan'];
                          _waktu_tujuan = datapengirim['_waktu_tujuan'];
                          _alamattujuan.text = datapengirim['_alamattujuan'];
                          _nama_pelabuhan_tujuan =
                              datapengirim['_nama_pelabuhan_tujuan'];
                        }
                      },
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 3.0, bottom: 8.0, left: 17.0, right: 17.0),
                          child: SizedBox(
                            height: 36.0,
                            child: TextField(
                              controller: _alamattujuan,
                              readOnly: true,
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: const InputDecoration(
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
                                if (_placeidtujuan == null) {
                                  BlocProvider.of<DatapengirimCubit>(context)
                                      .navigatorPushTujuan(
                                    route: '/tujuan',
                                  );
                                } else {
                                  BlocProvider.of<DatapengirimCubit>(context)
                                      .navigatorPushTujuan(
                                    route: '/tujuan',
                                    param: {
                                      '_placeidtujuan': _placeidtujuan,
                                      '_latitude_place_tujuan':
                                          _latitude_place_tujuan,
                                      '_longitude_place_tujuan':
                                          _longitude_place_tujuan,
                                      '_pelabuhanidtujuan': _pelabuhanidtujuan,
                                      '_latitude_pelabuhan_tujuan':
                                          _latitude_pelabuhan_tujuan,
                                      '_longitude_pelabuhan_tujuan':
                                          _longitude_pelabuhan_tujuan,
                                      '_jarak_tujuan': _jarak_tujuan,
                                      '_waktu_tujuan': _waktu_tujuan,
                                      '_alamattujuan': _alamattujuan.text,
                                      '_nama_pelabuhan_tujuan':
                                          _nama_pelabuhan_tujuan,
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    const Divider(
                      color: Color(0xFFC3C3C3),
                      thickness: 1.5,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
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
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 3.0, bottom: 8.0, left: 17.0, right: 17.0),
                      child: SizedBox(
                        height: 36.0,
                        child: DropdownSearch<MasterContainer>(
                          showAsSuffixIcons: true,
                          mode: Mode.BOTTOM_SHEET,
                          dropdownBuilder: (context, selectedcontainer) {
                            return Text(
                              selectedcontainer == null
                                  ? ""
                                  : selectedcontainer.toString(),
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                                color: selectedcontainer == null
                                    ? const Color.fromARGB(255, 114, 114, 114)
                                    : Colors.black,
                              ),
                            );
                          },
                          onFind: (String? filter) async {
                            var response = await ApiClient().dio.get(
                              "orderemkl-api/public/api/container/combokodecontainer",
                              queryParameters: {"filter": filter},
                            );
                            var models = MasterContainer.fromJsonList(
                                response.data['data']);
                            return models;
                          },
                          dropdownSearchDecoration: const InputDecoration(
                            label: Text("Container"),
                            labelStyle: TextStyle(
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
                            print(data);
                            // // print(data);
                            _container_id = data!.id;
                            // if (_placeidasal != null &&
                            //     _placeidtujuan != null &&
                            //     _container_id != null &&
                            //     _selectednilaibarang.text.isNotEmpty &&
                            //     _selectedqty.text.isNotEmpty) {
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
                            child: const Center(
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
                          top: 3.0, bottom: 8.0, left: 17.0, right: 17.0),
                      child: SizedBox(
                        height: 36.0,
                        child: TextFormField(
                          inputFormatters: [
                            CurrencyTextInputFormatter(
                                locale: 'id', decimalDigits: 0, symbol: 'Rp. ')
                          ],
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: const InputDecoration(
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
                              _isButtonDisabled!.value = false;
                            } else {
                              _isButtonDisabled!.value = true;
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
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(
                                "^(([1-9][0-9]{2})|([1-9][0-9]{1})|([1-9]))"))
                          ],
                          decoration: const InputDecoration(
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
                              _isButtonDisabled!.value = false;
                            } else {
                              _isButtonDisabled!.value = true;
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
      ),
      bottomNavigationBar: BlocProvider(
        create: (context) => OngkirBloc(),
        child: SizedBox(
          width: width,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 3.0, bottom: 8.0, left: 17.0, right: 17.0),
            child: ValueListenableBuilder(
              valueListenable: _isButtonDisabled!,
              builder: (context, value, child) {
                return BlocConsumer<OngkirBloc, OngkirState>(
                  listener: (context, state) async {
                    if (state is OngkirSuccess) {
                      components.dia!.hide();
                      await Navigator.pushNamed(context, '/harga', arguments: {
                        'origincontroller': _alamatasal.text,
                        'pelabuhanidasal': _pelabuhanidasal,
                        'jarakasal': _jarak_asal,
                        'waktuasal': _waktu_asal,
                        'destinationcontroller': _alamattujuan.text,
                        'pelabuhanidtujuan': _pelabuhanidtujuan,
                        'jaraktujuan': _jarak_tujuan,
                        'waktutujuan': _waktu_tujuan,
                        'harga': state.result['harga'],
                        'container': _container_id,
                        'nilaibarang': _selectednilaibarang.text,
                        'qty': _selectedqty.text,
                        'hargasatuan': state.result['hargasatuan'],
                      });
                    }
                  },
                  builder: (context, state) {
                    if (state is OngkirLoading) {
                      Future.delayed(const Duration(seconds: 0), () {
                        components.showDia();
                      });
                    } else if (state is OngkirFailed) {
                      Future.delayed(const Duration(seconds: 0), () {
                        components.dia!.hide();
                        components.alertBerhasilPesan(
                            "gagal",
                            state.message,
                            "assets/imgs/updated-transaction.json",
                            IconsButton(
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                              text: 'Ok',
                              iconData: Icons.done,
                              color: Colors.blue,
                              textStyle: const TextStyle(color: Colors.white),
                              iconColor: Colors.white,
                            ));
                      });
                    }
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        backgroundColor: const Color(0xFF5599E9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                      onPressed: _isButtonDisabled!.value
                          ? null
                          : () {
                              context.read<OngkirBloc>().add(CekOngkirEvent(
                                    placeidasal: _placeidasal,
                                    pelabuhanidasal: _pelabuhanidasal,
                                    latitude_pelabuhan_asal:
                                        _latitude_pelabuhan_asal,
                                    longitude_pelabuhan_asal:
                                        _longitude_pelabuhan_asal,
                                    jarak_asal: _jarak_asal,
                                    waktu_asal: _waktu_asal,
                                    placeidtujuan: _placeidtujuan,
                                    pelabuhanidtujuan: _pelabuhanidtujuan,
                                    latitude_pelabuhan_tujuan:
                                        _latitude_pelabuhan_tujuan,
                                    longitude_pelabuhan_tujuan:
                                        _longitude_pelabuhan_tujuan,
                                    jarak_tujuan: _jarak_tujuan,
                                    waktu_tujuan: _waktu_tujuan,
                                    container_id: _container_id,
                                    nilaibarang_asuransi: int.parse(
                                            _selectednilaibarang.text
                                                .substring(4)
                                                .replaceAll('.', ''))
                                        .toString(),
                                    qty: _selectedqty.text,
                                    key: ApiClient().apiKey,
                                  ));
                            },
                      child: const Padding(
                          padding: EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 12, bottom: 12),
                          child: Text("Cek Ongkir",
                              style: TextStyle(fontSize: 14.0))),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
