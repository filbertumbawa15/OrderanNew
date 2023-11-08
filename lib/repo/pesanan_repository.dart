import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasorderan/components/components.dart';
import 'package:tasorderan/core/api_client.dart';
import 'package:tasorderan/core/session_manager.dart';
import 'package:tasorderan/models/pdf_models.dart';
import 'package:tasorderan/models/user_models.dart';
import 'package:tasorderan/params/bayar_params.dart';
import 'package:tasorderan/params/pesanan_params.dart';
import 'package:tasorderan/response/pesanan_response.dart';
import 'package:tasorderan/response/user_response.dart';
import 'package:tasorderan/ui/pdf/pdf_sk.dart';

class PesananRepository extends ApiClient {
  final SessionManager sessionManager = SessionManager();
  final ApiClient apiClient = ApiClient();
  Future<Map<String, dynamic>> getPlacePelabuhan(
      DatapengirimParam param) async {
    try {
      final response = await dio.get(
        'orderemkl-api/public/api/pesanan/getpelabuhan',
        queryParameters: {
          'data': jsonEncode(param.toJson()),
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${sessionManager.getActiveToken()}',
          },
        ),
      );
      debugPrint("RESULT : ${response.data.runtimeType}");
      return response.data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> setDirection(
      String origin, String? destination) async {
    try {
      final response = await Dio().get(
        'https://maps.googleapis.com/maps/api/directions/json',
        // 'origin=$origin&destination=$destination&key=$key'
        queryParameters: {
          "origin": origin,
          "destination": destination,
          "key": apiClient.apiKey,
        },
      );
      final json = response.data;

      Map<String, dynamic> results = {
        'bounds_ne': json['routes'][0]['bounds']['northeast'],
        'bounds_sw': json['routes'][0]['bounds']['southwest'],
        'start_location': json['routes'][0]['legs'][0]['start_location'],
        'end_location': json['routes'][0]['legs'][0]['end_location'],
        'polyline': json['routes'][0]['overview_polyline']['points'],
        'distance': json['routes'][0]['legs'][0]['distance'],
        'duration': json['routes'][0]['legs'][0]['duration'],
      };
      debugPrint("RESULT_DIRECTION : ${response.data}");
      return results;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> cekOngkir(CekHargaParam param) async {
    try {
      final response = await dio.get(
        'orderemkl-api/public/api/pesanan/cekongkoskirim',
        queryParameters: {"data": jsonEncode(param.toJson())},
      );
      debugPrint("Result : ${response.data}");
      return response.data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> validasiOrderan() async {
    try {
      final response = await dio.get(
        'orderemkl-api/public/api/pesanan/validasiorderan',
        queryParameters: {
          "data": jsonEncode({"id": sessionManager.getActiveId()}),
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${sessionManager.getActiveToken()}',
          },
        ),
      );
      debugPrint("Result : ${response.data}");
      return response.data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> addToFavorites(AddFavoritParam param) async {
    try {
      print(jsonEncode(param.toJson()));
      final response = await dio.post('orderemkl-api/public/api/favorites',
          data: {'data': jsonEncode(param.toJson())},
          options: Options(headers: {
            'Authorization': 'Bearer ${sessionManager.getActiveToken()}',
          }));
      return response.data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ListOrderResponse> listOrder(ListOrderParam param) async {
    try {
      print({'data': jsonEncode(param.toJson())});
      final response = await dio.get(
        'orderemkl-api/public/api/pesanan/listpesanan',
        queryParameters: {
          'data': jsonEncode(param.toJson()),
        },
        options: Options(headers: {
          'Authorization': 'Bearer ${sessionManager.getActiveToken()}',
        }),
      );
      return ListOrderResponse.fromJson(response.data['data']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ListPesananBayarResponse> listPesananWhereUtc(
      ListOrderDetailParam param) async {
    try {
      final response = await dio.get(
        'orderemkl-api/public/api/pesanan/listpesananwhereUtc',
        queryParameters: {
          'data': jsonEncode(param.toJson()),
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${sessionManager.getActiveToken()}',
          },
        ),
      );
      return ListPesananBayarResponse.fromJson(response.data["data"]);
    } on DioError catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> getDocument(ListOrderDetailParam param) async {
    try {
      final response = await dio.get(
        'orderemkl-api/public/api/pesanan/getDataInvoiceUtama',
        queryParameters: {
          'data': jsonEncode(param.toJson()),
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${sessionManager.getActiveToken()}',
          },
        ),
      );
      return response.data["lampiran"];
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> cekStatusPay(ListOrderDetailParam param) async {
    try {
      final response = await dio.get(
        'orderemkl-api/public/api/pesanan/listpesananrow',
        queryParameters: {
          'data': jsonEncode(param.toJson()),
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${sessionManager.getActiveToken()}',
          },
        ),
      );
      return response.data['data'];
    } on DioError catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  // Future<String> updateStatusPembayaran(BayarParams param) async {
  //   try {
  //     final response = await dio.post('orderemkl-api/public/api/pesanan')
  //   } on DioError catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }

  Future<SyaratdanKetentuanResponse> generateSyaratKetentuanPDF() async {
    try {
      final response = await dio.get(
        'orderemkl-api/public/api/syaratdanketentuan',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${sessionManager.getActiveToken()}',
          },
        ),
      );
      return SyaratdanKetentuanResponse.fromJson(response.data['data']);
    } on DioError catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> proceedOrder(ProceedOrderParam param) async {
    try {
      final response = await dio.post(
        'orderemkl-api/public/api/faspay/insertorderfaspay',
        data: {
          'data_pembayaran': jsonEncode(param.toJson()),
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${sessionManager.getActiveToken()}',
          },
        ),
      );
      print(response.data);
      return response.data;
    } on DioError catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> createPDFSyaratKetentuan(
      Map<String, dynamic> nobukti,
      List<String?> listsyaratKetentuan,
      CreatePdfSyaratParam parameterPDF) async {
    try {
      print(listsyaratKetentuan);
      final syarat = SyaratKetentuan(
        nama: sessionManager.getActiveName(),
        nobukti: nobukti['nobukti'],
        notelp: sessionManager.getActiveTelp(),
        tanggal: DateFormat('dd MMMM yyyy').format(DateTime.now()),
        lokmuat: parameterPDF.lokasiMuat,
        lokbongkar: parameterPDF.lokasiBongkar,
        harga: parameterPDF.harga,
        syaratketentuan: listsyaratKetentuan,
      );
      final pdfFile = await PdfSKApi.generate(syarat);
      String buktiPdf = pdfFile.path.split('/').last;
      FormData formData = FormData.fromMap({
        "bukti_pdf": await MultipartFile.fromFile(
          pdfFile.path,
          filename: buktiPdf,
        ),
        'nobukti': nobukti['nobukti'],
      });

      final response = await dio.post(
        'orderemkl-api/public/api/syaratdanketentuan/uploadBukti',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${sessionManager.getActiveToken()}',
          },
        ),
      );
    } on DioError catch (e) {
      // print(e.response!.data.toString());
      throw Exception(e.toString());
    }
  }

  Future<ListPesananStatusResponse> getPesananStatus(
      ListOrderStatusParam param) async {
    try {
      final response = await dio.get(
        'orderemkl-api/public/api/pesanan/getstatusorderan',
        queryParameters: {
          'data': jsonEncode(param.toJson()),
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${sessionManager.getActiveToken()}',
          },
        ),
      );
      return ListPesananStatusResponse.fromJson(response.data['data'][0]);
    } on DioError catch (e) {
      throw Exception(e.toString());
    }
  }
}
