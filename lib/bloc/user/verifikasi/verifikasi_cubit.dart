import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:mnc_identifier_ocr/mnc_identifier_ocr.dart';
import 'package:tasorderan/core/session_manager.dart';
import 'package:tasorderan/main.dart';
import 'package:tasorderan/params/register_user_params.dart';
import 'package:tasorderan/repo/auth_repository.dart';
import 'package:tasorderan/ui/verifikasi/data_verifikasi.dart';

part 'verifikasi_state.dart';

class VerifikasiCubit extends Cubit<VerifikasiState> {
  final authRepository = AuthRepository();
  final sessionManager = SessionManager();
  VerifikasiCubit() : super(VerifikasiInitial());

  void ktpVerifikasi() async {
    try {
      // final response =
      //     await navigatorKey.currentState?.pushNamed('/camera_verifikasi');
      final response = await MncIdentifierOcr.startCaptureKtp(
          withFlash: true, cameraOnly: true);
      debugPrint("Baca getFile:  ${response.toMap()}");
      // if (response == null) {
      //   emit(VerifikasiKtpFailed());
      // } else {
      Map<String, dynamic> dataFile = response.toMap();
      // final getFile =
      //     await authRepository.initializeFile(dataFile["imagePath"]);
      debugPrint("Baca getFile:  $dataFile");
      emit(VerifikasiKtpSuccess(dataFile));
      // }
    } catch (e) {
      emit(VerifikasiKtpFailed());
    }
  }

  void npwpVerifikasi() async {
    try {
      final response =
          await navigatorKey.currentState?.pushNamed('/camera_verifikasi');
      if (response == null) {
        VerifikasiNpwpFailed();
      } else {
        Map<String, dynamic> dataFile = jsonDecode(jsonEncode(response));
        final getFile =
            await authRepository.initializeFile(dataFile["croppedImage"]);
        emit(VerifikasiNpwpSuccess(getFile));
      }
    } catch (e) {
      emit(VerifikasiNpwpFailed());
    }
  }

  void verifikasiData(VerifikasiUserParam param) async {
    try {
      emit(VerifikasiLoading());
      final response = await authRepository.verifikasiUser(param);
      final ktpPathResult = await authRepository.getKtpImage(
        response["foto_ktp"].toString(),
      );
      final npwpPathResult = await authRepository.getnpwpImage(
        response["foto_npwp"].toString(),
      );
      sessionManager.setSession(
        response["name"].toString(),
        sessionManager.getActiveUser(),
        sessionManager.getActiveTelp(),
        sessionManager.getActiveId(),
        response["statusverifikasi"].toString(),
        sessionManager.getActiveEmail(),
        sessionManager.getActiveName(),
        sessionManager.getActiveToken(),
        ktpPathResult.path,
        npwpPathResult.path,
        response["nik"].toString(),
        response["no_npwp"].toString(),
        response["tgl_lahir"].toString(),
        response["alamatdetail"].toString(),
      );
      emit(VerifikasiSuccess());
    } catch (e) {
      emit(VerifikasiFailed(e.toString()));
    }
  }

  void cekVerifikasi(String param, int id) async {
    try {
      emit(VerifikasiCekLoading());
      final response = await authRepository.cekVerification(id);
      final ktpPathResult = await authRepository.getKtpImage(
        response["foto_ktp"].toString(),
      );
      final npwpPathResult = await authRepository.getnpwpImage(
        response["foto_npwp"].toString(),
      );
      sessionManager.setSession(
        response["name"].toString(),
        sessionManager.getActiveUser(),
        sessionManager.getActiveTelp(),
        sessionManager.getActiveId(),
        response["statusverifikasi"].toString(),
        sessionManager.getActiveEmail(),
        sessionManager.getActiveName(),
        sessionManager.getActiveToken(),
        ktpPathResult.path,
        npwpPathResult.path,
        response["nik"].toString(),
        response["no_npwp"].toString(),
        response["tgl_lahir"].toString(),
        response["alamatdetail"].toString(),
      );
      if (response["statusverifikasi"] == "14") {
        emit(VerifikasiCekSuccess(
          message:
              'Data anda ditolak karena tidak memenuhi syarat, silahkan lakukan verifikasi data sekali lagi. \n\nKeterangan : ${param.toLowerCase()}',
          title: 'Verifikasi Akun Ditolak',
          path: 'assets/imgs/user-denied.json',
          action: IconsButton(
            onPressed: () async {
              navigatorKey.currentState?.pushReplacementNamed('/home');
            },
            text: 'Ok',
            iconData: Icons.done,
            color: Colors.blue,
            textStyle: const TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ));
      } else if (response["statusverifikasi"] == "13") {
        emit(VerifikasiCekSuccess(
          message:
              'Selamat, data akun anda telah disetujui oleh pihak kami. Silahkan lakukan order untuk dan fitur lainnya dari kami.',
          title: 'Verifikasi Akun Disetujui',
          path: 'assets/imgs/shipping-truck.json',
          action: IconsButton(
            onPressed: () async {
              navigatorKey.currentState?.pushReplacementNamed('/home');
            },
            text: 'Ok',
            iconData: Icons.done,
            color: Colors.blue,
            textStyle: const TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ));
      }
    } catch (e) {
      emit(VerifikasiCekFailed());
    }
  }

  void editVerifikasi({@required String? route, bool? isEdit}) async {
    try {
      emit(EditVerifikasiLoading());
      Object param = {
        'imageFileKtp': File(sessionManager.getKtpPath()!),
        'imageFileNpwp': File(sessionManager.getNpwpPath()!),
        'nik': sessionManager.getActiveNik(),
        'nama': sessionManager.getActiveName(),
        'alamat': sessionManager.getActiveAlamat(),
        'tglLahir': sessionManager.getActiveTglLahir(),
        'npwp': sessionManager.getActiveNpwp(),
        'userId': sessionManager.getActiveId(),
        'isEdit': true,
      };
      final response =
          await navigatorKey.currentState?.pushNamed(route!, arguments: param);
      // final response = await navigatorKey.currentState?.push(MaterialPageRoute(
      //     builder: (context) => DataVerifikasi(
      //           imageFileKtp: File(sessionManager.getKtpPath()!),
      //           imageFileNpwp: File(sessionManager.getNpwpPath()!),
      //           nik: sessionManager.getActiveNik(),
      //           nama: sessionManager.getActiveName(),
      //           alamat: sessionManager.getActiveAlamat(),
      //           tglLahir: sessionManager.getActiveTglLahir(),
      //           npwp: sessionManager.getActiveNpwp(),
      //           userId: sessionManager.getActiveId(),
      //           isEdit: true,
      //         )));
      if (response == null) {
        emit(EditVerifikasiFailed());
      } else {
        emit(EditVerifikasiSuccess(response));
      }
    } catch (e) {
      emit(EditVerifikasiFailed());
    }
  }
}
