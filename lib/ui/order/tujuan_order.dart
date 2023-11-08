import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:flutter/services.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:tasorderan/bloc/pesanan/pesanan/dataorder/dataorder_cubit.dart';
import 'package:tasorderan/components/components.dart';
import 'package:tasorderan/core/api_client.dart';
import 'package:tasorderan/core/session_manager.dart';
import 'package:tasorderan/params/pesanan_params.dart';

class Tujuan extends StatefulWidget {
  // final bool loggedIn;
  static var kInitialPosition = const LatLng(-33.8567844, 151.213108);

  const Tujuan({
    Key? key,
  }) : super(key: key);
  @override
  State<Tujuan> createState() => _TujuanState();
}

class _TujuanState extends State<Tujuan> {
  final _favoritescontroller = TextEditingController();
  ValueNotifier<bool>? _isButtonDisabled;
  ValueNotifier<bool>? _isButtonTextDisabled;
  final components = Tools();
  final apiClient = ApiClient();

  // Data tujuan
  String? _originController;
  String? _placeidtujuan;
  String? _latitude_pelabuhan_tujuan;
  String? _longitude_pelabuhan_tujuan;
  String? duration;
  String? _pelabuhanidtujuan;
  String? _latitude_place_tujuan;
  String? _longitude_place_tujuan;
  ValueNotifier<String>? namapelabuhanpenerima;
  ValueNotifier<String>? distance;
  final _selectedpenerima = TextEditingController();
  final _selectednotelppenerima = TextEditingController();
  final _selectednotepenerima = TextEditingController();
  final _destinationController = TextEditingController();
  bool location = true;

