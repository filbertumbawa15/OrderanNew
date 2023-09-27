import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tasorderan/core/api_client.dart';
import 'package:tasorderan/core/session_manager.dart';
import 'package:tasorderan/repo/pesanan_repository.dart';
import 'package:tasorderan/response/pesanan_response.dart';

class HomeRepository extends ApiClient {
  final sessionManager = SessionManager();
  final pesananRepository = PesananRepository();
  Future<String> cekValidasiPesanan() async {
    // try {
    if (sessionManager.getActiveId() == null) {
      throw jsonEncode({
        "message": "Silahkan Login terlebih dahulu",
        "content": "Masih belum berhasil",
        "images": "assets/imgs/updated-transaction.json",
      });
    } else {
      if (sessionManager.getActiveVerification() == "12" ||
          sessionManager.getActiveVerification() == "14" ||
          sessionManager.getActiveVerification() == "0") {
        throw jsonEncode({
          "message":
              "Anda belum menyelesaikan status verifikasi anda/belum login",
          "content": "Masih belum berhasil",
          "images": "assets/imgs/updated-transaction.json",
        });
      } else {
        final response = await pesananRepository.validasiOrderan();
        if (response["data"].isNotEmpty) {
          throw jsonEncode({
            "message":
                "Mohon selesaikan orderan awal terlebih dahulu agar dapat melanjutkan pemesanan kembali.",
            "content": "Orderan masih belum selesai",
            "images": "assets/imgs/shipping-truck.json",
          });
        }
      }
    }
    return "Berhasil";
  }

  Future<FavoriteResponse> listFavorites() async {
    try {
      final response = await dio.get(
          'orderemkl-api/public/api/favorites/${sessionManager.getActiveId() ?? 0}',
          options: Options(headers: {
            'Authorization': 'Bearer ${sessionManager.getActiveToken()}',
          }));
      return FavoriteResponse.fromJson(response.data["data"]);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
