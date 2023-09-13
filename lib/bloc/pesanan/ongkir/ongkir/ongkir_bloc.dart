import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasorderan/params/pesanan_params.dart';
import 'package:tasorderan/repo/pesanan_repository.dart';

part 'ongkir_event.dart';
part 'ongkir_state.dart';

class OngkirBloc extends Bloc<CekOngkirEvent, OngkirState> {
  final pesananRepository = PesananRepository();
  OngkirBloc() : super(OngkirInitial()) {
    on<CekOngkirEvent>((event, emit) async {
      try {
        emit(OngkirLoading());
        final param = CekHargaParam(
          event.placeidasal,
          event.pelabuhanidasal,
          event.latitude_pelabuhan_asal,
          event.longitude_pelabuhan_asal,
          event.jarak_asal,
          event.waktu_asal,
          event.placeidtujuan,
          event.pelabuhanidtujuan,
          event.latitude_pelabuhan_tujuan,
          event.longitude_pelabuhan_tujuan,
          event.jarak_tujuan,
          event.waktu_tujuan,
          event.container_id,
          event.nilaibarang_asuransi,
          event.qty,
          event.key,
        );
        final response = await pesananRepository.cekOngkir(param);
        emit(OngkirSuccess(result: response));
      } catch (e) {
        emit(OngkirFailed(message: e.toString()));
      }
    });
  }
}