  @override
  void initState() {
    super.initState();
    namapelabuhanpenerima = ValueNotifier<String>('-');
    distance = ValueNotifier<String>('0.0 km');
    _isButtonDisabled = ValueNotifier<bool>(true);
    _isButtonTextDisabled = ValueNotifier<bool>(true);
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      _originController =
          '${args['_latitude_pelabuhan_tujuan']}, ${args['_longitude_pelabuhan_tujuan']}';
      _pelabuhanidtujuan = args['_pelabuhanidtujuan'];
      _latitude_pelabuhan_tujuan = args['_latitude_pelabuhan_tujuan'];
      _longitude_pelabuhan_tujuan = args['_longitude_pelabuhan_tujuan'];
      namapelabuhanpenerima!.value = args['namapelabuhanpenerima'];
      location = false;
      Tujuan.kInitialPosition = LatLng(
        double.parse(args['_latitude_place_tujuan']),
        double.parse(args['_longitude_place_tujuan']),
      );
      _destinationController.text = args['_alamattujuan'];
      _placeidtujuan = args['_placeidtujuan'];
      _latitude_place_tujuan = args['_latitude_place_tujuan'];
      _longitude_place_tujuan = args['_longitude_place_tujuan'];
      distance!.value = args['_jarak_tujuan'];
      duration = args['_waktu_tujuan'];
      _selectednotepenerima.text = args["notepenerima"];
      _selectednotelppenerima.text = args["notelppenerima"];
      _selectedpenerima.text = args["penerima"];
      _isButtonDisabled!.value = false;
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context, '/order');
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xFFB7B7B7),
            )),
        title: const Text(
          "Data Bongkar (Penerima)",
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
              child: BlocConsumer<DataorderCubit, DataorderState>(
                listener: (context, state) {
                  if (state is DataorderFavoriteSuccess) {
                    Map<String, dynamic> dataorder =
                        jsonDecode(jsonEncode(state.result));
                    _placeidtujuan = dataorder["_placeid"];
                    _pelabuhanidtujuan = dataorder["_pelabuhanid"];
                    _destinationController.text = dataorder["alamat"];
                    _selectedpenerima.text = dataorder["customer"];
                    _selectednotelppenerima.text = dataorder["notelp"];
                    _selectednotepenerima.text = dataorder["note"];
                    _latitude_place_tujuan = dataorder["latitude_place"];
                    _longitude_place_tujuan = dataorder["longitude_place"];
                    namapelabuhanpenerima!.value = dataorder["namapelabuhan"];
                    _originController = dataorder["_originController"];
                    _latitude_pelabuhan_tujuan =
                        dataorder["latitude_pelabuhan"];
                    _longitude_pelabuhan_tujuan =
                        dataorder["longitude_pelabuhan"];
                    distance!.value = dataorder["distance"];
                    duration = dataorder["duration"];
                    location = false;
                    Tujuan.kInitialPosition = LatLng(
                        double.parse(_latitude_place_tujuan!),
                        double.parse(_longitude_place_tujuan!));
                    if (_destinationController.text.isNotEmpty &&
                        _selectedpenerima.text.isNotEmpty &&
                        _selectednotelppenerima.text.isNotEmpty) {
                      _isButtonDisabled!.value = false;
                    } else {
                      _isButtonDisabled!.value = true;
                    }
                  }
                },
                builder: (context, state) {
                  if (state is DataorderFavoriteFailed) {
                    print("baca gagal");
                  }
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, bottom: 8.0, left: 17.0, right: 7.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: SizedBox(
                                  height: 36.0,
                                  child: TextField(
                                    controller: _destinationController,
                                    readOnly: true,
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    decoration: const InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(left: 15.0),
                                      suffixIcon: Icon(
                                        Icons.pin_drop,
                                        color: Color(0xFFE95555),
                                      ),
                                      border: OutlineInputBorder(),
                                      labelText: 'Lokasi Bongkar',
                                      labelStyle: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return BlocProvider(
                                              create: (context) =>
                                                  DataorderCubit(),
                                              child: BlocConsumer<
                                                  DataorderCubit,
                                                  DataorderState>(
                                                listener: (context, state) {
                                                  if (state
                                                      is MapOrderSuccess) {
                                                    Future.delayed(
                                                        const Duration(
                                                            seconds: 0), () {
                                                      _originController =
                                                          '${state.response['data']['latitude']}, ${state.response['data']['longitude']}';
                                                      _pelabuhanidtujuan =
                                                          state.response['data']
                                                              ['pelabuhan_id'];
                                                      _latitude_pelabuhan_tujuan =
                                                          state.response['data']
                                                              ['latitude'];
                                                      _longitude_pelabuhan_tujuan =
                                                          state.response['data']
                                                              ['longitude'];
                                                      namapelabuhanpenerima!
                                                              .value =
                                                          state.response['data']
                                                              ['namapelabuhan'];
                                                      location = false;
                                                      Tujuan.kInitialPosition =
                                                          LatLng(
                                                        state.result.geometry!
                                                            .location.lat,
                                                        state.result.geometry!
                                                            .location.lng,
                                                      );
                                                      _destinationController
                                                              .text =
                                                          state.result
                                                              .formattedAddress!;
                                                      _placeidtujuan =
                                                          state.result.placeId!;
                                                      _latitude_place_tujuan =
                                                          state.result.geometry!
                                                              .location.lat
                                                              .toString();
                                                      _longitude_place_tujuan =
                                                          state.result.geometry!
                                                              .location.lng
                                                              .toString();
                                                      distance!.value = state
                                                              .direction[
                                                          'distance']['text'];
                                                      duration = state
                                                              .direction[
                                                          'duration']['text'];
                                                      components.dia!.hide();
                                                      Navigator.of(context)
                                                          .pop();
                                                      if (_destinationController
                                                              .text
                                                              .isNotEmpty &&
                                                          _selectedpenerima.text
                                                              .isNotEmpty &&
                                                          _selectednotelppenerima
                                                              .text
                                                              .isNotEmpty) {
                                                        _isButtonDisabled!
                                                            .value = false;
                                                      } else {
                                                        _isButtonDisabled!
                                                            .value = true;
                                                      }
                                                    });
                                                  }
                                                },
                                                builder: (context, state) {
                                                  if (state
                                                      is MapOrderLoading) {
                                                    Future.delayed(
                                                        const Duration(
                                                            seconds: 0), () {
                                                      components.showDia();
                                                    });
                                                  } else if (state
                                                      is MapOrderFailed) {
                                                    Future.delayed(
                                                        const Duration(
                                                            seconds: 0), () {
                                                      components.dia!.hide();
                                                      components
                                                          .alertBerhasilPesan(
                                                        state.content,
                                                        state.title,
                                                        state.image,
                                                        IconsButton(
                                                          onPressed: () async {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          text: 'Ok',
                                                          iconData: Icons.done,
                                                          color: Colors.blue,
                                                          textStyle:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                          iconColor:
                                                              Colors.white,
                                                        ),
                                                      );
                                                    });
                                                  }
                                                  return PlacePicker(
                                                    apiKey: apiClient.apiKey,
                                                    initialPosition:
                                                        Tujuan.kInitialPosition,
                                                    useCurrentLocation:
                                                        location,
                                                    selectInitialPosition: true,
                                                    onPlacePicked:
                                                        (result) async {
                                                      BlocProvider.of<
                                                                  DataorderCubit>(
                                                              context)
                                                          .getPelabuhan(result);
                                                    },
                                                    autocompleteLanguage: "id",
                                                    region: 'id',
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.list,
                                  color: Color(0xFFC3C3C3),
                                ),
                                onPressed: () async {
                                  BlocProvider.of<DataorderCubit>(context)
                                      .pushFavorites();
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 8.0, left: 17.0, right: 17.0),
                          child: TextFormField(
                              style: const TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(left: 15.0, top: 15.0),
                                labelText: 'Note',
                                labelStyle: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                border: OutlineInputBorder(),
                              ),
                              maxLines: 5,
                              keyboardType: TextInputType.multiline,
                              controller: _selectednotepenerima,
                              textCapitalization: TextCapitalization.sentences),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 8.0, left: 17.0, right: 17.0),
                          child: SizedBox(
                            height: 36.0,
                            child: TextFormField(
                                style: const TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 15.0),
                                  labelText: 'Penerima',
                                  labelStyle: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.text,
                                controller: _selectedpenerima,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                onChanged: (val) {
                                  if (_destinationController.text.isNotEmpty &&
                                      _selectedpenerima.text.isNotEmpty &&
                                      _selectednotelppenerima.text.isNotEmpty) {
                                    _isButtonDisabled!.value = false;
                                  } else {
                                    _isButtonDisabled!.value = true;
                                  }
                                }),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 8.0, left: 17.0, right: 17.0),
                          child: SizedBox(
                            height: 36.0,
                            child: TextFormField(
                              style: const TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(left: 15.0),
                                labelText: 'No.Telp',
                                labelStyle: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              controller: _selectednotelppenerima,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(13),
                              ],
                              onChanged: (val) {
                                if (_destinationController.text.isNotEmpty &&
                                    _selectedpenerima.text.isNotEmpty &&
                                    _selectednotelppenerima.text.isNotEmpty) {
                                  _isButtonDisabled!.value = false;
                                } else {
                                  _isButtonDisabled!.value = true;
                                }
                              },
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 8.0, left: 17.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Jarak",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        fontFamily: 'Nunito-Medium')),
                              ),
                            ),
                            ValueListenableBuilder(
                              valueListenable: distance!,
                              builder: (context, value, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, right: 17.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(value,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            fontFamily: 'Nunito-Medium')),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                  top: 15.0, bottom: 50.0, left: 17.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Pelabuhan",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        fontFamily: 'Nunito-Medium')),
                              ),
                            ),
                            ValueListenableBuilder(
                              valueListenable: namapelabuhanpenerima!,
                              builder: (context, value, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15.0, bottom: 50.0, right: 17.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(value,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            fontFamily: 'Nunito-Medium')),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
            top: 8.0, bottom: 8.0, left: 17.0, right: 17.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ValueListenableBuilder(
              valueListenable: _isButtonDisabled!,
              builder: (context, value, index) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE9558A),
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  onPressed: value
                      ? null
                      : () {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return BlocProvider(
                                  create: (context) => DataorderCubit(),
                                  child: StatefulBuilder(
                                    builder: ((context, setState) {
                                      return AlertDialog(
                                        title: const Text(
                                          "Masukkan Nama Favorit",
                                          style: TextStyle(
                                              fontFamily: 'Nunito-Medium',
                                              fontWeight: FontWeight.bold),
                                        ),
                                        content: Padding(
                                          padding: const EdgeInsets.only(
                                            top: 3.0,
                                            bottom: 8.0,
                                          ),
                                          child: SizedBox(
                                            height: 36.0,
                                            child: TextField(
                                              controller: _favoritescontroller,
                                              style: const TextStyle(
                                                fontSize: 13.0,
                                              ),
                                              textCapitalization:
                                                  TextCapitalization.sentences,
                                              decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.only(left: 15.0),
                                                border: OutlineInputBorder(),
                                                labelText: 'Nama Favorit',
                                                labelStyle: TextStyle(
                                                  fontSize: 13.0,
                                                ),
                                              ),
                                              onChanged: ((value) {
                                                if (value.isNotEmpty) {
                                                  _isButtonTextDisabled!.value =
                                                      false;
                                                } else {
                                                  _isButtonTextDisabled!.value =
                                                      true;
                                                }
                                              }),
                                            ),
                                          ),
                                        ),
                                        actions: <Widget>[
                                          ValueListenableBuilder(
                                            valueListenable:
                                                _isButtonTextDisabled!,
                                            builder: (context, value, index) {
                                              return BlocConsumer<
                                                  DataorderCubit,
                                                  DataorderState>(
                                                listener: (context, state) {
                                                  if (state
                                                      is DataorderFavoriteAddSuccess) {
                                                    Navigator.of(context).pop();
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                      content: Text(
                                                          "Alamat sudah berhasil ditambahkan ke dalam favorit anda"),
                                                    ));
                                                    _favoritescontroller
                                                        .clear();
                                                    _isButtonTextDisabled!
                                                        .value = true;
                                                  }
                                                },
                                                builder: (context, state) {
                                                  if (state
                                                      is DataorderFavoriteAddLoading) {
                                                    return const CircularProgressIndicator();
                                                  } else if (state
                                                      is DataorderFavoriteAddFailed) {
                                                    Navigator.of(context).pop();
                                                    _favoritescontroller
                                                        .clear();
                                                    _isButtonTextDisabled!
                                                        .value = true;
                                                  }
                                                  return TextButton(
                                                    onPressed: value
                                                        ? null
                                                        : () async {
                                                            BlocProvider.of<
                                                                        DataorderCubit>(
                                                                    context)
                                                                .addToFavorites(
                                                              AddFavoritParam(
                                                                  _favoritescontroller
                                                                      .text,
                                                                  _placeidtujuan,
                                                                  SessionManager()
                                                                      .getActiveId(),
                                                                  _pelabuhanidtujuan,
                                                                  _destinationController
                                                                      .text,
                                                                  _selectedpenerima
                                                                      .text,
                                                                  _selectednotelppenerima
                                                                      .text,
                                                                  _latitude_place_tujuan
                                                                      .toString(),
                                                                  _longitude_place_tujuan
                                                                      .toString(),
                                                                  namapelabuhanpenerima!
                                                                      .value,
                                                                  _selectednotepenerima
                                                                      .text),
                                                            );
                                                          },
                                                    child: const Text(
                                                      "OK",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Nunito-ExtraBold',
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                          TextButton(
                                            child: const Text(
                                              "CANCEL",
                                              style: TextStyle(
                                                fontFamily: 'Nunito-ExtraBold',
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              _favoritescontroller.clear();
                                              _isButtonTextDisabled!.value =
                                                  true;
                                            },
                                          ),
                                        ],
                                      );
                                    }),
                                  ),
                                );
                              });
                        },
                  child: const Padding(
                      padding: EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 12, bottom: 12),
                      child: Text("Tambah Ke Favorit",
                          style: TextStyle(
                            fontSize: 14.0,
                            fontFamily: 'Nunito-Medium',
                            fontWeight: FontWeight.bold,
                          ))),
                );
              },
            ),
            ValueListenableBuilder(
              valueListenable: _isButtonDisabled!,
              builder: (context, value, index) {
                return SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      backgroundColor: const Color(0xFF5599E9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    onPressed: value
                        ? null
                        : () {
                            Navigator.pop(context, {
                              '_placeidtujuan': _placeidtujuan,
                              '_latitude_place_tujuan': _latitude_place_tujuan,
                              '_longitude_place_tujuan':
                                  _longitude_place_tujuan,
                              '_pelabuhanidtujuan': _pelabuhanidtujuan,
                              '_latitude_pelabuhan_tujuan':
                                  _latitude_pelabuhan_tujuan,
                              '_longitude_pelabuhan_tujuan':
                                  _longitude_pelabuhan_tujuan,
                              '_jarak_tujuan': distance!.value,
                              '_waktu_tujuan': duration,
                              '_alamattujuan': _destinationController.text,
                              'penerima': _selectedpenerima.text,
                              'notelppenerima': _selectednotelppenerima.text,
                              'notepenerima': _selectednotepenerima.text,
                              'namapelabuhanpenerima':
                                  namapelabuhanpenerima!.value,
                            });
                          },
                    child: const Padding(
                        padding: EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 12, bottom: 12),
                        child: Text("Next", style: TextStyle(fontSize: 14.0))),
                  ),
                );
              },
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
            Text("Muat", style: TextStyle(fontSize: 14.0)),
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
            Text("Bongkar", style: TextStyle(fontSize: 14.0)),
          ],
        ),
      ],
    );
  }
}
