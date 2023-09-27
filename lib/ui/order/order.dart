import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:dropdown_search/dropdown_search.dart';
// import 'package:now_ui_flutter/globals.dart' as globals;
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:tasorderan/bloc/pesanan/ongkir/ongkir/ongkir_bloc.dart';
import 'package:tasorderan/bloc/pesanan/pesanan/dataorder/dataorder_cubit.dart';
import 'package:tasorderan/components/components.dart';
import 'package:tasorderan/core/api_client.dart';
import 'package:tasorderan/models/pesanan_models.dart';

class Order extends StatefulWidget {
  const Order({
    Key? key,
  }) : super(key: key);
  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  Size? size;
  double? height;
  double? width;

  //Data Asal
  String? _placeidasal;
  String? _latitude_place_asal;
  String? _longitude_place_asal;
  String? _pelabuhanidasal;
  String? _latitude_pelabuhan_asal;
  String? _longitude_pelabuhan_asal;
  String? _jarak_asal;
  String? _waktu_asal;
  final _alamatasal = TextEditingController();
  String? notepengirim;
  String? namapelabuhanpengirim;
  String? merchantId;
  String? merchantPassword;
  String? pengirim;
  String? notelppengirim;
  //Data Asal

  //Data Tujuan
  String? _placeidtujuan;
  String? _latitude_place_tujuan;
  String? _longitude_place_tujuan;
  String? _pelabuhanidtujuan;
  String? _latitude_pelabuhan_tujuan;
  String? _longitude_pelabuhan_tujuan;
  String? _jarak_tujuan;
  String? _waktu_tujuan;
  final _alamattujuan = TextEditingController();
  String? notepenerima;
  String? namapelabuhanpenerima;
  String? penerima;
  String? notelppenerima;
  //Data Tujuan

  //Lain-lain
  int? _container_id;
  // String _selectedpelayaran;
  final _selectedqty = TextEditingController(text: '1');
  final _selectednilaibarang = TextEditingController();
  final _selectedketerangantambahan = TextEditingController();
  final _selectednamabarang = TextEditingController();
  final _selectedjenisbarang = TextEditingController();
  //Lain-lain
  ValueNotifier<bool>? _isButtonDisabled;
  final components = Tools();

