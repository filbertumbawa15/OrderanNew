import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasorderan/main.dart';
import 'package:tasorderan/models/pesanan_models.dart';
import 'package:tasorderan/params/pesanan_params.dart';
import 'package:tasorderan/repo/pesanan_repository.dart';

part 'list_order_event.dart';
part 'list_order_state.dart';

class ListOrderBloc extends Bloc<ListOrderEvent, ListOrderState> {
  final pesananRepository = PesananRepository();
  ListOrderBloc() : super(ListOrderInitial()) {
    on<ListOrderEvent>(
      (event, emit) async {
        if (event is ListPesananOrderEvent) {
          try {
            emit(ListOrderLoading());
            final param = ListOrderParam(
              event.userId,
              event.kondisi,
              event.utcTime,
            );
            final response = await pesananRepository.listOrder(param);
            emit(ListOrderSuccess(response.listOrder));
          } catch (e) {
            emit(ListOrderFailed(e.toString()));
          }
        } else if (event is ListPesananOrderNavigatorEvent) {
          try {
            if (event.route == '/bayar') {
              try {
                final param = ListOrderDetailParam(
                  event.nobukti,
                  0,
                );
                final reqAPI =
                    await pesananRepository.listPesananWhereUtc(param);
                await navigatorKey.currentState?.pushNamed(
                  event.route,
                  arguments: {
                    'listOrderBayar': reqAPI.listOrderBayar,
                    'param': 'ListPesanan',
                  },
                );
                emit(ListordernavigatorSuccessPaymentLoaded());
              } catch (e) {
                emit(ListordernavigatorSuccessPaymentFailed());
              }
              // print(reqAPI);
              // final response = navigatorKey.currentState
              //     ?.pushNamed(event.route, arguments: event.param);
              // if (response == null) {
              //   emit(ListordernavigatorSuccessPaymentFailed());
              // } else {
              //   emit(ListordernavigatorSuccessPaymentLoaded());
              // }
            } else {
              final response = await navigatorKey.currentState
                  ?.pushNamed(event.route, arguments: event.param);
              if (response == null) {
                emit(ListordernavigatorSuccessPaymentFailed());
              } else {
                emit(ListordernavigatorSuccessPaymentLoaded());
              }
            }
          } catch (e) {
            emit(ListordernavigatorSuccessPaymentFailed());
          }
        }
      },
    );
  }
}
