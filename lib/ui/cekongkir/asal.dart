import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:tasorderan/bloc/pesanan/ongkir/datapengirim/datapengirim_cubit.dart';
import 'package:tasorderan/components/components.dart';
import 'package:tasorderan/core/api_client.dart';

class AsalOngkir extends StatefulWidget {
  static var kInitialPosition = const LatLng(-33.8567844, 151.213108);
  const AsalOngkir({
    Key? key,
  }) : super(key: key);
  @override
  State<AsalOngkir> createState() => _AsalOngkirState();
}

class _AsalOngkirState extends State<AsalOngkir> {
  final _destinationController = TextEditingController();
  final components = Tools();
  ApiClient apiClient = ApiClient();
  bool location = true;
  String _originController = '';
  String? duration;

  ValueNotifier<bool>? _isButtonDisabled;
  ValueNotifier<String>? distance;
  ValueNotifier<String>? _namapelabuhan;

  // Data Asal
  String? _placeidasal;
  double? _latitude_place_asal;
  double? _longitude_place_asal;
  String? _pelabuhanidasal;
  String? _latitude_pelabuhan_asal;
  String? _longitude_pelabuhan_asal;

  @override
  void initState() {
    super.initState();
    _isButtonDisabled = ValueNotifier<bool>(true);
    distance = ValueNotifier<String>('0.0 km');
    _namapelabuhan = ValueNotifier<String>('');
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      _originController =
          '${args['_latitude_place_asal']}, ${args['_longitude_place_asal']}';
      _pelabuhanidasal = args['_pelabuhanidasal'];
      _latitude_pelabuhan_asal = args['_latitude_pelabuhan_asal'];
      _longitude_pelabuhan_asal = args['_longitude_pelabuhan_asal'];
      _namapelabuhan!.value = args['_nama_pelabuhan_asal'];
      location = false;
      AsalOngkir.kInitialPosition = LatLng(
        double.parse(args['_latitude_place_asal']),
        double.parse(args['_longitude_place_asal']),
      );
      _destinationController.text = args['_alamatasal'];
      _placeidasal = args['_placeidasal'];
      _latitude_place_asal = double.parse(args['_latitude_place_asal']);
      _longitude_place_asal = double.parse(args['_longitude_place_asal']);
      distance!.value = args['_jarak_asal'];
      duration = args['_waktu_asal'];
      _isButtonDisabled!.value = false;
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xFFB7B7B7),
            )),
        title: const Text(
          "Data Muat (Pengirim)",
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
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DatapengirimCubit(),
          ),
        ],
        child: ListView(
          children: [
            const SizedBox(height: 30.0),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, bottom: 8.0, left: 17.0, right: 17.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: TextFormField(
                              readOnly: true,
                              style: const TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(left: 15.0),
                                suffixIcon: Icon(
                                  Icons.pin_drop,
                                  color: Color(0xFF5599E9),
                                ),
                                border: OutlineInputBorder(),
                                label: Text('Lokasi Muat'),
                                labelStyle: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              controller: _destinationController,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return BlocProvider(
                                        create: (context) =>
                                            DatapengirimCubit(),
                                        child: BlocConsumer<DatapengirimCubit,
                                            DatapengirimState>(
                                          listener: (context, state) {
                                            if (state is MapSuccess) {
                                              Future.delayed(
                                                  const Duration(seconds: 0),
                                                  () {
                                                _originController =
                                                    '${state.response['data']['latitude']}, ${state.response['data']['longitude']}';
                                                _pelabuhanidasal =
                                                    state.response['data']
                                                        ['pelabuhan_id'];
                                                _latitude_pelabuhan_asal =
                                                    state.response['data']
                                                        ['latitude'];
                                                _longitude_pelabuhan_asal =
                                                    state.response['data']
                                                        ['longitude'];
                                                _namapelabuhan!.value =
                                                    state.response['data']
                                                        ['namapelabuhan'];
                                                location = false;
                                                AsalOngkir.kInitialPosition =
                                                    LatLng(
                                                  state.result.geometry!
                                                      .location.lat,
                                                  state.result.geometry!
                                                      .location.lng,
                                                );
                                                _destinationController.text =
                                                    state.result
                                                        .formattedAddress!;
                                                _placeidasal =
                                                    state.result.placeId!;
                                                _latitude_place_asal = state
                                                    .result
                                                    .geometry!
                                                    .location
                                                    .lat;
                                                _longitude_place_asal = state
                                                    .result
                                                    .geometry!
                                                    .location
                                                    .lng;
                                                distance!.value =
                                                    state.direction['distance']
                                                        ['text'];
                                                duration =
                                                    state.direction['duration']
                                                        ['text'];
                                                components.dia!.hide();
                                                Navigator.of(context).pop();
                                                if (_destinationController
                                                    .text.isNotEmpty) {
                                                  _isButtonDisabled!.value =
                                                      false;
                                                } else {
                                                  _isButtonDisabled!.value =
                                                      true;
                                                }
                                              });
                                            }
                                          },
                                          builder: (context, state) {
                                            if (state is MapLoading) {
                                              Future.delayed(
                                                  const Duration(seconds: 0),
                                                  () {
                                                components.showDia();
                                              });
                                            } else if (state is MapFailed) {
                                              Future.delayed(
                                                  const Duration(seconds: 0),
                                                  () {
                                                components.dia!.hide();
                                                components.alertBerhasilPesan(
                                                  state.content,
                                                  state.title,
                                                  state.image,
                                                  IconsButton(
                                                    onPressed: () async {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    text: 'Ok',
                                                    iconData: Icons.done,
                                                    color: Colors.blue,
                                                    textStyle: const TextStyle(
                                                        color: Colors.white),
                                                    iconColor: Colors.white,
                                                  ),
                                                );
                                              });
                                            }
                                            return PlacePicker(
                                              apiKey: apiClient.apiKey,
                                              initialPosition:
                                                  AsalOngkir.kInitialPosition,
                                              useCurrentLocation: location,
                                              selectInitialPosition: true,
                                              onPlacePicked: (result) async {
                                                BlocProvider.of<
                                                            DatapengirimCubit>(
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
                                builder: (context, value, child) {
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
                                valueListenable: _namapelabuhan!,
                                builder: (context, value, child) {
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
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
            top: 8.0, bottom: 8.0, left: 17.0, right: 17.0),
        child: ValueListenableBuilder(
          valueListenable: _isButtonDisabled!,
          builder: ((context, value, child) {
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
                      if (mounted) {
                        Navigator.pop(
                          context,
                          {
                            '_placeidasal': _placeidasal,
                            '_latitude_place_asal': _latitude_place_asal,
                            '_longitude_place_asal': _longitude_place_asal,
                            '_pelabuhanidasal': _pelabuhanidasal,
                            '_latitude_pelabuhan_asal':
                                _latitude_pelabuhan_asal,
                            '_longitude_pelabuhan_asal':
                                _longitude_pelabuhan_asal,
                            '_jarak_asal': distance!.value,
                            '_waktu_asal': duration,
                            '_alamatasal': _destinationController.text,
                            '_nama_pelabuhan_asal': _namapelabuhan!.value,
                          },
                        );
                      }
                    },
              child: const Padding(
                  padding: EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 12, bottom: 12),
                  child: Text("Kirim", style: TextStyle(fontSize: 14.0))),
            );
          }),
        ),
      ),
    );
  }
}
