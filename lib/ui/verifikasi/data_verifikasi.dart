import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tasorderan/bloc/user/verifikasi/verifikasi_cubit.dart';
import 'package:tasorderan/components/components.dart';
import 'package:tasorderan/core/session_manager.dart';
import 'package:tasorderan/params/register_user_params.dart';

class DataVerifikasi extends StatefulWidget {
  const DataVerifikasi({
    Key? key,
  }) : super(key: key);

  @override
  State<DataVerifikasi> createState() => _DataVerifikasiState();
}

class _DataVerifikasiState extends State<DataVerifikasi> {
  @override
  //Data npwp
  ValueNotifier<File>? imageFile_npwp;
  File? npwpPath;
  bool npwp = false;
  final _selectednpwp = TextEditingController();
  final _focusednpwp = FocusNode();

  //Data Ktp
  ValueNotifier<File>? imageFile_ktp;
  File? ktpPath;
  bool ktp = false;
  final _selectednik = TextEditingController();
  final _focusednik = FocusNode();
  final _selectedtgllahir = TextEditingController();
  final _focusedtgllahir = FocusNode();
  final _selectedalamat = TextEditingController();
  final _focusedalamat = FocusNode();
  final _selectednama = TextEditingController();
  final _focusednama = FocusNode();
  final tgllahir = DateFormat("dd-MM-yyyy").parse("01-01-2004");

  //Param
  bool? isEdit;
  final formKey = GlobalKey<FormState>();
  final components = Tools();

  void initState() {
    super.initState();
    // _isButtonDisabled = true;
    // if (widget.isEdit == true) {
    //   setState(() {
    //     _selectednik.text = widget.nik;
    //     _selectednama.text = widget.nama;
    //     _selectedalamat.text = widget.alamatdetail;
    //     _selectedtgllahir.text = DateFormat("dd-MM-yyyy")
    //         .format(DateFormat("yyyy-MM-dd").parse(widget.tglLahir));
    //     _selectednpwp.text = widget.npwp;
    //   });
    // }
    // setState(() {
    //   imageFile_npwp = File(widget.npwpPath.path);
    //   imageFile_ktp = widget.ktpPath;
    // });
  }

  // void scanImage(XFile imageKtp) async {
  //   try {
  //     final scannerProv = await ScannerProvider.instance(context);
  //     if (imageKtp != null) {
  //       await scannerProv.scan(imageKtp);
  //       setState(() {
  //         imageFile_ktp = scannerProv.image;
  //         ktp = true;
  //       });
  //       await Future.delayed(Duration(seconds: 5), () async {
  //         if (scannerProv.nik == null) {
  //           print("null");
  //           return false;
  //         } else {
  //           if (scannerProv.nik.isEmpty) {
  //             setState(() {
  //               ktp = true;
  //             });
  //             print("isempty");
  //             if (_selectednik.text.isNotEmpty &&
  //                 _selectednpwp.text.isNotEmpty &&
  //                 imageFile_ktp != null &&
  //                 imageFile_npwp != null) {
  //               setState(() {
  //                 _isButtonDisabled = false;
  //               });
  //             } else {
  //               _isButtonDisabled = true;
  //             }
  //             return false;
  //           } else {
  //             print("masuk");
  //             if (_selectednik.text.isNotEmpty &&
  //                 _selectednpwp.text.isNotEmpty &&
  //                 imageFile_ktp != null &&
  //                 imageFile_npwp != null) {
  //               setState(() {
  //                 _isButtonDisabled = false;
  //               });
  //             } else {
  //               _isButtonDisabled = true;
  //             }
  //             setState(() {
  //               ktp = true;
  //             });
  //             _selectednik.text = scannerProv.nik[0].nik;
  //             _selectedalamat.text =
  //                 "${scannerProv.nik[0].subdistrict}, ${scannerProv.nik[0].city}, ${scannerProv.nik[0].province}";
  //             _selectedtgllahir.text = DateFormat("dd-MM-yyyy").format(
  //                 DateFormat("yyyy-MM-dd").parse(scannerProv.nik[0].bornDate));
  //             tgllahir = DateFormat("dd-MM-yyyy").parse(DateFormat("dd-MM-yyyy")
  //                 .format(DateFormat("yyyy-MM-dd")
  //                     .parse(scannerProv.nik[0].bornDate)));
  //           }
  //         }
  //       });
  //     }
  //   } on SocketException catch (_) {
  //     Dialogs.materialDialog(
  //         color: Colors.white,
  //         msg: "Mohon cek kembali koneksi internet WiFi/Data anda",
  //         title: 'Tidak ada koneksi',
  //         lottieBuilder: Lottie.asset(
  //           'assets/imgs/no-internet.json',
  //           fit: BoxFit.contain,
  //         ),
  //         context: context,
  //         actions: [
  //           IconsButton(
  //             onPressed: () async {
  //               Navigator.of(context).pop();
  //             },
  //             text: 'Coba Lagi',
  //             iconData: Icons.done,
  //             color: Colors.blue,
  //             textStyle: TextStyle(color: Colors.white),
  //             iconColor: Colors.white,
  //           ),
  //         ]);
  //   }
  // }

