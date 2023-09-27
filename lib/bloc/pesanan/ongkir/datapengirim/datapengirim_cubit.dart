import 'package:bloc/bloc.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:meta/meta.dart';
import 'package:tasorderan/core/api_client.dart';
import 'package:tasorderan/main.dart';
import 'package:tasorderan/params/pesanan_params.dart';
import 'package:tasorderan/repo/pesanan_repository.dart';

part 'datapengirim_state.dart';

class DatapengirimCubit extends Cubit<DatapengirimState> {
  final ApiClient apiClient = ApiClient();
  final pesananRepository = PesananRepository();
  DatapengirimCubit() : super(DatapengirimInitial());

  void navigatorPushAsal({@required String? route, Object? param}) async {
    try {
      emit(AsalLoading());
      final response =
          await navigatorKey.currentState?.pushNamed(route!, arguments: param);
      if (response == null) {
        emit(AsalFailed());
      } else {
        emit(AsalSuccess(response));
      }
    } catch (e) {
      emit(AsalFailed());
    }
  }

  void navigatorPushTujuan({@required String? route, Object? param}) async {
    try {
      emit(TujuanLoading());
      final response =
          await navigatorKey.currentState?.pushNamed(route!, arguments: param);
      if (response == null) {
        emit(TujuanFailed());
      } else {
        emit(TujuanSuccess(response));
      }
    } catch (e) {
      emit(TujuanFailed());
    }
  }

  void getPelabuhan(PickResult result) async {
    try {
      emit(MapLoading());
      final param = DatapengirimParam(
        result.placeId,
        apiClient.apiKey,
      );
      final response = await pesananRepository.getPlacePelabuhan(param);
      if (response["data"] == null) {
        emit(MapFailed(
          "Area belum masuk dalam daftar pengiriman",
          'Area tidak terdaftar',
          'assets/imgs/not-found.json',
        ));
      } else {
        final direction = await pesananRepository.setDirection(
          '${response['data']['latitude']}, ${response['data']['longitude']}',
          result.formattedAddress,
        );
        emit(MapSuccess(
          result,
          response,
          direction,
        ));
      }
    } catch (e) {
      print(e.toString());
      emit(MapFailed(
        "Mohon cek kembali koneksi internet WiFi/Data anda",
        'Tidak ada koneksi',
        'assets/imgs/no-internet.json',
      ));
    }
  }
}
