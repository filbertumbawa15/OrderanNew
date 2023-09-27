import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasorderan/core/session_manager.dart';
import 'package:tasorderan/repo/home_repository.dart';
import 'package:tasorderan/repo/pesanan_repository.dart';

part 'validasi_event.dart';
part 'validasi_state.dart';

class ValidasiBloc extends Bloc<ValidasiEvent, ValidasiState> {
  ValidasiBloc() : super(ValidasiInitial()) {
    final sessionManager = SessionManager();
    final homeRepository = HomeRepository();
    final pesananRepository = PesananRepository();
    on<ValidasiEvent>((event, emit) async {
      if (event is PesananValidasiEvent) {
        emit(ValidasiLoading());
        try {
          await homeRepository.cekValidasiPesanan();
          emit(ValidasiSuccess());
        } on Object catch (_) {
          Map<String, dynamic> result = jsonDecode(_.toString());
          emit(ValidasiFailed(
            result["message"],
            result["content"],
            result["images"],
          ));
        }
      } else if (event is HistoryValidasiEvent) {
        try {
          final validateLogin = sessionManager.getActiveId();
          if (validateLogin == null) {
            emit(HistoryFailed(
              "Silahkan Login terlebih dahulu",
              'Masih belum berhasil',
              'assets/imgs/updated-transaction.json',
            ));
          } else {
            if (sessionManager.getActiveVerification() == "12" ||
                sessionManager.getActiveVerification() == "14" ||
                sessionManager.getActiveVerification() == "0") {
              emit(HistoryFailed(
                "Anda belum menyelesaikan status verifikasi anda/belum login",
                'Masih belum berhasil',
                'assets/imgs/updated-transaction.json',
              ));
            } else {
              emit(HistorySuccecss());
            }
          }
        } catch (e) {
          emit(HistoryFailed(
            e.toString(),
            'Masih belum berhasil',
            'assets/imgs/updated-transaction.json',
          ));
        }
      }
    });
  }
}
//   void _validasiPesanan(
//       PesananValidasiEvent event, Emitter<ValidasiState> emit) async {
//     emit(ValidasiLoading());
//     try {
//       final response = await homeReposoty
//     } catch (e) {
//       emit(ValidasiFailed(
//         e.toString(),
//         'Masih belum berhasil',
//         'assets/imgs/updated-transaction.json',
//       ));
//     }
//   }
// }

        // final validateLogin = sessionManager.getActiveId();
        // try {
        //   emit(ValidasiLoading());
        //   // print("baca cek validasi pesanan");
        //   // print(sessionManager.getActiveId());
        //   if (validateLogin == null) {
        //     print("baca taik");
        //     emit(ValidasiFailed(
        //       "Silahkan Login terlebih dahulu",
        //       'Masih belum berhasil',
        //       'assets/imgs/updated-transaction.json',
        //     ));
        //   }
        // } catch (e) {
        //   emit(ValidasiFailed(
        //     e.toString(),
        //     'Masih belum berhasil',
        //     'assets/imgs/updated-transaction.json',
        //   ));
        // }
