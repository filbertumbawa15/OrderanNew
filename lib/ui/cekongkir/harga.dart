import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/src/types/marker.dart'
    as Marker;

class Harga extends StatefulWidget {
  const Harga({
    Key? key,
  }) : super(key: key);
  @override
  _HargaState createState() => _HargaState();
}

class _HargaState extends State<Harga> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker.Marker> _markers_origin = {};
  Set<Polyline> _polylines = Set<Polyline>();

  List<LatLng> polygonLatLngs = <LatLng>[];
  int _polylineIdCounter = 1;

  String distance = '0 km';
  String duration = '0 day';

  void initState() {
    super.initState();
    // setMap();
  }

  // void setMap(String origin, String destination) async {
  //   var directions = await LocationService().getDirections(
  //     origin,
  //     destination,
  //   );
  //   _goToPlace(
  //     directions['start_location']['lat'],
  //     directions['start_location']['lng'],
  //     directions['end_location']['lat'],
  //     directions['end_location']['lng'],
  //     directions['distance']['text'],
  //     directions['duration']['text'],
  //     directions['bounds_ne'],
  //     directions['bounds_sw'],
  //   );

  //   _setPolyline(directions['polyline_decoded']);
  // }

  // void _setMarker(LatLng point, LatLng destination, String distance) {
  //   setState(() {
  //     _markers_origin.add(
  //       Marker.Marker(
  //         markerId: MarkerId('marker_origin'),
  //         position: point,
  //         // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange)
  //         infoWindow: InfoWindow(
  //           title: "Distance: $distance",
  //           snippet: "Duration: $duration",
  //         ),
  //       ),
  //     );
  //     _markers_origin.add(
  //       Marker.Marker(
  //         markerId: MarkerId('marker_destination'),
  //         position: destination,
  //         icon:
  //             BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  //         infoWindow: InfoWindow(
  //           title: "Distance: $distance",
  //           snippet: "Duration: $duration",
  //         ),
  //       ),
  //     );
  //   });
  // }

  // void _setPolyline(List<PointLatLng> points) {
  //   final String polylineIdVal = 'polyline_$_polylineIdCounter';
  //   _polylineIdCounter++;
  //   _polylines.clear();
  //   _polylines.add(
  //     Polyline(
  //       polylineId: PolylineId(polylineIdVal),
  //       width: 5,
  //       color: Colors.blue,
  //       points: points
  //           .map(
  //             (point) => LatLng(point.latitude, point.longitude),
  //           )
  //           .toList(),
  //     ),
  //   );
  // }

  //Parameter
  String? origincontroller;
  String? pelabuhanasal;
  String? pelabuhanidasal;
  String? jarakasal;
  String? waktuasal;
  String? destinationcontroller;
  String? pelabuhantujuan;
  String? pelabuhanidtujuan;
  String? jaraktujuan;
  String? waktutujuan;
  String? harga;
  int? container;
  String? nilaibarang;
  String? qty;
  String? hargasatuan;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    origincontroller = args!['origincontroller'];
    pelabuhanidasal = args['pelabuhanidasal'];
    jarakasal = args['jarakasal'];
    waktuasal = args['waktuasal'];
    destinationcontroller = args['destinationcontroller'];
    pelabuhanidtujuan = args['pelabuhanidtujuan'];
    jaraktujuan = args['jaraktujuan'];
    waktutujuan = args['waktutujuan'];
    harga = args['harga'];
    container = args['container'];
    nilaibarang = args['nilaibarang'];
    qty = args['qty'];
    hargasatuan = args['hargasatuan'];
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
                                            //     '${latitude_pelabuhan_asal},${longitude_pelabuhan_asal}',
                                            //     origincontroller);
                                            // setState(() {
                                            //   distance = jarakasal;
                                            //   duration = waktuasal;
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
                                    if (pelabuhanidasal == '1') ...[
                                      const Expanded(
                                          child: Text(
                                        "Belawan",
                                        style: TextStyle(
                                          fontFamily: 'Nunito-Medium',
                                          fontWeight: FontWeight.bold,
                                        ),
                                        softWrap: true,
                                      )),
                                    ] else if (pelabuhanidasal == '2') ...[
                                      const Expanded(
                                        child: Text(
                                          "Tanjung Priok",
                                          style: TextStyle(
                                            fontFamily: 'Nunito-Medium',
                                            fontWeight: FontWeight.bold,
                                          ),
                                          softWrap: true,
                                        ),
                                      ),
                                    ] else if (pelabuhanidasal == '3') ...[
                                      const Expanded(
                                        child: Text(
                                          "Tanjung Perak",
                                          style: TextStyle(
                                            fontFamily: 'Nunito-Medium',
                                            fontWeight: FontWeight.bold,
                                          ),
                                          softWrap: true,
                                        ),
                                      ),
                                    ] else if (pelabuhanidasal == '4') ...[
                                      const Expanded(
                                          child: Text(
                                        "Soekarno Hatta",
                                        style: TextStyle(
                                          fontFamily: 'Nunito-Medium',
                                          fontWeight: FontWeight.bold,
                                        ),
                                        softWrap: true,
                                      )),
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
                                            //     '${latitude_pelabuhan_asal},${longitude_pelabuhan_asal}',
                                            //     origincontroller);
                                            // setState(() {
                                            //   distance = jarakasal;
                                            //   duration = waktuasal;
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
                                    if (pelabuhanidtujuan == '1') ...[
                                      const Expanded(
                                          child: Text(
                                        "Belawan",
                                        style: TextStyle(
                                          fontFamily: 'Nunito-Medium',
                                          fontWeight: FontWeight.bold,
                                        ),
                                        softWrap: true,
                                      )),
                                    ] else if (pelabuhanidtujuan == '2') ...[
                                      const Expanded(
                                        child: Text(
                                          "Tanjung Priok",
                                          style: TextStyle(
                                            fontFamily: 'Nunito-Medium',
                                            fontWeight: FontWeight.bold,
                                          ),
                                          softWrap: true,
                                        ),
                                      ),
                                    ] else if (pelabuhanidtujuan == '3') ...[
                                      const Expanded(
                                        child: Text(
                                          "Tanjung Perak",
                                          style: TextStyle(
                                            fontFamily: 'Nunito-Medium',
                                            fontWeight: FontWeight.bold,
                                          ),
                                          softWrap: true,
                                        ),
                                      ),
                                    ] else if (pelabuhanidtujuan == '4') ...[
                                      const Expanded(
                                          child: Text(
                                        "Soekarno Hatta",
                                        style: TextStyle(
                                          fontFamily: 'Nunito-Medium',
                                          fontWeight: FontWeight.bold,
                                        ),
                                        softWrap: true,
                                      )),
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
                                    if (container == 1) ...[
                                      const Expanded(
                                          child: Text(
                                        "20 ft",
                                        style: TextStyle(
                                          fontFamily: 'Nunito-Medium',
                                          fontWeight: FontWeight.bold,
                                        ),
                                        softWrap: true,
                                      )),
                                    ] else if (container == 2) ...[
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
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
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

  // double calculateDistance(lat1, lon1, lat2, lon2) {
  //   var p = 0.017453292519943295;
  //   var a = 0.5 -
  //       cos((lat2 - lat1) * p) / 2 +
  //       cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
  //   return 12742 * asin(sqrt(a));
  // }
}
