import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tasorderan/core/api_client.dart';
import 'package:tasorderan/core/session_manager.dart';
import 'package:tasorderan/params/pesanan_params.dart';

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
}
