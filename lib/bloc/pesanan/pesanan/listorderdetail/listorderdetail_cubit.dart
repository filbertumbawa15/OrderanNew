import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasorderan/params/pesanan_params.dart';
import 'package:tasorderan/repo/pesanan_repository.dart';

part 'listorderdetail_state.dart';

class ListorderdetailCubit extends Cubit<ListorderdetailState> {
  final pesananRepository = PesananRepository();
  ListorderdetailCubit() : super(ListorderdetailInitial());

  void loadBuktiInvoice(String nobukti) async {
    try {
      final param = ListOrderDetailParam(
        nobukti,
        0,
      );
      final response = await pesananRepository.getDocument(param);
      if (response == "") {
        emit(
          ListorderdetailFailed(
              param: 'Invoice', message: 'Invoice Belum Terbit'),
        );
      } else {
        emit(ListorderdetailSuccess(
            param: 'Invoice', result: response.toString()));
      }
    } catch (e) {
      emit(ListorderdetailFailed(param: 'Invoice', message: e.toString()));
    }
  }
}
