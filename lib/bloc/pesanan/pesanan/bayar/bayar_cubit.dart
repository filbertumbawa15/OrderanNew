import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tasorderan/core/api_client.dart';
import 'package:tasorderan/models/pesanan_models.dart';
import 'package:tasorderan/params/pesanan_params.dart';
import 'package:tasorderan/repo/pesanan_repository.dart';
import 'package:wakelock/wakelock.dart';

part 'bayar_state.dart';

class BayarCubit extends Cubit<BayarState> {
  BayarCubit() : super(const BayarInitial());

  Timer? _timer;
  final pesananRepository = PesananRepository();
  final apiClient = ApiClient();
  // onTick(Timer timer) {
  //   if (state is BayarInProgress) {
  //     BayarInProgress wip = state as BayarInProgress;
  //     if (wip.elapsed! < 110) {
  //       emit(BayarInProgress(wip.elapsed! + 1));
  //     } else {
  //       _timer!.cancel();
  //       Wakelock.disable();
  //       emit(const BayarInitial());
  //     }
  //   }
  // }

  // startWorkout([int? index]) {
  //   Wakelock.enable();
  //   if (index != null) {
  //     emit(const BayarInProgress(0));
  //   } else {
  //     emit(const BayarInProgress(0));
  //   }
  //   _timer = Timer.periodic(const Duration(seconds: 1), onTick);
  // }

  void startTimer(int duration) {
    if (_timer != null) return;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (duration > 0) {
        duration--;
        emit(BayarInProgress(elapsed: Duration(seconds: duration)));
      } else {
        _timer?.cancel();
        emit(const BayarLoading());
      }
    });

    Wakelock.enable();
  }

  void cancelTimer() {}

  void cekPayment(String nobukti) async {
    try {
      emit(const BayarLoading());
      final response = await pesananRepository
          .cekStatusPay(ListOrderDetailParam(nobukti, apiClient.utcTime));
      if (response['payment_status'] == "2") {
        emit(BayarComplete(response));
      }
    } catch (e) {
      emit(BayarFailed(e.toString()));
    }
  }

  void proceedOrder(ProceedOrderParam param) async {
    try {
      emit(const ProceedOrderLoading());
      final parameterPDFSyarat = CreatePdfSyaratParam(
        param.alamatdetailpenerima,
        param.alamatdetailpengirim,
        param.harga,
      );
      final syaratketentuan =
          await pesananRepository.generateSyaratKetentuanPDF();
      final response = await pesananRepository.proceedOrder(param);
      await pesananRepository.createPDFSyaratKetentuan(
          response, syaratketentuan.listSyaratModel, parameterPDFSyarat);
      final listOrderDetailparam =
          ListOrderDetailParam(response['nobukti'], apiClient.utcTime);
      final reqApi =
          await pesananRepository.listPesananWhereUtc(listOrderDetailparam);
      emit(ProceedOrderSuccess(reqApi.listOrderBayar!));
    } catch (e) {
      emit(ProceedOrderFailed(e.toString()));
    }
  }
}
