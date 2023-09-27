import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tasorderan/components/components.dart';
import 'package:tasorderan/core/api_client.dart';
import 'package:tasorderan/core/session_manager.dart';
import 'package:tasorderan/models/pesanan_models.dart';
// import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class Total extends StatefulWidget {
  const Total({
    Key? key,
  }) : super(key: key);
  @override
  State<Total> createState() => _TotalState();
}

class _TotalState extends State<Total> {
  String? _selectedpembayaran;
  ValueNotifier<int>? isSyarat;
  //bool syarat
  ValueNotifier<bool>? _isSyarat;
  ValueNotifier<bool>? _isButtondisabled;
  final components = Tools();

  String? origincontroller;
  String? placeidasal;
  String? pelabuhanidasal;
  String? latitude_pelabuhan_asal;
  String? longitude_pelabuhan_asal;
  String? jarakasal;
  String? waktuasal;
  String? namapengirim;
  String? notelppengirim;
  String? alamatdetailpengirim;
  String? notepengirim;
  String? namapelabuhanpengirim;
  //
  String? destinationcontroller;
  String? placeidtujuan;
  String? pelabuhanidtujuan;
  String? latitude_pelabuhan_tujuan;
  String? longitude_pelabuhan_tujuan;
  String? jaraktujuan;
  String? waktutujuan;
  String? namapenerima;
  String? notelppenerima;
  String? alamatdetailpenerima;
  String? notepenerima;
  String? namapelabuhanpenerima;
  //
  int? container_id;
  String? nilaibarang;
  int? nilaibarang_asuransi;
  String? harga;
  String? qty;
  String? jenisbarang;
  String? namabarang;
  String? hargasatuan;
  String? keterangantambahan;
  String? merchantId;
  String? merchantPassword;

