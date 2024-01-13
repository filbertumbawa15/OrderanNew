import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasorderan/bloc/pesanan/pesanan/listqty/listqty_bloc.dart';

class ListQty extends StatefulWidget {
  const ListQty({
    Key? key,
  }) : super(key: key);

  @override
  State<ListQty> createState() => _ListQtyState();
}

class _ListQtyState extends State<ListQty> {
  String? nobukti;
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      nobukti = args['nobukti'];
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
          "List Qty",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            fontFamily: 'Nunito-Medium',
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        // backButton: true,
        // rightOptions: false,
      ),
      backgroundColor: const Color(0xFFF1F1EF),
      body: BlocProvider(
        create: (context) =>
            ListqtyBloc()..add(ListQtyOrderEvent(nobukti: nobukti)),
        child: RefreshIndicator(
          onRefresh: () async {},
          child:
              BlocBuilder<ListqtyBloc, ListqtyState>(builder: (context, state) {
            return ListView.builder(
              itemCount: 2,
              itemBuilder: (context, i) {
                return Card(
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'No. Job: ',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 7, 3, 3),
                          ),
                        ),
                        Text(
                          // data.dataqty[i].jobemkl,
                          'asdf',
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 7, 3, 3),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          'No. Container: ',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 7, 3, 3),
                          ),
                        ),
                        Text(
                          // data.dataqty[i].nocont,
                          'asdf',
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 7, 3, 3),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15.0),
                        Text(
                          'No. Pesanan:',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          // data.dataqty[i].nobukti,
                          'asdf',
                          style: const TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 15.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => Tracking(
                          //               kode_container:
                          //                   data.dataqty[i].nocont,
                          //               nobukti: data.dataqty[i].nobukti,
                          //               qty: data.dataqty[i].qty,
                          //               jobemkl: data.dataqty[i].jobemkl,
                          //             )));
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.only(
                              left: 1, right: 1, top: 1, bottom: 1),
                          backgroundColor: const Color(0xFFB7B7B7),
                          elevation: 0,
                          shape: const CircleBorder(),
                        ),
                        child: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