  // Future getImage(context, File imagenpwp) async {
  //   if (imagenpwp != null) {
  //     setState(() {
  //       imageFile_npwp = File(imagenpwp.path);
  //       npwp = true;
  //     });
  //     if (_selectednik.text.isNotEmpty &&
  //         _selectednpwp.text.isNotEmpty &&
  //         imageFile_ktp != null &&
  //         imageFile_npwp != null) {
  //       setState(() {
  //         _isButtonDisabled = false;
  //       });
  //     }
  //   }
  // }

  // _uploadFile(File ktp, File npwp, String nik, String name, String alamat,
  //     String tgllahir, String no_npwp) async {
  //   _showDialog(context, SimpleFontelicoProgressDialogType.normal, 'Normal');
  //   String ktpPath = ktp.path.split('/').last;
  //   String npwpPath = npwp.path.split('/').last;
  //   var data = FormData.fromMap({
  //     "foto_ktp": await MultipartFile.fromFile(
  //       ktp.path,
  //       filename: ktpPath,
  //     ),
  //     "foto_npwp": await MultipartFile.fromFile(
  //       npwp.path,
  //       filename: npwpPath,
  //     ),
  //     "nik": nik,
  //     "name": name,
  //     "alamatdetail": alamat,
  //     "tgl_lahir": DateFormat("dd-MM-yyyy").parse(tgllahir),
  //     "no_npwp": no_npwp,
  //     "user_id": globals.loggedinId,
  //   });
  //   Dio dio = new Dio();

  //   try {
  //     var response = await dio.post(
  //       "https://web.transporindo.com/api-orderemkl/public/api/user/upload_gambar",
  //       data: data,
  //       options: Options(
  //         headers: {
  //           'Accept': 'application/json',
  //           'Content-type': 'application/json',
  //           'Authorization': 'Bearer ${globals.accessToken}',
  //         },
  //       ),
  //     );
  //     globals.prefs
  //         .setString('user', jsonEncode(response.data['statusverifikasi']));
  //     setState(() {
  //       globals.verificationStatus =
  //           response.data['statusverifikasi']['statusverifikasi'].toString();
  //     });
  //     await editVerifikasi();
  //     await _dialog.hide();
  //     // authUser(context, globals.loggedinEmail, password, _dialog, fcmToken)
  //     Navigator.of(context)
  //         .pushReplacement(EnterExitRoute(enterPage: WaitingVerifikasi()));
  //   } on DioError catch (e) {
  //     if (e.response.statusCode == 500) {
  //       await _dialog.hide();
  //       globals.alertBerhasilPesan(context, "Mohon untuk dicoba kembali lagi",
  //           'Internal Server Error', 'assets/imgs/no-internet.json');
  //       print(e.response.data);
  //       print(e.response.headers);
  //       print(e.response.requestOptions);
  //     } else if (e.response.statusCode == 442) {
  //       await _dialog.hide();
  //       globals.alertBerhasilPesan(
  //           context,
  //           "Tidak bisa memasukkan nik yang sudah terdaftar",
  //           'nik sudah ada',
  //           'assets/imgs/user-denied.json');
  //     } else {
  //       await _dialog.hide();
  //       print('not connected');
  //       globals.alertBerhasilPesan(
  //           context,
  //           "Mohon cek kembali koneksi internet WiFi/Data anda",
  //           'Tidak ada koneksi',
  //           'assets/imgs/no-internet.json');
  //     }
  //   } on SocketException catch (_) {
  //     await _dialog.hide();
  //     print('not connected');
  //     globals.alertBerhasilPesan(
  //         context,
  //         "Mohon cek kembali koneksi internet WiFi/Data anda",
  //         'Tidak ada koneksi',
  //         'assets/imgs/no-internet.json');
  //   }
  // }

