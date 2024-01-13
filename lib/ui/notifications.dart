import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tasorderan/bloc/home/notifications/notifications_bloc.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          "Notifikasi",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            fontFamily: 'Nunito-Medium',
          ),
        ),
        backgroundColor: Colors.white,
        // backButton: true,
        // rightOptions: false,
      ),
      backgroundColor: const Color(0xFFF1F1EF),
      body: BlocProvider(
        create: (context) => NotificationsBloc()..add(NotificationsLoad()),
        child: Container(
          padding: const EdgeInsets.all(14.0),
          child: BlocBuilder<NotificationsBloc, NotificationsState>(
            builder: (context, state) {
              if (state is NotificationsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is NotificationsLoaded) {
                if (state.result.isEmpty) {
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
                          "BELUM ADA HISTORI NOTIFIKASI",
                          style: TextStyle(
                              color: Color.fromARGB(255, 187, 187, 187),
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )
                      ],
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: state.result.length,
                    itemBuilder: ((context, i) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('dd MMM yyyy').format(
                                DateFormat('yyyy-MM-dd HH:mm:ss')
                                    .parse(state.result[i].tgl!)),
                            style: const TextStyle(
                              fontFamily: 'Nunito-Extrabold',
                              fontSize: 20.0,
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.result[i].dataNotification!.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, index2) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  tileColor:
                                      const Color.fromARGB(255, 228, 228, 228),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  leading: Column(
                                    children: [
                                      const Icon(Icons.notifications),
                                      const SizedBox(height: 10.0),
                                      Text(
                                        // data.datanotif[index]
                                        //       .dataNotifikasi[index2]['created_at']
                                        DateFormat('HH:mm:ss').format(
                                            DateFormat('yyyy-MM-ddTHH:mm:ss')
                                                .parse(
                                          state.result[i]
                                                  .dataNotification![index2]
                                              ['created_at'],
                                        )),
                                      ),
                                    ],
                                  ),
                                  title: Text(state.result[i]
                                      .dataNotification![index2]['header']),
                                  subtitle: Text(state.result[i]
                                      .dataNotification![index2]['text']),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    }),
                  );
                }
              } else if (state is NotificationsFailed) {
                print(state.message);
                return Center(
                  child: Text(state.message),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
