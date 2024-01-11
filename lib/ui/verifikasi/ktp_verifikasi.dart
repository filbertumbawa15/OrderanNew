import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:tasorderan/bloc/user/verifikasi/verifikasi_cubit.dart';

class KtpVerifikasi extends StatefulWidget {
  const KtpVerifikasi({
    Key? key,
  }) : super(key: key);

  @override
  State<KtpVerifikasi> createState() => _KtpVerifikasiState();
}

class _KtpVerifikasiState extends State<KtpVerifikasi> {
  ValueNotifier<File>? imageFile_ktp;
  bool ktp = false;
  String? nik;
  String? name;
  String? alamat;
  String? tglLahir;

  @override
  void initState() {
    imageFile_ktp = ValueNotifier<File>(File(''));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1F1EF),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: const Color(0xFFF1F1EF),
      body: BlocProvider(
        create: (context) => VerifikasiCubit(),
        child: Container(
          alignment: Alignment.topCenter,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 15.0),
              const Text("Scan Foto KTP",
                  style: TextStyle(
                      fontFamily: 'Nunito-ExtraBold', fontSize: 18.0)),
              const Padding(
                padding: EdgeInsets.all(3.0),
                child: Text(
                  'Taruh foto ktp anda dan sesuaikan nantinya \n dengan garis pembantu yang telah disediakan di \n kamera.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF9F9F9F)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(35.0),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    color: Colors.white,
                  ),
                  child: ValueListenableBuilder(
                    valueListenable: imageFile_ktp!,
                    builder: (context, value, index) {
                      print(value.path);
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: value.path == ''
                            ? Lottie.asset('assets/imgs/idcard-scan.json')
                            : Padding(
                                padding: const EdgeInsets.all(35.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      // Navigator.of(context).push(MaterialPageRoute(
                                      //     builder: ((context) => PhotoViews(
                                      //           imageFile: imageFile_ktp,
                                      //           name: 'ktp',
                                      //         ))));
                                    },
                                    child: Container(
                                      color: Colors.black,
                                      child: CustomPaint(
                                        child: Hero(
                                          tag: 'image1',
                                          child: Image.file(
                                            File(imageFile_ktp!.value.path),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BlocProvider(
        create: (context) => VerifikasiCubit(),
        child: BlocConsumer<VerifikasiCubit, VerifikasiState>(
          listener: (context, state) {
            if (state is VerifikasiKtpSuccess) {
              debugPrint("Baca nik:  ${state.param['ktp']['nik']}");
              nik = state.param['ktp']['nik'];
              name = state.param['ktp']['nama'];
              alamat = state.param['ktp']['alamat'];
              tglLahir = state.param['ktp']['tglLahir'];
              imageFile_ktp!.value = File(state.param['imagePath']);
            } else if (state is VerifikasiKtpFailed) {
              debugPrint("Gagal");
            }
          },
          builder: (context, state) {
            return ValueListenableBuilder(
              valueListenable: imageFile_ktp!,
              builder: (context, value, index) {
                if (value.path == '') {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 300,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5599E9),
                          textStyle: const TextStyle(
                            color: Colors.white,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                        onPressed: () async {
                          BlocProvider.of<VerifikasiCubit>(context)
                              .ktpVerifikasi();
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 12, bottom: 12),
                          child: Text(
                            "Lakukan Scan",
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Nunito-Medium',
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () async {
                              BlocProvider.of<VerifikasiCubit>(context)
                                  .ktpVerifikasi();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF5599E9),
                            ),
                            child: const Text(
                              "Ambil Ulang",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Nunito-Medium',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/npwp_verifikasi',
                                arguments: {
                                  'imageFile_ktp': imageFile_ktp!.value,
                                  "nik": nik,
                                  "name": name,
                                  "alamat": alamat,
                                  "tglLahir": tglLahir,
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF5599E9),
                            ),
                            child: const Text(
                              "Lanjutkan ke Verifikasi NPWP",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Nunito-Medium',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