  @override
  void dispose() {
    super.dispose();
    _focusednpwp.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      imageFile_ktp = ValueNotifier<File>(args["imageFile_ktp"]);
      imageFile_npwp = ValueNotifier<File>(args["imageFile_npwp"]);
    }
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
          child: ListView(
            children: [
              Column(
                children: [
                  const SizedBox(height: 15.0),
                  const Text("Pengisian Data Diri",
                      style: TextStyle(
                          fontFamily: 'Nunito-ExtraBold', fontSize: 18.0)),
                  const Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Text(
                      'Isi data diri dari NIK, Nama, Alamat sesuai dengan \n KTP, Tgl Lahir, serta no. NPWP, dan mohon di cek \n kembali sebelum menekan tombol submit.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFF9F9F9F)),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Container(
                    padding: const EdgeInsets.only(top: 12.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Form(
                      key: formKey,
                      autovalidateMode: AutovalidateMode.always,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 3.0, bottom: 8.0, left: 17.0, right: 17.0),
                            child: SizedBox(
                              child: TextFormField(
                                style: const TextStyle(
                                  fontSize: 13.0,
                                ),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(16),
                                ],
                                keyboardType: TextInputType.number,
                                controller: _selectednik,
                                focusNode: _focusednik,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 15.0),
                                  border: OutlineInputBorder(),
                                  hintText: 'NIK',
                                  hintStyle: TextStyle(
                                    fontSize: 13.0,
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "KTP Tidak boleh kosong";
                                  } else if (value.length < 16) {
                                    return "NIK Wajib 16 Angka";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 17.0,
                              right: 17.0,
                            ),
                            child: SizedBox(
                              child: TextFormField(
                                style: const TextStyle(
                                  fontSize: 13.0,
                                ),
                                inputFormatters: [
                                  UpperCaseTextFormatter(),
                                ],
                                controller: _selectednama,
                                focusNode: _focusednama,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 15.0),
                                  border: OutlineInputBorder(),
                                  hintText: 'Nama',
                                  hintStyle: TextStyle(
                                    fontSize: 13.0,
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Nama tidak boleh kosong";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 3.0, bottom: 8.0, left: 17.0, right: 17.0),
                            child: SizedBox(
                              child: TextFormField(
                                style: const TextStyle(
                                  fontSize: 13.0,
                                ),
                                inputFormatters: [
                                  UpperCaseTextFormatter(),
                                ],
                                textCapitalization:
                                    TextCapitalization.sentences,
                                controller: _selectedalamat,
                                focusNode: _focusedalamat,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 15.0),
                                  border: OutlineInputBorder(),
                                  hintText: 'Alamat Detail (Sesuai KTP)',
                                  hintStyle: TextStyle(
                                    fontSize: 13.0,
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Alamat tidak boleh kosong";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 3.0, bottom: 8.0, left: 17.0, right: 17.0),
                            child: SizedBox(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: _selectedtgllahir,
                                focusNode: _focusedtgllahir,
                                readOnly: true,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                style: const TextStyle(
                                  fontSize: 13.0,
                                ),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 15.0),
                                  border: OutlineInputBorder(),
                                  hintText: 'Tgl Lahir',
                                  hintStyle: TextStyle(
                                    fontSize: 13.0,
                                  ),
                                ),
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: isEdit == true
                                          ? DateFormat("dd-MM-yyyy").parse(
                                              DateFormat("dd-MM-yyyy").format(
                                                  DateFormat("yyyy-MM-dd")
                                                      .parse(_selectedtgllahir
                                                          .text)))
                                          : tgllahir,
                                      firstDate: DateTime(
                                          1942), //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime(2005));

                                  if (pickedDate != null) {
                                    String formattedDate =
                                        DateFormat('dd-MM-yyyy')
                                            .format(pickedDate);
                                    setState(() {
                                      _selectedtgllahir.text = formattedDate;
                                    });
                                  }
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Tgl Lahir tidak boleh kosong";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 3.0, bottom: 8.0, left: 17.0, right: 17.0),
                            child: SizedBox(
                              child: TextFormField(
                                controller: _selectednpwp,
                                focusNode: _focusednpwp,
                                inputFormatters: [
                                  MaskTextInputFormatter(
                                    mask: "##.###.###.#-###.###",
                                    type: MaskAutoCompletionType.lazy,
                                  )
                                ],
                                autocorrect: false,
                                keyboardType: TextInputType.number,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                style: const TextStyle(
                                  fontSize: 13.0,
                                ),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 15.0),
                                  border: OutlineInputBorder(),
                                  hintText: 'NPWP',
                                  hintStyle: TextStyle(
                                    fontSize: 13.0,
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "NPWP tidak boleh kosong";
                                  } else if (value.length < 20) {
                                    return "NPWP wajib 20 angka";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 3.0, bottom: 8.0, left: 17.0, right: 17.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    ValueListenableBuilder(
                                        valueListenable: imageFile_ktp!,
                                        builder: (context, value, index) {
                                          return ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: GestureDetector(
                                              onTap: () {},
                                              child: CustomPaint(
                                                child: Hero(
                                                  tag: 'image1',
                                                  child: Image.file(
                                                    value,
                                                    fit: BoxFit.contain,
                                                    width: 158,
                                                    height: 100,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                    if (isEdit == true) ...[
                                      TextButton(
                                        onPressed: () async {},
                                        child: const Text("Edit Foto KTP"),
                                      ),
                                    ],
                                  ],
                                ),
                                Column(
                                  children: [
                                    ValueListenableBuilder(
                                        valueListenable: imageFile_npwp!,
                                        builder: (context, value, index) {
                                          return ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: GestureDetector(
                                              onTap: () {},
                                              child: CustomPaint(
                                                child: Hero(
                                                  tag: 'image2',
                                                  child: Image.file(
                                                    value,
                                                    fit: BoxFit.contain,
                                                    width: 158,
                                                    height: 100,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                    if (isEdit == true) ...[
                                      TextButton(
                                        onPressed: () async {},
                                        child: const Text("Edit Foto NPWP"),
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BlocProvider(
        create: (context) => VerifikasiCubit(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 300,
            child: BlocConsumer<VerifikasiCubit, VerifikasiState>(
                listener: (context, state) {
              if (state is VerifikasiSuccess) {
                Future.delayed(const Duration(seconds: 0), () {
                  components.dia!.hide();
                  Navigator.pushReplacementNamed(
                      context, '/waiting_verifikasi');
                });
              }
            }, builder: (context, state) {
              if (state is VerifikasiLoading) {
                Future.delayed(const Duration(seconds: 0), () {
                  components.showDia();
                });
              } else if (state is VerifikasiFailed) {
                Future.delayed(const Duration(seconds: 0), () {
                  components.dia!.hide();
                  print(state.message);
                });
              }
              return ElevatedButton(
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
                  if (formKey.currentState!.validate()) {
                    BlocProvider.of<VerifikasiCubit>(context).verifikasiData(
                      VerifikasiUserParam(
                        imageFile_ktp!.value,
                        imageFile_npwp!.value,
                        _selectednik.text,
                        _selectednama.text,
                        _selectedalamat.text,
                        DateFormat("dd-MM-yyyy").parse(_selectedtgllahir.text),
                        _selectednpwp.text,
                        SessionManager().getActiveId(),
                      ),
                    );
                  }
                },
                child: const Padding(
                    padding: EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 12, bottom: 12),
                    child: Text("Submit",
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Nunito-Medium'))),
              );
            }),
          ),
        ),
      ),
    );
  }
}
