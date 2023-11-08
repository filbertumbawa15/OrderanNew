import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tasorderan/params/pesanan_params.dart';
import 'package:tasorderan/repo/pesanan_repository.dart';
import 'package:tasorderan/response/pesanan_response.dart';

part 'listpesananstatus_event.dart';
part 'listpesananstatus_state.dart';

class ListpesananstatusBloc
    extends Bloc<ListpesananstatusEvent, ListpesananstatusState> {
  final pesananRepository = PesananRepository();
  ListpesananstatusBloc() : super(ListpesananstatusInitial()) {
    on<LoadListPesananStatus>(
      (event, emit) async {
        try {
          emit(ListpesananstatusLoading());
          final param = ListOrderStatusParam(event.nobukti, event.qty);
          final response = await pesananRepository.getPesananStatus(param);
          emit(ListpesananstatusSuccess(response));
        } catch (e) {
          emit(ListpesananstatusFailed(e.toString()));
        }
      },
    );
  }
}
