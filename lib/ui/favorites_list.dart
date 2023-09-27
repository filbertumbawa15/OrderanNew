import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasorderan/bloc/user/favorite/favorite_cubit.dart';

class FavoritesList extends StatefulWidget {
  const FavoritesList({Key? key}) : super(key: key);

  @override
  State<FavoritesList> createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> {
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   getDataFavorit();
    // });
    // print(widget.param);
  }

  String? param;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    param = args?['param'];
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF747474),
            ),
          ),
          title: const Text(
            "List Favorit Tempat",
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
        backgroundColor: const Color(0xFFE6E6E6),
        body: BlocProvider(
          create: (context) => FavoriteCubit(),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: BlocBuilder<FavoriteCubit, FavoriteState>(
              builder: (context, state) {
                if (state is FavoriteLoading) {
                  return const Align(
                    alignment: Alignment.topCenter,
                    child: CircularProgressIndicator(),
                  );
                } else if (state is FavoriteFailed) {
                  print(state.message);
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
                        Text(
                          state.message.toString(),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 187, 187, 187),
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )
                      ],
                    ),
                  );
                } else if (state is FavoriteSuccess) {
                  if (state.listFavorites.isNotEmpty) {
                    return ListView.separated(
                      itemCount: state.listFavorites.length,
                      itemBuilder: (BuildContext context, index) {
                        return ListTile(
                          title: Text(
                            state.listFavorites[index].labelName.toString(),
                            style: const TextStyle(
                              fontFamily: 'Nunito-Medium',
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          subtitle: Text(
                            state.listFavorites[index].alamat.toString(),
                            style: const TextStyle(
                              fontFamily: 'Nunito-Medium',
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                          ),
                          trailing: param == 'List'
                              ? IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () async {
                                    // Provider.of<MasterProvider>(context,
                                    //         listen: false)
                                    //     .deleteFavoritesData(
                                    //         data.datafavorit[index].id);
                                    // Fluttertoast.showToast(
                                    //   msg: "Data favorit berhasil dihapus",
                                    //   toastLength: Toast.LENGTH_SHORT,
                                    //   gravity: ToastGravity.BOTTOM,
                                    //   timeInSecForIosWeb: 1,
                                    //   textColor: Colors.white,
                                    //   fontSize: 16.0,
                                    // );
                                  },
                                )
                              : const SizedBox(height: 1.0),
                          onTap: () {
                            if (param == 'List') {
                              return;
                            } else {
                              Navigator.pop(
                                context,
                                {
                                  '_placeid':
                                      state.listFavorites[index].placeid,
                                  '_pelabuhanid':
                                      state.listFavorites[index].pelabuhanid,
                                  'alamat': state.listFavorites[index].alamat,
                                  'customer':
                                      state.listFavorites[index].customer,
                                  'notelp':
                                      state.listFavorites[index].notelpcustomer,
                                  'latitude_place':
                                      state.listFavorites[index].latitudeplace,
                                  'longitude_place':
                                      state.listFavorites[index].longitudeplace,
                                  'namapelabuhan':
                                      state.listFavorites[index].namapelabuhan,
                                  'note': state.listFavorites[index].note,
                                  'latitude_pelabuhan': state
                                      .listFavorites[index].latitudepelabuhan,
                                  'longitude_pelabuhan': state
                                      .listFavorites[index].longitudepelabuhan,
                                  '_originController':
                                      "${state.listFavorites[index].latitudepelabuhan}, ${state.listFavorites[index].longitudepelabuhan}",
                                  'merchant_id':
                                      state.listFavorites[index].merchantId,
                                  'merchant_password': state
                                      .listFavorites[index].merchantPassword,
                                  'distance':
                                      state.listFavorites[index].distance,
                                  'duration':
                                      state.listFavorites[index].duration,
                                },
                              );
                            }
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          thickness: 0.5,
                          color: Colors.black26,
                        );
                      },
                    );
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
                            "BELUM ADA LIST FAVORIT",
                            style: TextStyle(
                                color: Color.fromARGB(255, 187, 187, 187),
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          )
                        ],
                      ),
                      // } else {
                      //   return ListView.separated(
                      //     itemCount: data.datafavorit.length,
                      //     itemBuilder: (BuildContext context, index) {
                      //       return ListTile(
                      //         title: Text(
                      //           data.datafavorit[index].labelName.toString(),
                      //           style: TextStyle(
                      //             fontFamily: 'Nunito-Medium',
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: 18.0,
                      //           ),
                      //         ),
                      //         subtitle: Text(
                      //           data.datafavorit[index].alamat.toString(),
                      //           style: TextStyle(
                      //             fontFamily: 'Nunito-Medium',
                      //             fontSize: 14.0,
                      //             color: Colors.black,
                      //           ),
                      //         ),
                      //         trailing: widget.param == 'List'
                      //             ? IconButton(
                      //                 icon: Icon(Icons.delete),
                      //                 onPressed: () async {
                      //                   // Provider.of<MasterProvider>(context,
                      //                   //         listen: false)
                      //                   //     .deleteFavoritesData(
                      //                   //         data.datafavorit[index].id);
                      //                   // Fluttertoast.showToast(
                      //                   //   msg: "Data favorit berhasil dihapus",
                      //                   //   toastLength: Toast.LENGTH_SHORT,
                      //                   //   gravity: ToastGravity.BOTTOM,
                      //                   //   timeInSecForIosWeb: 1,
                      //                   //   textColor: Colors.white,
                      //                   //   fontSize: 16.0,
                      //                   // );
                      //                 },
                      //               )
                      //             : SizedBox(height: 1.0),
                      //         onTap: () {
                      //           // if (widget.param == 'List') {
                      //           //   return false;
                      //           // } else {
                      //           //   Navigator.pop(
                      //           //     context,
                      //           //     {
                      //           //       '_placeid': data.datafavorit[index].placeid,
                      //           //       '_pelabuhanid':
                      //           //           data.datafavorit[index].pelabuhanid,
                      //           //       'alamat': data.datafavorit[index].alamat,
                      //           //       'customer': data.datafavorit[index].customer,
                      //           //       'notelp': data.datafavorit[index].notelpcustomer,
                      //           //       'latitude_place':
                      //           //           data.datafavorit[index].latitudeplace,
                      //           //       'longitude_place':
                      //           //           data.datafavorit[index].longitudeplace,
                      //           //       'namapelabuhan':
                      //           //           data.datafavorit[index].namapelabuhan,
                      //           //       'note': data.datafavorit[index].note,
                      //           //     },
                      //           //   );
                      //           // }
                      //         },
                      //       );
                      //     },
                      //     separatorBuilder: (BuildContext context, int index) {
                      //       return const Divider(
                      //         thickness: 0.5,
                      //         color: Colors.black26,
                      //       );
                      //     },
                      //   );
                      // }
                    );
                  }
                }
                return Container();
              },
            ),
          ),
        ));
  }
}