  void initState() {
    super.initState();
    isSyarat = ValueNotifier<int>(0);
    _isSyarat = ValueNotifier<bool>(false);
    _isButtondisabled = ValueNotifier<bool>(true);
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    origincontroller = args!["origincontroller"];
    placeidasal = args["placeidasal"];
    pelabuhanidasal = args["pelabuhanidasal"];
    latitude_pelabuhan_asal = args["latitude_pelabuhan_asal"];
    longitude_pelabuhan_asal = args["longitude_pelabuhan_asal"];
    jarakasal = args["jarakasal"];
    waktuasal = args["waktuasal"];
    namapengirim = args["namapengirim"];
    notelppengirim = args["notelppengirim"];
    notepengirim = args["notepengirim"];
    destinationcontroller = args["destinationcontroller"];
    placeidtujuan = args["placeidtujuan"];
    pelabuhanidtujuan = args["pelabuhanidtujuan"];
    latitude_pelabuhan_tujuan = args["latitude_pelabuhan_tujuan"];
    longitude_pelabuhan_tujuan = args["longitude_pelabuhan_tujuan"];
    jaraktujuan = args["jaraktujuan"];
    waktutujuan = args["waktutujuan"];
    namapenerima = args["namapenerima"];
    notelppenerima = args["notelppenerima"];
    notepenerima = args["notepenerima"];
    container_id = args["container_id"];
    nilaibarang = args["nilaibarang"];

    nilaibarang_asuransi = args["nilaibarang_asuransi"];
    harga = args["harga"];
    qty = args["qty"];
    jenisbarang = args["jenisbarang"];
    namabarang = args["namabarang"];
    hargasatuan = args["hargasatuan"];
    keterangantambahan = args["keterangantambahan"];
    namapelabuhanpengirim = args["namapelabuhanpengirim"];
    namapelabuhanpenerima = args["namapelabuhanpenerima"];
    merchantId = args["merchant_id"];
    merchantPassword = args["merchant_password"];
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
          "Total Harga",
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
      body: ListView(
        children: [
          tracking(),
          Column(
            children: <Widget>[
              const SizedBox(height: 15.0),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                            origincontroller!,
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
                                  'Note Pengirim',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Color(0xFF666666),
                                    fontFamily: 'Nunito-Medium',
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                            notepengirim!,
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
                                  'Nama Pengirim',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Color(0xFF666666),
                                    fontFamily: 'Nunito-Medium',
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                            namapengirim!,
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
                                  'No. Telepon',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Color(0xFF666666),
                                    fontFamily: 'Nunito-Medium',
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                            notelppengirim!,
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
                                  'Pelabuhan',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Color(0xFF666666),
                                    fontFamily: 'Nunito-Medium',
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                        child: Text(
                                      namapelabuhanpengirim!,
                                      style: const TextStyle(
                                        fontFamily: 'Nunito-Medium',
                                        fontWeight: FontWeight.bold,
                                      ),
                                      softWrap: true,
                                    )),
                                  ],
                                  // ],
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
                                  'Jarak',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Color(0xFF666666),
                                    fontFamily: 'Nunito-Medium',
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                        child: Text(
                                      jarakasal!,
                                      style: const TextStyle(
                                        fontFamily: 'Nunito-Medium',
                                        fontWeight: FontWeight.bold,
                                      ),
                                      softWrap: true,
                                    )),
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
              const SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
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
                                  'Lokasi Bongkar',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Color(0xFF666666),
                                    fontFamily: 'Nunito-Medium',
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                            destinationcontroller!,
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
                                  'Note Penerima',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Color(0xFF666666),
                                    fontFamily: 'Nunito-Medium',
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                            notepenerima!,
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
                                  'Nama Penerima',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Color(0xFF666666),
                                    fontFamily: 'Nunito-Medium',
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                            namapenerima!,
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
                                  'No. Telepon',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Color(0xFF666666),
                                    fontFamily: 'Nunito-Medium',
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                            notelppenerima!,
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
                                  'Pelabuhan',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Color(0xFF666666),
                                    fontFamily: 'Nunito-Medium',
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                        child: Text(
                                      namapelabuhanpenerima!,
                                      style: const TextStyle(
                                        fontFamily: 'Nunito-Medium',
                                        fontWeight: FontWeight.bold,
                                      ),
                                      softWrap: true,
                                    )),
                                  ],
                                  // ],
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
                                  'Jarak',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Color(0xFF666666),
                                    fontFamily: 'Nunito-Medium',
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                        child: Text(
                                      jaraktujuan!,
                                      style: const TextStyle(
                                        fontFamily: 'Nunito-Medium',
                                        fontWeight: FontWeight.bold,
                                      ),
                                      softWrap: true,
                                    )),
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
              const SizedBox(height: 15.0),
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
                                // Wrap this column inside an expanded widget so that framework allocates max width for this column inside this row
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text(
                                  'Container',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Color(0xFF666666),
                                    fontFamily: 'Nunito-Medium',
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    if (container_id! == 1) ...[
                                      const Expanded(
                                          child: Text(
                                        "20 ft",
                                        style: TextStyle(
                                          fontFamily: 'Nunito-Medium',
                                          fontWeight: FontWeight.bold,
                                        ),
                                        softWrap: true,
                                      )),
                                    ] else if (container_id == 2) ...[
                                      const Expanded(
                                        child: Text(
                                          "40 ft",
                                          style: TextStyle(
                                            fontFamily: 'Nunito-Medium',
                                            fontWeight: FontWeight.bold,
                                          ),
                                          softWrap: true,
                                        ),
                                      ),
                                    ],
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
                                  'Nilai Barang (Asuransi)',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Color(0xFF666666),
                                    fontFamily: 'Nunito-Medium',
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                        child: Text(
                                      nilaibarang!,
                                      style: const TextStyle(
                                        fontFamily: 'Nunito-Medium',
                                        fontWeight: FontWeight.bold,
                                      ),
                                      softWrap: true,
                                    )),
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
                                  'Jenis Barang',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Color(0xFF666666),
                                    fontFamily: 'Nunito-Medium',
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                        child: Text(
                                      jenisbarang!,
                                      style: const TextStyle(
                                        fontFamily: 'Nunito-Medium',
                                        fontWeight: FontWeight.bold,
                                      ),
                                      softWrap: true,
                                    )),
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
                                  'Nama Barang',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Color(0xFF666666),
                                    fontFamily: 'Nunito-Medium',
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                        child: Text(
                                      namabarang!,
                                      style: const TextStyle(
                                        fontFamily: 'Nunito-Medium',
                                        fontWeight: FontWeight.bold,
                                      ),
                                      softWrap: true,
                                    )),
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
                                  'Keterangan Tambahan',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Color(0xFF666666),
                                    fontFamily: 'Nunito-Medium',
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                        child: Text(
                                      keterangantambahan!,
                                      style: const TextStyle(
                                        fontFamily: 'Nunito-Medium',
                                        fontWeight: FontWeight.bold,
                                      ),
                                      softWrap: true,
                                    )),
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
                                  'Qty',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Color(0xFF666666),
                                    fontFamily: 'Nunito-Medium',
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                        child: Text(
                                      qty!,
                                      style: const TextStyle(
                                        fontFamily: 'Nunito-Medium',
                                        fontWeight: FontWeight.bold,
                                      ),
                                      softWrap: true,
                                    )),
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
                                  'Harga Satuan',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Color(0xFF666666),
                                    fontFamily: 'Nunito-Medium',
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                        child: Text(
                                      hargasatuan!,
                                      style: const TextStyle(
                                        fontFamily: 'Nunito-Medium',
                                        fontWeight: FontWeight.bold,
                                      ),
                                      softWrap: true,
                                    )),
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
                                  'Total',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Color(0xFF666666),
                                    fontFamily: 'Nunito-Medium',
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                        child: Text(
                                      harga!,
                                      style: const TextStyle(
                                        fontFamily: 'Nunito-Medium',
                                        fontWeight: FontWeight.bold,
                                      ),
                                      softWrap: true,
                                    )),
                                  ],
                                ),
                              ],
                            )),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: SizedBox(
                        height: 40,
                        child: DropdownSearch<Pembayaran>(
                          showAsSuffixIcons: true,
                          mode: Mode.BOTTOM_SHEET,
                          // items: _datacontainer,
                          dropdownSearchDecoration: const InputDecoration(
                            hintText: "Pembayaran",
                            hintStyle: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                            ),
                            prefixIcon: Icon(
                              Icons.credit_card_rounded,
                              color: Color(0xFF5599E9),
                            ),
                            contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                            border: OutlineInputBorder(),
                          ),
                          dropdownBuilder: (context, selectedpembayaran) {
                            return Text(
                              selectedpembayaran == null
                                  ? "Pembayaran"
                                  : selectedpembayaran.toString(),
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                                color: selectedpembayaran == null
                                    ? const Color.fromARGB(255, 114, 114, 114)
                                    : Colors.black,
                              ),
                            );
                          },
                          onFind: (String? filter) async {
                            var response = await ApiClient().dio.get(
                                  '/orderemkl-api/public/api/faspay/listofpayment',
                                  queryParameters: {"filter": filter},
                                  options: Options(
                                    headers: {
                                      'Accept': 'application/json',
                                      'Content-type': 'application/json',
                                      'Authorization':
                                          'Bearer ${SessionManager().getActiveToken()}',
                                    },
                                  ),
                                );
                            var models = Pembayaran.fromJsonList(
                                jsonDecode(response.data)['payment_channel']);
                            return models;
                          },
                          onChanged: (data) {
                            _selectedpembayaran = data!.pg_code!;
                            if (_selectedpembayaran == null && isSyarat == 0) {
                              _isButtondisabled!.value = false;
                            } else {
                              _isButtondisabled!.value = true;
                            }
                          },
                          showSearchBox: true,
                          searchFieldProps: TextFieldProps(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                              labelText: "Cari Pembayaran",
                            ),
                          ),
                          popupTitle: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorDark,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(0),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Pembayaran',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          popupShape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 35.0),
                    child: ValueListenableBuilder(
                      valueListenable: _isSyarat!,
                      builder: (context, value, index) {
                        return Checkbox(
                          activeColor: const Color(0xFF5599E9),
                          value: value,
                          onChanged: (bool? value) {
                            _isSyarat!.value = value!;
                            if (value == false) {
                              isSyarat!.value = 0;
                            } else {
                              isSyarat!.value = 1;
                            }
                            print(_selectedpembayaran);
                            if (_selectedpembayaran == null && isSyarat == 0) {
                              _isButtondisabled!.value = true;
                            } else {
                              _isButtondisabled!.value = false;
                            }
                          },
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 2.0, bottom: 15.0, right: 8.0, left: 0.0),
                      child: RichText(
                        text: TextSpan(
                          // Note: Styles for TextSpans must be explicitly defined.
                          // Child text spans will inherit styles from parent
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            const TextSpan(
                                text:
                                    'Dengan menyetujui pesanan sesuai dengan data informasi yang benar, anda setuju untuk '),
                            TextSpan(
                                text: '',
                                style: const TextStyle(
                                    color: Color(0xFF5599E9),
                                    decoration: TextDecoration.underline),
                                children: [
                                  TextSpan(
                                    text:
                                        'Syarat dan Ketentuan dan Pernyataan Privasi ',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => components.bottomSheet(),
                                  )
                                ]),
                            const TextSpan(text: 'kami.'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
        // ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 40.0,
          padding: const EdgeInsets.only(
              left: 8.0, bottom: 5.0, top: 0.0, right: 8.0),
          child: ValueListenableBuilder(
            valueListenable: _isButtondisabled!,
            builder: (context, value, index) {
              return ElevatedButton(
                onPressed: value
                    ? null
                    : () async {
                        //  && isSyarat != 0
                        // if (_selectedpembayaran == null) {
                        //   await globals.alert(context, 'Pembayaran tidak boleh kosong');
                        // } else if (isSyarat == 0) {
                        //   await globals.alert(
                        //       context, 'Mohon menyetujui syarat dan ketentuan');
                        // } else {
                        //   // print("asdf");
                        //   _showDialog(context, SimpleFontelicoProgressDialogType.normal,
                        //       'Normal');
                        //   Future.delayed(const Duration(milliseconds: 2000), () {
                        //     // Navigator.pushNamed(context, '/payment_success');
                        //     BayarFunction(
                        //       widget.placeidasal,
                        //       widget.pelabuhanidasal,
                        //       widget.latitude_pelabuhan_asal,
                        //       widget.longitude_pelabuhan_asal,
                        //       widget.jarakasal,
                        //       widget.waktuasal,
                        //       widget.namapengirim,
                        //       widget.notelppengirim,
                        //       widget.origincontroller,
                        //       widget.placeidtujuan,
                        //       widget.pelabuhanidtujuan,
                        //       widget.latitude_pelabuhan_tujuan,
                        //       widget.longitude_pelabuhan_tujuan,
                        //       widget.jaraktujuan,
                        //       widget.waktutujuan,
                        //       widget.namapenerima,
                        //       widget.notelppenerima,
                        //       widget.destinationcontroller,
                        //       widget.container_id,
                        //       widget.nilaibarang_asuransi,
                        //       widget.harga,
                        //       widget.qty,
                        //       widget.jenisbarang,
                        //       widget.namabarang,
                        //       widget.keterangantambahan,
                        //       _selectedpembayaran,
                        //       globals.loggedinId,
                        //       widget.notepengirim,
                        //       widget.notepenerima,
                        //       isSyarat,
                        //     );
                        //   });
                        // }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5599E9),
                ),
                child: const Text(
                  "Pesan",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Nunito-Medium',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
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
              backgroundColor: Color(0xFF5599E9),
              child: Text(
                '2',
                style: TextStyle(
                  color: Colors.white,
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

  // Future<void> _goToPlace(
  //   double lat_origin,
  //   double lng_origin,
  //   double lat_destination,
  //   double lng_destination,
  //   String totalDistance,
  //   String totalDuration,
  //   Map<String, dynamic> boundsNe,
  //   Map<String, dynamic> boundsSw,
  // ) async {
  //   // final double lat = place['geometry']['location']['lat'];
  //   // final double lng = place['geometry']['location']['lng'];
  //   // double totalDistance = 0;
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //     target: LatLng(lat_origin, lng_origin),
  //     zoom: 12,
  //   )));

  //   controller.animateCamera(CameraUpdate.newLatLngBounds(
  //       LatLngBounds(
  //         southwest: LatLng(boundsSw['lat'], boundsSw['lng']),
  //         northeast: LatLng(boundsNe['lat'], boundsNe['lng']),
  //       ),
  //       25));
  //   setState(() {
  //     distance = totalDistance;
  //     duration = totalDuration;
  //   });
  //   _setMarker(LatLng(lat_origin, lng_origin),
  //       LatLng(lat_destination, lng_destination), distance);
  //   // _setMarkerDestination(LatLng(lat_destination, lng_destination));
  // }

  // Widget alertBerhasilPesan() {
  //   Dialogs.materialDialog(
  //       color: Colors.white,
  //       msg:
  //           'Anda belum bisa melakukan pemesanan orderan,silahkan menyelesaikan pembayaran yang sebelum terlebih dahulu',
  //       title: 'Gagal',
  //       lottieBuilder: Lottie.asset(
  //         'assets/imgs/updated-transaction.json',
  //         fit: BoxFit.contain,
  //       ),
  //       context: context,
  //       actions: [
  //         IconsButton(
  //           onPressed: () {
  //             Navigator.pop(context);
  //           },
  //           text: 'Ok',
  //           iconData: Icons.done,
  //           color: Colors.blue,
  //           textStyle: TextStyle(color: Colors.white),
  //           iconColor: Colors.white,
  //         ),
  //       ]);
  // }

  // Widget alert() {
  //   showModalBottomSheet(
  //       isScrollControlled: true,
  //       context: context,
  //       builder: (context) {
  //         return FractionallySizedBox(
  //           heightFactor: 0.9,
  //           child: Scaffold(
  //             appBar: PreferredSize(
  //               preferredSize: Size.fromHeight(100.0),
  //               child: AppBar(
  //                 backgroundColor: Colors.transparent,
  //                 elevation: 0,
  //                 automaticallyImplyLeading: false,
  //                 titleSpacing: 15.0,
  //                 title: Padding(
  //                   padding: const EdgeInsets.only(top: 8.0),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         "Syarat dan Ketentuan",
  //                         style: TextStyle(
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 25.0,
  //                           color: Colors.black,
  //                         ),
  //                       ),
  //                       Text(
  //                         "Last Updated 12 Juli 2022",
  //                         style: TextStyle(
  //                           fontSize: 15.0,
  //                           color: Colors.grey,
  //                           fontFamily: 'Nunito-Medium',
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 bottom: PreferredSize(
  //                   preferredSize: Size.fromHeight(0.0),
  //                   child: Divider(
  //                     color: Color.fromARGB(255, 145, 145, 145),
  //                     indent: 0,
  //                     endIndent: 0,
  //                     height: 10.0,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             body: SingleChildScrollView(
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: <Widget>[
  //                   Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: <Widget>[
  //                         Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Text(
  //                             "Adapun Harga tersebut diatas berlaku dengan kondisi sebagai berikut:",
  //                             style: TextStyle(fontWeight: FontWeight.bold),
  //                           ),
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.all(10.0),
  //                           child: Column(
  //                             children: <Widget>[
  //                               Padding(
  //                                 padding: const EdgeInsets.all(8.0),
  //                                 child: Text(
  //                                   "1. HARGA BELUM TERMASUK BIAYA KAWAL (JIKA ADA)",
  //                                   style: TextStyle(
  //                                     fontFamily: 'Nunito-Medium',
  //                                   ),
  //                                 ),
  //                               ),
  //                               Padding(
  //                                 padding: const EdgeInsets.all(8.0),
  //                                 child: Text(
  //                                   "2. BELUM TERMASUK BIAYA BONGKAR MUAT DI LOKASI STUFFING / STRIPPING",
  //                                   style: TextStyle(
  //                                     fontFamily: 'Nunito-Medium',
  //                                   ),
  //                                 ),
  //                               ),
  //                               Padding(
  //                                 padding: const EdgeInsets.all(8.0),
  //                                 child: Text(
  //                                   "3. BERLAKU UNTUK LOKASI YANG DAPAT MASUK CONTAINER ATAU TRAILER TANPA ADA LARANGAN (TIDAK TERMASUK UANG KAWAL)",
  //                                   style: TextStyle(
  //                                     fontFamily: 'Nunito-Medium',
  //                                   ),
  //                                 ),
  //                               ),
  //                               Padding(
  //                                 padding: const EdgeInsets.all(8.0),
  //                                 child: Text(
  //                                   "4. MUATAN MAKSIMUM PETI KEMAS BESERTA ISINYA (BRUTTO) ADALAH 23 TON (20') & 26 TON (40').",
  //                                   style: TextStyle(
  //                                     fontFamily: 'Nunito-Medium',
  //                                   ),
  //                                 ),
  //                               ),
  //                               Padding(
  //                                 padding: const EdgeInsets.all(8.0),
  //                                 child: Text(
  //                                   "5. FREETIME STORAGE DAN DEMURRAGE ADALAH 3 (TIGA) HARI DI TEMPAT TUJUAN (PEMBONGKARAN), APABILA LEBIH DARI 3 (TIGA) HARI MAKA SEGALA BIAYA DILUAR TANGGUNG JAWAB EKSPEDISI.",
  //                                   style: TextStyle(
  //                                     fontFamily: 'Nunito-Medium',
  //                                   ),
  //                                 ),
  //                               ),
  //                               Padding(
  //                                 padding: const EdgeInsets.all(8.0),
  //                                 child: Text(
  //                                   "6. EKSPEDISI TIDAK BERTANGGUNG JAWAB ATAS KERUGIAN AKIBAT FORCE MAJEUR (BENCANA ALAM), HURU - HARA, PERAMPOKAN, KERUSUHAN, PENJARAHAN / PEMBAJAKAN.",
  //                                   style: TextStyle(
  //                                     fontFamily: 'Nunito-Medium',
  //                                   ),
  //                                 ),
  //                               ),
  //                               Padding(
  //                                 padding: const EdgeInsets.all(8.0),
  //                                 child: Text(
  //                                   "7. EKSPEDISI TIDAK BERTANGGUNG JAWAB ATAS KEHILANGAN BARANG, KEKURANGAN, JIKA SEAL / PENGAMAN DALAM KEADAAN BAGUS.",
  //                                   style: TextStyle(
  //                                     fontFamily: 'Nunito-Medium',
  //                                   ),
  //                                 ),
  //                               ),
  //                               Padding(
  //                                 padding: const EdgeInsets.all(8.0),
  //                                 child: Text(
  //                                   "8. EKSPEDISI TIDAK BERTANGGUNG JAWAB ATAS PERUBAHAN KUALITAS BARANG DIKARENAKAN OLEH SIFAT BARANG ITU.",
  //                                   style: TextStyle(
  //                                     fontFamily: 'Nunito-Medium',
  //                                   ),
  //                                 ),
  //                               ),
  //                               Padding(
  //                                 padding: const EdgeInsets.all(8.0),
  //                                 child: Text(
  //                                   "9. DIANJURKAN PIHAK SHIPPER UNTUK MENGASURANSIKAN BARANGNYA DALAM KEADAAN ALL RISK WARE HOUSE TO WARE HOUSE.",
  //                                   style: TextStyle(
  //                                     fontFamily: 'Nunito-Medium',
  //                                   ),
  //                                 ),
  //                               ),
  //                               Padding(
  //                                 padding: const EdgeInsets.all(8.0),
  //                                 child: Text(
  //                                   "10. MUATAN TIDAK BOLEH BERAT SEBELAH, APABILA TERJADI MAKA SEGALA BIAYA DITANGGUNG PEMILIK BARANG.",
  //                                   style: TextStyle(
  //                                     fontFamily: 'Nunito-Medium',
  //                                   ),
  //                                 ),
  //                               ),
  //                               Padding(
  //                                 padding: const EdgeInsets.all(8.0),
  //                                 child: Text(
  //                                   "11.PEMILIK BARANG BERTANGGUNG JAWAB TERHADAP ISI MUATAN DARI AKIBAT HUKUM YANG TIMBUL DENGAN MEMBEBASKAN PERUSAHAAN PENGANGKUTAN DARI SEGALA INSTANSI YANG BERSANGKUTAN DAN BERSEDIA MENANGGUNG SEGALA BIAYA KERUGIAN YANG TIMBUL.",
  //                                   style: TextStyle(
  //                                     fontFamily: 'Nunito-Medium',
  //                                   ),
  //                                 ),
  //                               ),
  //                               Padding(
  //                                 padding: const EdgeInsets.all(8.0),
  //                                 child: Text(
  //                                   "12. PELUNASAN JASA EKSPEDISI PALING LAMBAT 1 (SATU) BULAN DARI TANGGAL KAPAL BERANGKAT SESUAI YANG TERCANTUM DI BL PELAYARAN.",
  //                                   style: TextStyle(
  //                                     fontFamily: 'Nunito-Medium',
  //                                   ),
  //                                 ),
  //                               ),
  //                               Padding(
  //                                 padding: const EdgeInsets.all(8.0),
  //                                 child: Text(
  //                                   "13. HARGA TIDAK MENGIKAT SEWAKTU WAKTU DAPAT BERUBAH.",
  //                                   style: TextStyle(
  //                                     fontFamily: 'Nunito-Medium',
  //                                   ),
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       });
  // }
}
