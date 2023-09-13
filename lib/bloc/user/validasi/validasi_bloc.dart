import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasorderan/core/session_manager.dart';
import 'package:tasorderan/repo/pesanan_repository.dart';

part 'validasi_event.dart';
part 'validasi_state.dart';

class ValidasiBloc extends Bloc<ValidasiEvent, ValidasiState> {
  final sessionManager = SessionManager();
  final pesananRepository = PesananRepository();
  ValidasiBloc() : super(ValidasiInitial()) {
    on<ValidasiEvent>((event, emit) async {
      if (event is PesananValidasiEvent) {
        emit(ValidasiLoading());
        try {
          print("baca cek validasi pesanan");
          print(sessionManager.getActiveId());
          // final validateLogin = sessionManager.getActiveId();
          // if (validateLogin == null) {
          //   // emit(ValidasiFailed(
          //   //   "Silahkan Login terlebih dahulu",
          //   //   'Masih belum berhasil',
          //   //   'assets/imgs/updated-transaction.json',
          //   // ));
          // }
        } catch (e) {
          emit(ValidasiFailed(
            e.toString(),
            'Masih belum berhasil',
            'assets/imgs/updated-transaction.json',
          ));
        }
      } else if (event is HistoryValidasiEvent) {
        try {
          emit(HistoryLoading());
          print("baca cek History pesanan");
          print(sessionManager.getActiveId());
          final validateLogin = sessionManager.getActiveId();
          if (validateLogin == null) {
            emit(HistoryFailed(
              "Silahkan Login terlebih dahulu",
              'Masih belum berhasil',
              'assets/imgs/updated-transaction.json',
            ));
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