  @override
  void initState() {
    super.initState();
    _isButtonDisabled = ValueNotifier<bool>(true);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size!.height;
    width = size!.width;
    return Scaffold(
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
      backgroundColor: const Color(0xFFF1F1EF),
      body: BlocProvider(
        create: (context) => DataorderCubit(),
        child: ListView(
          children: [
            tracking(),
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
                      padding:
                          EdgeInsets.only(left: 17.0, top: 7.0, right: 17.0),
                      child: Text(
                        "Lokasi Muat",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Nunito-Medium',
                        ),
                      ),
                    ),
                    BlocConsumer<DataorderCubit, DataorderState>(
                      listener: (context, state) {
                        if (state is DataorderAsalSuccess) {
                          Map<String, dynamic> dataorderpengirim =
                              jsonDecode(jsonEncode(state.result));
                          _placeidasal = dataorderpengirim["_placeidasal"];
                          _latitude_place_asal =
                              dataorderpengirim["_latitude_place_asal"];
                          _longitude_place_asal =
                              dataorderpengirim["_longitude_place_asal"];
                          _pelabuhanidasal =
                              dataorderpengirim["_pelabuhanidasal"];
                          _latitude_pelabuhan_asal =
                              dataorderpengirim["_latitude_pelabuhan_asal"];
                          _longitude_pelabuhan_asal =
                              dataorderpengirim["_longitude_pelabuhan_asal"];
                          _jarak_asal = dataorderpengirim["_jarak_asal"];
                          _waktu_asal = dataorderpengirim["_waktu_asal"];
                          _alamatasal.text = dataorderpengirim["_alamatasal"];
                          pengirim = dataorderpengirim["pengirim"];
                          notelppengirim = dataorderpengirim["notelppengirim"];
                          notepengirim = dataorderpengirim["notepengirim"];
                          namapelabuhanpengirim =
                              dataorderpengirim["namapelabuhanpengirim"];
                          merchantId = dataorderpengirim["merchant_id"];
                          merchantPassword =
                              dataorderpengirim["merchant_password"];
                        }
                      },
                      builder: (context, state) {
                        if (state is DataorderAsalFailed) {
                          print("gagal");
                        }
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
                                hintText: 'Masukkan Data Pengirim',
                                hintStyle: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onTap: () {
                                if (_placeidasal == null) {
                                  BlocProvider.of<DataorderCubit>(context)
                                      .pushAsal(route: '/asal_order');
                                } else {
                                  BlocProvider.of<DataorderCubit>(context)
                                      .pushAsal(
                                    route: '/asal_order',
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
                                      'pengirim': pengirim,
                                      'notelppengirim': notelppengirim,
                                      'notepengirim': notepengirim,
                                      'namapelabuhanpengirim':
                                          namapelabuhanpengirim,
                                      'merchant_id': merchantId,
                                      'merchant_password': merchantPassword,
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.only(left: 17.0, top: 3.0, right: 17.0),
                      child: Text(
                        "Lokasi Bongkar",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Nunito-Medium',
                        ),
                      ),
                    ),
                    BlocConsumer<DataorderCubit, DataorderState>(
                      listener: (context, state) {
                        if (state is DataorderTujuanSuccess) {
                          Map<String, dynamic> dataorderpenerima =
                              jsonDecode(jsonEncode(state.result));
                          _placeidtujuan = dataorderpenerima["_placeidtujuan"];
                          _latitude_place_tujuan =
                              dataorderpenerima["_latitude_place_tujuan"];
                          _longitude_place_tujuan =
                              dataorderpenerima["_longitude_place_tujuan"];
                          _pelabuhanidtujuan =
                              dataorderpenerima["_pelabuhanidtujuan"];
                          _latitude_pelabuhan_tujuan =
                              dataorderpenerima["_latitude_pelabuhan_tujuan"];
                          _longitude_pelabuhan_tujuan =
                              dataorderpenerima["_longitude_pelabuhan_tujuan"];
                          _jarak_tujuan = dataorderpenerima["_jarak_tujuan"];
                          _waktu_tujuan = dataorderpenerima["_waktu_tujuan"];
                          _alamattujuan.text =
                              dataorderpenerima["_alamattujuan"];
                          penerima = dataorderpenerima["penerima"];
                          notelppenerima = dataorderpenerima["notelppenerima"];
                          notepenerima = dataorderpenerima["notepenerima"];
                          namapelabuhanpenerima =
                              dataorderpenerima["namapelabuhanpenerima"];
                        }
                      },
                      builder: (context, state) {
                        if (state is DataorderTujuanFailed) {
                          print("gagal");
                        }
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
                                hintText: 'Masukkan Data Penerima',
                                hintStyle: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onTap: () {
                                if (_placeidtujuan == null) {
                                  BlocProvider.of<DataorderCubit>(context)
                                      .pushTujuan(route: '/tujuan_order');
                                } else {
                                  BlocProvider.of<DataorderCubit>(context)
                                      .pushTujuan(
                                    route: '/tujuan_order',
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
                                      'penerima': penerima,
                                      'notelppenerima': notelppenerima,
                                      'notepenerima': notepenerima,
                                      'namapelabuhanpenerima':
                                          namapelabuhanpenerima,
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
                      padding:
                          EdgeInsets.only(left: 17.0, top: 3.0, right: 17.0),
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
                          dropdownBuilder: (context, selectedcontainer) {
                            return Text(
                              selectedcontainer == null
                                  ? "Masukkan Container"
                                  : selectedcontainer.toString(),
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: selectedcontainer == null
                                    ? const Color.fromARGB(255, 114, 114, 114)
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
                          onFind: (String? filter) async {
                            var response = await ApiClient().dio.get(
                              "orderemkl-api/public/api/container/combokodecontainer",
                              queryParameters: {"filter": filter},
                            );
                            var models = MasterContainer.fromJsonList(
                                response.data['data']);
                            return models;
                          },
                          onChanged: (data) {
                            _container_id = data!.id!;
                            if (_placeidasal != null &&
                                _placeidtujuan != null &&
                                _container_id != null &&
                                _selectednilaibarang.text.isNotEmpty &&
                                _selectedqty.text.isNotEmpty &&
                                _selectedjenisbarang.text.isNotEmpty &&
                                _selectednamabarang.text.isNotEmpty) {
                              _isButtonDisabled!.value = false;
                            } else {
                              _isButtonDisabled!.value = true;
                            }
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
                    const Padding(
                      padding:
                          EdgeInsets.only(left: 17.0, top: 4.0, right: 17.0),
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
                            if (_placeidasal != null &&
                                _placeidtujuan != null &&
                                _container_id != null &&
                                _selectednilaibarang.text.isNotEmpty &&
                                _selectedqty.text.isNotEmpty &&
                                _selectedjenisbarang.text.isNotEmpty &&
                                _selectednamabarang.text.isNotEmpty) {
                              _isButtonDisabled!.value = false;
                            } else {
                              _isButtonDisabled!.value = true;
                            }
                          },
                        ),
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.only(left: 17.0, top: 4.0, right: 17.0),
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
                            hintText: 'Qty',
                            border: OutlineInputBorder(),
                          ),
                          controller: _selectedqty,
                          onChanged: (val) {
                            if (_placeidasal != null &&
                                _placeidtujuan != null &&
                                _container_id != null &&
                                _selectednilaibarang.text.isNotEmpty &&
                                _selectedqty.text.isNotEmpty &&
                                _selectedjenisbarang.text.isNotEmpty &&
                                _selectednamabarang.text.isNotEmpty) {
                              _isButtonDisabled!.value = false;
                            } else {
                              _isButtonDisabled!.value = true;
                            }
                          },
                        ),
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.only(left: 17.0, top: 4.0, right: 17.0),
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
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.view_list,
                                color: Color(0xFF5599E9),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 0.0),
                              hintText: 'Jenis Barang',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.text,
                            controller: _selectedjenisbarang,
                            inputFormatters: [
                              UpperCaseTextFormatter(),
                            ],
                            onChanged: (val) {
                              if (_placeidasal != null &&
                                  _placeidtujuan != null &&
                                  _container_id != null &&
                                  _selectednilaibarang.text.isNotEmpty &&
                                  _selectedqty.text.isNotEmpty &&
                                  _selectedjenisbarang.text.isNotEmpty &&
                                  _selectednamabarang.text.isNotEmpty) {
                                _isButtonDisabled!.value = false;
                              } else {
                                _isButtonDisabled!.value = true;
                              }
                            },
                            textCapitalization: TextCapitalization.sentences),
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.only(left: 17.0, top: 4.0, right: 17.0),
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
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.view_list,
                                color: Color(0xFF5599E9),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 0.0),
                              hintText: 'Nama Barang',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.text,
                            controller: _selectednamabarang,
                            inputFormatters: [
                              UpperCaseTextFormatter(),
                            ],
                            onChanged: (val) {
                              if (_placeidasal != null &&
                                  _placeidtujuan != null &&
                                  _container_id != null &&
                                  _selectednilaibarang.text.isNotEmpty &&
                                  _selectedqty.text.isNotEmpty &&
                                  _selectedjenisbarang.text.isNotEmpty &&
                                  _selectednamabarang.text.isNotEmpty) {
                                _isButtonDisabled!.value = false;
                              } else {
                                _isButtonDisabled!.value = true;
                              }
                            },
                            textCapitalization: TextCapitalization.sentences),
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.only(left: 17.0, top: 4.0, right: 17.0),
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
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 0.0),
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
      ),
      bottomNavigationBar: BlocProvider(
        create: (context) => OngkirBloc(),
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 3.0, bottom: 8.0, left: 17.0, right: 17.0),
            child: ValueListenableBuilder(
              valueListenable: _isButtonDisabled!,
              builder: (context, value, index) {
                return BlocConsumer<OngkirBloc, OngkirState>(
                  listener: (context, state) async {
                    if (state is OngkirSuccess) {
                      components.dia!.hide();
                      await Navigator.pushNamed(
                        context,
                        '/total',
                        arguments: {
                          'origincontroller': _alamatasal.text,
                          'placeidasal': _placeidasal,
                          'pelabuhanidasal': _pelabuhanidasal,
                          'latitude_pelabuhan_asal': _latitude_pelabuhan_asal,
                          'longitude_pelabuhan_asal': _longitude_pelabuhan_asal,
                          'jarakasal': _jarak_asal,
                          'waktuasal': _waktu_asal,
                          'namapengirim': pengirim,
                          'notelppengirim': notelppengirim,
                          // 'alamatdetailpengirim': alamat
                          'notepengirim': notepengirim,
                          'destinationcontroller': _alamattujuan.text,
                          'placeidtujuan': _placeidtujuan,
                          'pelabuhanidtujuan': _pelabuhanidtujuan,
                          'latitude_pelabuhan_tujuan':
                              _latitude_pelabuhan_tujuan,
                          'longitude_pelabuhan_tujuan':
                              _latitude_pelabuhan_tujuan,
                          'jaraktujuan': _jarak_tujuan,
                          'waktutujuan': _waktu_tujuan,
                          'namapenerima': penerima,
                          'notelppenerima': notelppenerima,
                          // 'alamatdetailpenerima':
                          'notepenerima': notepenerima,
                          'container_id': _container_id,
                          'nilaibarang': _selectednilaibarang.text,

                          'nilaibarang_asuransi': int.parse(_selectednilaibarang
                              .text
                              .substring(4)
                              .replaceAll('.', '')),
                          'harga': state.result['harga'],
                          'qty': _selectedqty.text,
                          'jenisbarang': _selectedjenisbarang.text,
                          'namabarang': _selectednamabarang.text,
                          'hargasatuan': state.result['hargasatuan'],
                          'keterangantambahan':
                              _selectedketerangantambahan.text,
                          'namapelabuhanpengirim': namapelabuhanpengirim,
                          'namapelabuhanpenerima': namapelabuhanpenerima,
                          'merchant_id': merchantId,
                          'merchant_password': merchantPassword,
                        },
                      );
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
                          ),
                        );
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
                      onPressed: value
                          ? null
                          : () async {
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
                          child:
                              Text("Order", style: TextStyle(fontSize: 14.0))),
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
