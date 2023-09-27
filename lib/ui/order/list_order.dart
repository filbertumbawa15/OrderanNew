import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tasorderan/bloc/pesanan/pesanan/listorder/list_order_bloc.dart';
import 'package:tasorderan/components/components.dart';
import 'package:tasorderan/core/api_client.dart';
import 'package:tasorderan/core/session_manager.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin:
          const EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0, bottom: 10.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.08),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(14.28),
      ),
    );
  }
}

class ListOrder extends StatefulWidget {
  const ListOrder({super.key});

  @override
  State<ListOrder> createState() => _ListOrderState();
}

class _ListOrderState extends State<ListOrder> {
  final sessionManager = SessionManager();
  final apiClient = ApiClient();
  final components = Tools();

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   getDataMaster();
    // });
  }

  // void getDataMaster() async {
  //   await Provider.of<MasterProvider>(context, listen: false)
  //       .callSkeletonListPesanan(context, globals.loggedinId);
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
  //   // result['data'][0]['trx_id']
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xFFB7B7B7),
            )),
        elevation: 0,
        title: const Text(
          "List Pesanan",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: const Icon(
                Icons.search,
                color: Color(0xFFBFBFBF),
              ),
              onPressed: () {}),
          IconButton(
              icon: const Icon(
                Icons.filter_alt,
                color: Color(0xFFBFBFBF),
              ),
              onPressed: () {}),
        ],
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ListOrderBloc()
              ..add(ListPesananOrderEvent(
                  sessionManager.getActiveId(), 0, apiClient.utcTime)),
          ),
          // BlocProvider(
          //   create: (context) => ListOrderBloc(),
          // ),
        ],
        child: RefreshIndicator(
          onRefresh: () async {
            // BlocProvider.of<ListOrderBloc>(context).add(ListPesananOrderEvent(
            //     sessionManager.getActiveId(), 0, apiClient.utcTime));
          },
          child: Container(
            color: const Color(0xFFF3F3F3),
            child: BlocConsumer<ListOrderBloc, ListOrderState>(
              listener: (context, state) {
                if (state is ListordernavigatorSuccessPaymentLoaded) {
                  BlocProvider.of<ListOrderBloc>(context).add(
                      ListPesananOrderEvent(
                          sessionManager.getActiveId(), 0, apiClient.utcTime));
                }
              },
              builder: (context, state) {
                if (state is ListordernavigatorSuccessPaymentFailed) {
                  BlocProvider.of<ListOrderBloc>(context).add(
                      ListPesananOrderEvent(
                          sessionManager.getActiveId(), 0, apiClient.utcTime));
                }
                return BlocBuilder<ListOrderBloc, ListOrderState>(
                  builder: (context, state) {
                    if (state is ListOrderLoading) {
                      return ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, i) {
                          const SizedBox(height: 15.0);
                          return const Padding(
                            padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: Skeleton(
                              height: 300.0,
                              width: 880.0,
                            ),
                          );
                        },
                      );
                    } else if (state is ListOrderFailed) {
                      return Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 5,
                            ),
                            Image.asset(
                              "assets/imgs/trucking.png",
                              width: 200,
                              height: 200,
                            ),
                            const Text(
                              "masukkan error disini",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 187, 187, 187),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            )
                          ],
                        ),
                      );
                    } else if (state is ListOrderSuccess) {
                      if (state.result.isNotEmpty) {
                        return ListView.builder(
                            itemCount: state.result.length,
                            itemBuilder: (context, i) {
                              return Container(
                                height: 300.0,
                                width: 880.0,
                                margin: const EdgeInsets.only(
                                    left: 5.0,
                                    right: 5.0,
                                    top: 10.0,
                                    bottom: 10.0),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 300.0,
                                      width: 880.0,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFFFFF),
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                            BorderRadius.circular(14.28),
                                        border: const Border(
                                          top: BorderSide(
                                              color: Color(0xFFBDBDBD)),
                                          bottom: BorderSide(
                                              color: Color(0xFFBDBDBD)),
                                          left: BorderSide(
                                              color: Color(0xFFBDBDBD)),
                                          right: BorderSide(
                                              color: Color(0xFFBDBDBD)),
                                        ),
                                      ),
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                          left: 0.0,
                                          top: 0.0,
                                          right: 0.0,
                                          bottom: 0.0,
                                        ),
                                        child: ClipPath(
                                          clipper: ShapeBorderClipper(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          14.28))),
                                          child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                left: BorderSide(
                                                    color: state.result[i]
                                                                .payment_status ==
                                                            "2"
                                                        ? const Color(
                                                            0xFF5ACA16)
                                                        : state.result[i]
                                                                    .payment_status ==
                                                                "0"
                                                            ? const Color(
                                                                0xFFE1B30D)
                                                            : state.result[i]
                                                                        .payment_status ==
                                                                    "10"
                                                                ? const Color(
                                                                    0xFFF9B691)
                                                                : state.result[i].payment_status ==
                                                                        '11'
                                                                    ? const Color(
                                                                        0xFF005796)
                                                                    : const Color(
                                                                        0xFFE95555),
                                                    width: 15),
                                              ),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 55.0,
                                                  child: ListTile(
                                                    title: const Text(
                                                      'No. Pesanan',
                                                      style: TextStyle(
                                                        fontSize: 12.0,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    subtitle: Text(
                                                        state
                                                            .result[i].nobukti!,
                                                        style: const TextStyle(
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          color: Colors.black,
                                                        )),
                                                    trailing: Container(
                                                        width: 126,
                                                        height: 38,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                            width: 1,
                                                            color: state
                                                                        .result[
                                                                            i]
                                                                        .payment_status ==
                                                                    "2"
                                                                ? const Color(
                                                                    0xFF5ACA16)
                                                                : state.result[i].payment_status ==
                                                                        "0"
                                                                    ? const Color(
                                                                        0xFFE1B30D)
                                                                    : state.result[i].payment_status ==
                                                                            "10"
                                                                        ? const Color(
                                                                            0xFFF9B691)
                                                                        : state.result[i].payment_status ==
                                                                                '11'
                                                                            ? const Color(0xFF005796)
                                                                            : const Color(0xFFE95555),
                                                          ),
                                                          // You can use like this way or like the below line
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100.0),
                                                        ),
                                                        child: Text(
                                                          state.result[i]
                                                                      .payment_status ==
                                                                  "0"
                                                              ? "Belum Diproses"
                                                              : state.result[i]
                                                                          .payment_status ==
                                                                      "8"
                                                                  ? "Batal Dibayar"
                                                                  : state.result[i].payment_status ==
                                                                          "7"
                                                                      ? "Pemb. Expired"
                                                                      : state.result[i].payment_status ==
                                                                              "10"
                                                                          ? "Proses Refund"
                                                                          : state.result[i].payment_status == "11"
                                                                              ? "Refund Berhasil"
                                                                              : "Berhasil Dibayar",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            fontSize: 12.0,
                                                          ),
                                                        )),
                                                    isThreeLine: true,
                                                  ),
                                                ),
                                                const Divider(
                                                  thickness: 0.5,
                                                  color: Colors.black,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 17.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          const Text(
                                                            'Nama Pengirim',
                                                            style: TextStyle(
                                                              fontSize: 12.0,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          Text(
                                                            state.result[i]
                                                                .pengirim!
                                                                .toUpperCase(),
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 17.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          const Text(
                                                            'Nama Penerima',
                                                            style: TextStyle(
                                                              fontSize: 12.0,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          Text(
                                                            state.result[i]
                                                                .penerima!
                                                                .toUpperCase(),
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10.0),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 17.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      const Text(
                                                        'Provinsi Muat',
                                                        style: TextStyle(
                                                          fontSize: 12.0,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Text(
                                                          state.result[i]
                                                              .prov_asal!,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12.0,
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            color: Colors.black,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 10.0),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 17.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      const Text(
                                                        'Provinsi Bongkar',
                                                        style: TextStyle(
                                                          fontSize: 12.0,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Text(
                                                          state.result[i]
                                                              .prov_tujuan!,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12.0,
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            color: Colors.black,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 10.0),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 17.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          const Text(
                                                            'Tgl Pesan',
                                                            style: TextStyle(
                                                              fontSize: 12.0,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          Text(
                                                              DateFormat(
                                                                      "dd-MM-yyyy")
                                                                  .format(DateFormat(
                                                                          "dd-MM-yyyy")
                                                                      .parse(state
                                                                          .result[
                                                                              i]
                                                                          .order_date!)),
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 12.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                color: Colors
                                                                    .black,
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 17.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Text(
                                                            state.result[i]
                                                                        .payment_status ==
                                                                    "8"
                                                                ? 'Tgl Batal'
                                                                : "Tgl Bayar",
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12.0,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          Text(
                                                              state.result[i]
                                                                          .payment_status ==
                                                                      "0"
                                                                  ? "-"
                                                                  : DateFormat("dd-MM-yyyy").format(DateFormat(
                                                                          "dd-MM-yyyy")
                                                                      .parse(state
                                                                          .result[
                                                                              i]
                                                                          .payment_date!)),
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 12.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                color: Colors
                                                                    .black,
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 17.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          const Text(
                                                            'Uk. Container',
                                                            style: TextStyle(
                                                              fontSize: 12.0,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          Text(
                                                              state.result[i]
                                                                          .container_id ==
                                                                      "1"
                                                                  ? '20" (ft)'
                                                                  : '40" (ft)',
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 12.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                color: Colors
                                                                    .black,
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 17.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          const Text(
                                                            'Qty',
                                                            style: TextStyle(
                                                              fontSize: 12.0,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          Text(
                                                              state.result[i]
                                                                  .qty!,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 12.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                color: Colors
                                                                    .black,
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10.0),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  margin: const EdgeInsets.only(
                                                      left: 17.0, right: 17.0),
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      side: const BorderSide(
                                                        color:
                                                            Color(0xFFB8B8B8),
                                                      ),
                                                      backgroundColor:
                                                          const Color(
                                                              0xFFF4F4F4),
                                                      textStyle:
                                                          const TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                      elevation: 0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                      ),
                                                    ),
                                                    onPressed: () async {
                                                      if (state.result[i]
                                                              .payment_status ==
                                                          '0') {
                                                        BlocProvider.of<
                                                                    ListOrderBloc>(
                                                                context)
                                                            .add(
                                                          ListPesananOrderNavigatorEvent(
                                                            route: '/bayar',
                                                            nobukti: state
                                                                .result[i]
                                                                .nobukti!,
                                                          ),
                                                        );
                                                      } else if (state.result[i]
                                                              .payment_status ==
                                                          '2') {
                                                        BlocProvider.of<
                                                                    ListOrderBloc>(
                                                                context)
                                                            .add(ListPesananOrderNavigatorEvent(
                                                                route:
                                                                    '/payment_success',
                                                                param: {
                                                              'harga_bayar':
                                                                  state
                                                                      .result[i]
                                                                      .harga,
                                                              'noVA': state
                                                                  .result[i]
                                                                  .trx_id,
                                                              'nobukti': state
                                                                  .result[i]
                                                                  .nobukti,
                                                              'payment_status':
                                                                  int.parse(state
                                                                      .result[i]
                                                                      .payment_status!),
                                                              'alamat_asal': state
                                                                  .result[i]
                                                                  .alamat_asal,
                                                              'note_pengirim': state
                                                                  .result[i]
                                                                  .notepengirim,
                                                              'pengirim': state
                                                                  .result[i]
                                                                  .pengirim,
                                                              'notelppengirim':
                                                                  state
                                                                      .result[i]
                                                                      .notelppengirim,
                                                              'alamat_tujuan': state
                                                                  .result[i]
                                                                  .alamat_tujuan,
                                                              'note_penerima': state
                                                                  .result[i]
                                                                  .notepenerima,
                                                              'penerima': state
                                                                  .result[i]
                                                                  .penerima,
                                                              'notelppenerima':
                                                                  state
                                                                      .result[i]
                                                                      .notelppenerima,
                                                              'order_date': state
                                                                  .result[i]
                                                                  .order_date,
                                                              'payment_date': state
                                                                  .result[i]
                                                                  .payment_date,
                                                              'payment_code': state
                                                                  .result[i]
                                                                  .payment_code,
                                                              'link':
                                                                  'List Pesanan',
                                                              'latitude_pelabuhan_asal':
                                                                  state
                                                                      .result[i]
                                                                      .latitude_pelabuhan_asal,
                                                              'longitude_pelabuhan_asal':
                                                                  state
                                                                      .result[i]
                                                                      .longitude_pelabuhan_asal,
                                                              'latitude_pelabuhan_tujuan':
                                                                  state
                                                                      .result[i]
                                                                      .latitude_pelabuhan_tujuan,
                                                              'longitude_pelabuhan_tujuan':
                                                                  state
                                                                      .result[i]
                                                                      .longitude_pelabuhan_tujuan,
                                                              'latitude_muat': state
                                                                  .result[i]
                                                                  .latitude_muat,
                                                              'longitude_muat':
                                                                  state
                                                                      .result[i]
                                                                      .longitude_muat,
                                                              'latitude_bongkar':
                                                                  state
                                                                      .result[i]
                                                                      .latitude_bongkar,
                                                              'longitude_bongkar':
                                                                  state
                                                                      .result[i]
                                                                      .longitude_bongkar,
                                                              'nominalrefund': state
                                                                  .result[i]
                                                                  .nominalrefund,
                                                              'buktipdf': state
                                                                  .result[i]
                                                                  .buktipdf,
                                                              'lampiraninvoice':
                                                                  state
                                                                      .result[i]
                                                                      .lampiraninvoice,
                                                              'placeidasal': state
                                                                  .result[i]
                                                                  .placeidasal,
                                                              'pelabuhanidasal':
                                                                  state
                                                                      .result[i]
                                                                      .pelabuhanidasal,
                                                              'jarak_asal': state
                                                                  .result[i]
                                                                  .jarak_asal,
                                                              'waktu_asal': state
                                                                  .result[i]
                                                                  .waktu_asal,
                                                              'namapelabuhanmuat':
                                                                  state
                                                                      .result[i]
                                                                      .namapelabuhanmuat,
                                                              'namapelabuhanbongkar':
                                                                  state
                                                                      .result[i]
                                                                      .namapelabuhanbongkar,
                                                              'placeidtujuan': state
                                                                  .result[i]
                                                                  .placeidtujuan,
                                                              'pelabuhanidtujuan':
                                                                  state
                                                                      .result[i]
                                                                      .pelabuhanidtujuan,
                                                              'jarak_tujuan': state
                                                                  .result[i]
                                                                  .jarak_tujuan,
                                                              'waktu_tujuan': state
                                                                  .result[i]
                                                                  .waktu_tujuan,
                                                              'container_id': state
                                                                  .result[i]
                                                                  .container_id,
                                                              'nilaibarang': state
                                                                  .result[i]
                                                                  .nilaibarang,
                                                              'qty': state
                                                                  .result[i]
                                                                  .qty,
                                                              'jenisbarang': state
                                                                  .result[i]
                                                                  .jenisbarang,
                                                              'namabarang': state
                                                                  .result[i]
                                                                  .namabarang,
                                                              'keterangantambahan':
                                                                  state
                                                                      .result[i]
                                                                      .keterangantambahan,
                                                              'invoicetambahan':
                                                                  state
                                                                      .result[i]
                                                                      .invoiceTambahan,
                                                              'merchant_id': state
                                                                  .result[i]
                                                                  .merchant_id,
                                                              'merchant_password':
                                                                  state
                                                                      .result[i]
                                                                      .merchant_password,
                                                              'totalNominal': state
                                                                  .result[i]
                                                                  .totalNominal,
                                                            }));
                                                      } else if (state.result[i]
                                                              .payment_status ==
                                                          '8') {
                                                        BlocProvider.of<
                                                                    ListOrderBloc>(
                                                                context)
                                                            .add(ListPesananOrderNavigatorEvent(
                                                                route:
                                                                    '/payment_success',
                                                                param: {
                                                              'harga_bayar':
                                                                  state
                                                                      .result[i]
                                                                      .harga,
                                                              'noVA': state
                                                                  .result[i]
                                                                  .trx_id,
                                                              'nobukti': state
                                                                  .result[i]
                                                                  .nobukti,
                                                              'payment_status':
                                                                  int.parse(state
                                                                      .result[i]
                                                                      .payment_status!),
                                                              'alamat_asal': state
                                                                  .result[i]
                                                                  .alamat_asal,
                                                              'note_pengirim': state
                                                                  .result[i]
                                                                  .notepengirim,
                                                              'pengirim': state
                                                                  .result[i]
                                                                  .pengirim,
                                                              'notelppengirim':
                                                                  state
                                                                      .result[i]
                                                                      .notelppengirim,
                                                              'alamat_tujuan': state
                                                                  .result[i]
                                                                  .alamat_tujuan,
                                                              'note_penerima': state
                                                                  .result[i]
                                                                  .notepenerima,
                                                              'penerima': state
                                                                  .result[i]
                                                                  .penerima,
                                                              'notelppenerima':
                                                                  state
                                                                      .result[i]
                                                                      .notelppenerima,
                                                              'order_date': state
                                                                  .result[i]
                                                                  .order_date,
                                                              'payment_date': state
                                                                  .result[i]
                                                                  .payment_date,
                                                              'payment_code': state
                                                                  .result[i]
                                                                  .payment_code,
                                                              'link':
                                                                  'List Pesanan',
                                                              'latitude_pelabuhan_asal':
                                                                  state
                                                                      .result[i]
                                                                      .latitude_pelabuhan_asal,
                                                              'longitude_pelabuhan_asal':
                                                                  state
                                                                      .result[i]
                                                                      .longitude_pelabuhan_asal,
                                                              'latitude_pelabuhan_tujuan':
                                                                  state
                                                                      .result[i]
                                                                      .latitude_pelabuhan_tujuan,
                                                              'longitude_pelabuhan_tujuan':
                                                                  state
                                                                      .result[i]
                                                                      .longitude_pelabuhan_tujuan,
                                                              'latitude_muat': state
                                                                  .result[i]
                                                                  .latitude_muat,
                                                              'longitude_muat':
                                                                  state
                                                                      .result[i]
                                                                      .longitude_muat,
                                                              'latitude_bongkar':
                                                                  state
                                                                      .result[i]
                                                                      .latitude_bongkar,
                                                              'longitude_bongkar':
                                                                  state
                                                                      .result[i]
                                                                      .longitude_bongkar,
                                                              'nominalrefund': state
                                                                  .result[i]
                                                                  .nominalrefund,
                                                              'buktipdf': state
                                                                  .result[i]
                                                                  .buktipdf,
                                                              'lampiraninvoice':
                                                                  state
                                                                      .result[i]
                                                                      .lampiraninvoice,
                                                              'placeidasal': state
                                                                  .result[i]
                                                                  .placeidasal,
                                                              'pelabuhanidasal':
                                                                  state
                                                                      .result[i]
                                                                      .pelabuhanidasal,
                                                              'jarak_asal': state
                                                                  .result[i]
                                                                  .jarak_asal,
                                                              'waktu_asal': state
                                                                  .result[i]
                                                                  .waktu_asal,
                                                              'namapelabuhanmuat':
                                                                  state
                                                                      .result[i]
                                                                      .namapelabuhanmuat,
                                                              'namapelabuhanbongkar':
                                                                  state
                                                                      .result[i]
                                                                      .namapelabuhanbongkar,
                                                              'placeidtujuan': state
                                                                  .result[i]
                                                                  .placeidtujuan,
                                                              'pelabuhanidtujuan':
                                                                  state
                                                                      .result[i]
                                                                      .pelabuhanidtujuan,
                                                              'jarak_tujuan': state
                                                                  .result[i]
                                                                  .jarak_tujuan,
                                                              'waktu_tujuan': state
                                                                  .result[i]
                                                                  .waktu_tujuan,
                                                              'container_id': state
                                                                  .result[i]
                                                                  .container_id,
                                                              'nilaibarang': state
                                                                  .result[i]
                                                                  .nilaibarang,
                                                              'qty': state
                                                                  .result[i]
                                                                  .qty,
                                                              'jenisbarang': state
                                                                  .result[i]
                                                                  .jenisbarang,
                                                              'namabarang': state
                                                                  .result[i]
                                                                  .namabarang,
                                                              'keterangantambahan':
                                                                  state
                                                                      .result[i]
                                                                      .keterangantambahan,
                                                              'invoicetambahan':
                                                                  state
                                                                      .result[i]
                                                                      .invoiceTambahan,
                                                              'merchant_id': state
                                                                  .result[i]
                                                                  .merchant_id,
                                                              'merchant_password':
                                                                  state
                                                                      .result[i]
                                                                      .merchant_password,
                                                              'totalNominal': state
                                                                  .result[i]
                                                                  .totalNominal,
                                                            }));
                                                      } else if (state.result[i]
                                                                  .payment_status ==
                                                              '10' ||
                                                          state.result[i]
                                                                  .payment_status ==
                                                              '11') {}
                                                    },
                                                    child: const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 16.0,
                                                                right: 16.0,
                                                                top: 12,
                                                                bottom: 12),
                                                        child: Text(
                                                          "Lihat Detail",
                                                          style: TextStyle(
                                                              fontSize: 14.0,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      } else {
                        return Align(
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 5,
                              ),
                              Image.asset(
                                "assets/imgs/trucking.png",
                                width: 200,
                                height: 200,
                              ),
                              const Text(
                                "TIDAK ADA PESANAN",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 187, 187, 187),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              )
                            ],
                          ),
                        );
                      }
                    }
                    return Container();
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
