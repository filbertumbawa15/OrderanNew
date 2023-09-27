import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:meta/meta.dart';
import 'package:tasorderan/core/session_manager.dart';
import 'package:tasorderan/main.dart';
import 'package:tasorderan/params/register_user_params.dart';
import 'package:tasorderan/repo/auth_repository.dart';

part 'verifikasi_state.dart';

class VerifikasiCubit extends Cubit<VerifikasiState> {
  final authRepository = AuthRepository();
  final sessionManager = SessionManager();
  VerifikasiCubit() : super(VerifikasiInitial());

  void ktpVerifikasi() async {
    try {
      final response =
          await navigatorKey.currentState?.pushNamed('/camera_verifikasi');
      if (response == null) {
        VerifikasiKtpFailed();
      } else {
        Map<String, dynamic> dataFile = jsonDecode(jsonEncode(response));
        final getFile =
            await authRepository.initializeFile(dataFile["croppedImage"]);
        emit(VerifikasiKtpSuccess(getFile));
      }
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
        sessionManager.getActiveName(),
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
      );
      emit(VerifikasiSuccess());
    } catch (e) {
      emit(VerifikasiFailed(e.toString()));
    }
  }

  void cekVerifikasi(int id) async {
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
        sessionManager.getActiveName(),
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
      );
      if (response["statusverifikasi"] == "14") {
        emit(VerifikasiCekSuccess(
          message:
              'Maaf, data akun anda masih ditolak oleh kami. Silahkan cek kembali dan ajukan agar kami dapat mengecek kembali.',
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
}
