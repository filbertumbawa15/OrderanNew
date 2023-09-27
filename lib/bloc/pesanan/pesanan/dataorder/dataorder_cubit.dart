import 'package:bloc/bloc.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:meta/meta.dart';
import 'package:tasorderan/core/api_client.dart';
import 'package:tasorderan/main.dart';
import 'package:tasorderan/params/pesanan_params.dart';
import 'package:tasorderan/repo/pesanan_repository.dart';

part 'dataorder_state.dart';

class DataorderCubit extends Cubit<DataorderState> {
  final apiClient = ApiClient();
  final pesananRepository = PesananRepository();
  DataorderCubit() : super(DataorderInitial());

  void pushAsal({required String route, Object? param}) async {
    try {
      emit(DataorderAsalLoading());
      final response =
          await navigatorKey.currentState?.pushNamed(route, arguments: param);
      if (response == null) {
        emit(DataorderAsalFailed());
      } else {
        emit(DataorderAsalSuccess(response));
      }
    } catch (e) {
      emit(DataorderAsalFailed());
    }
  }

  void pushTujuan({required String route, Object? param}) async {
    try {
      emit(DataorderTujuanLoading());
      final response =
          await navigatorKey.currentState?.pushNamed(route, arguments: param);
      if (response == null) {
        emit(DataorderTujuanFailed());
      } else {
        emit(DataorderTujuanSuccess(response));
      }
    } catch (e) {
      emit(DataorderTujuanFailed());
    }
  }

  void pushFavorites() async {
    try {
      emit(DataorderFavoriteLoading());
      final response =
          await navigatorKey.currentState?.pushNamed('/favoritesList');
      if (response == null) {
        emit(DataorderFavoriteFailed());
      } else {
        emit(DataorderFavoriteSuccess(response));
      }
    } catch (e) {
      emit(DataorderFavoriteFailed());
    }
  }

  void getPelabuhan(PickResult result) async {
    try {
      emit(MapOrderLoading());
      final param = DatapengirimParam(
        result.placeId,
        apiClient.apiKey,
      );
      final response = await pesananRepository.getPlacePelabuhan(param);
      if (response["data"] == null) {
        emit(MapOrderFailed(
          "Area belum masuk dalam daftar pengiriman",
          'Area tidak terdaftar',
          'assets/imgs/not-found.json',
        ));
      } else {
        final direction = await pesananRepository.setDirection(
          '${response['data']['latitude']}, ${response['data']['longitude']}',
          result.formattedAddress,
        );
        emit(MapOrderSuccess(
          result,
          response,
          direction,
        ));
      }
    } catch (e) {
      print(e.toString());
      emit(MapOrderFailed(
        "Mohon cek kembali koneksi internet WiFi/Data anda",
        'Tidak ada koneksi',
        'assets/imgs/no-internet.json',
      ));
    }
  }

  void addToFavorites(AddFavoritParam param) async {
    try {
      emit(DataorderFavoriteAddLoading());
      final response = await pesananRepository.addToFavorites(param);
      emit(DataorderFavoriteAddSuccess());
    } catch (e) {
      emit(DataorderFavoriteAddFailed(e.toString()));
    }
  }
}
