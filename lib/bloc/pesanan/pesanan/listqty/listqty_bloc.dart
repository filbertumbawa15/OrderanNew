import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasorderan/models/pesanan_models.dart';
import 'package:tasorderan/params/pesanan_params.dart';
import 'package:tasorderan/repo/pesanan_repository.dart';

part 'listqty_event.dart';
part 'listqty_state.dart';

class ListqtyBloc extends Bloc<ListqtyEvent, ListqtyState> {
  final pesananRepository = PesananRepository();
  ListqtyBloc() : super(ListqtyInitial()) {
    on<ListQtyOrderEvent>((event, emit) async {
      try {
        emit(ListQtyLoading());
        final param = ListQtyOrderParam(
          event.nobukti,
        );
        final response = await pesananRepository.getListQty(param);
        emit(ListQtySuccess(response.listQtyOrder));
      } catch (e) {
        emit(ListQtyFailed(e.toString()));
      }
    });
  }
}
