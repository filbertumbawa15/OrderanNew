import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tasorderan/bloc/pesanan/pesanan/listpesananstatus/listpesananstatus_bloc.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ListStatusPesanan extends StatefulWidget {
  const ListStatusPesanan({
    Key? key,
  }) : super(key: key);

  @override
  State<ListStatusPesanan> createState() => _ListStatusPesananState();
}

class _ListStatusPesananState extends State<ListStatusPesanan> {
  String? nobukti;
  int? qty;

  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration.zero, () {
    //   getStatusBarang();
    // });
  }

  // void getStatusBarang() async {
  //   await Provider.of<MasterProvider>(context, listen: false)
  //       .getStatusBarang(widget.nobukti, widget.qty, widget.jobemkl)
  //       .then((value) {
  //     setState(() {});
  //   });
  //   setState(() {
  //     _dialog.hide();
  //   });
  // }

  // void _initStatusListStatusPesanan() async {
  //   globals.channel.bind('App\\Events\\CheckListStatusPesananOrder',
  //       (PusherEvent event) async {
  //     print(event.data);
  //     final result =
  //         jsonDecode(jsonDecode(event.data)["message"])['status_pesanan'];
  //     if (result == widget.nobukti) {
  //       Future.delayed(Duration.zero, () {
  //         _showDialog(
  //             context, SimpleFontelicoProgressDialogType.normal, 'Normal');
  //         getStatusBarang();
  //       });
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      nobukti = args['nobukti'];
      qty = args['qty'];
    }
    return BlocProvider(
      create: (context) =>
          ListpesananstatusBloc()..add(LoadListPesananStatus(nobukti, qty)),
      child: BlocBuilder<ListpesananstatusBloc, ListpesananstatusState>(
        builder: (context, state) {
          if (state is ListpesananstatusLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ListpesananstatusFailed) {
            return Center(
              child: Text(state.message!),
            );
          } else if (state is ListpesananstatusSuccess) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: SafeArea(
                child: DefaultTabController(
                  length: 2,
                  child: Scaffold(
                    backgroundColor: const Color(0xFFF1F1EF),
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
                        "Status Barang",
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
                    body: Center(
                      child: Column(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const SizedBox(width: 0.0),
                                        Expanded(
                                            // Wrap this column inside an expanded widget so that framework allocates max width for this column inside this row
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            const Text(
                                              'No. Pesanan',
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
                                                        state
                                                            .response!.nobukti!,
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              'Nunito-Medium',
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                const SizedBox(height: 8.0),
                                Column(
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const SizedBox(width: 0.0),
                                        Expanded(
                                            // Wrap this column inside an expanded widget so that framework allocates max width for this column inside this row
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            const Text(
                                              'No. Container',
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
                                                        state.response!
                                                                    .nocont! ==
                                                                ""
                                                            ? "Belum Terbit"
                                                            : state.response!
                                                                .nocont!,
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              'Nunito-Medium',
                                                          fontWeight:
                                                              FontWeight.bold,
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
                              ],
                            ),
                          ),
                          const SizedBox(height: 15.0),
                          Expanded(
                            child: ListView.builder(
                                itemCount:
                                    state.response!.listpesananStatus!.length,
                                itemBuilder: (context, i) {
                                  return Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: TimelineTile(
                                      alignment: TimelineAlign.manual,
                                      lineXY: 0.1,
                                      isFirst: i == 0,
                                      isLast: i ==
                                          state.response!.listpesananStatus!
                                                  .length -
                                              1,
                                      indicatorStyle: IndicatorStyle(
                                        padding: const EdgeInsets.only(
                                            right: 30.0, top: 1.0, bottom: 1.0),
                                        width: 40,
                                        height: 20,
                                        indicator: const _IndicatorExample(
                                            color: Color(0xFF039600)),
                                        iconStyle: IconStyle(
                                          color: Colors.white,
                                          iconData: Icons.insert_emoticon,
                                        ),
                                      ),
                                      beforeLineStyle: const LineStyle(
                                        color: Color(0xFFAEAEAE),
                                        thickness: 1,
                                      ),
                                      endChild: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0,
                                            top: 25,
                                            right: 0,
                                            bottom: 0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                                // Wrap this column inside an expanded widget so that framework allocates max width for this column inside this row
                                                child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                const SizedBox(height: 5.0),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5.0,
                                                          right: 5.0,
                                                          top: 2.0,
                                                          bottom: 2.0),
                                                  decoration:
                                                      const BoxDecoration(
                                                          color:
                                                              Color(0xFFD2E9FF),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          6.0))),
                                                  child: Text(
                                                    DateFormat.yMMMEd('en_US').format(
                                                                DateFormat("yyyy-MM-dd")
                                                                    .parse(state
                                                                        .response!
                                                                        .listpesananStatus![
                                                                            i]
                                                                        .tgl_status!)) ==
                                                            DateFormat.yMMMEd('en_US').format(
                                                                DateTime.now())
                                                        ? "Hari Ini"
                                                        : DateFormat.yMMMEd('en_US')
                                                            .format(DateFormat(
                                                                    "yyyy-MM-dd")
                                                                .parse(state
                                                                    .response!
                                                                    .listpesananStatus![i]
                                                                    .tgl_status!)),
                                                    style: const TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xFF003C96),
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Card(
                                                  elevation: 2,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          state
                                                              .response!
                                                              .listpesananStatus![
                                                                  i]
                                                              .kode_status!,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 17.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 7.0),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Expanded(
                                                                // Then wrap your text widget with expanded
                                                                child: Text(
                                                              state
                                                                  .response!
                                                                  .listpesananStatus![
                                                                      i]
                                                                  .keterangan!,
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14.0,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              softWrap: true,
                                                            )),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )),
                                            // ],
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

class _IndicatorExample extends StatelessWidget {
  const _IndicatorExample({Key? key, this.color}) : super(key: key);

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        border: Border.fromBorderSide(
          BorderSide(
            color: Color(0xFF039600),
            width: 3,
          ),
        ),
      ),
      child: Center(
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
