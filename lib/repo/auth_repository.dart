import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tasorderan/core/api_client.dart';
import 'package:tasorderan/core/session_manager.dart';
import 'package:tasorderan/params/register_user_params.dart';
import 'package:tasorderan/response/user_response.dart';

class AuthRepository extends ApiClient {
  final sessionManager = SessionManager();

  Future<UserRegisterResponse> registerUser(RegisterUserParam param) async {
    try {
      final response = await dio.post('orderemkl-api/public/api/auth/register',
          data: jsonEncode(param.toJson()));
      // debugPrint("Response Status Code : ${response.statusCode}");
      return UserRegisterResponse.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response!.statusCode == 500) {
        throw UserRegisterResponse.fromJson(e.response!.data);
      } else if (e.response!.statusCode == 422) {
        throw UserRegisterResponse.fromJson(e.response!.data);
      }
      throw UserRegisterResponse.fromJson(e.response!.data);
    }
  }

  Future<void> resend(OtpResendParam params) async {
    try {
      final response = await dio.post('orderemkl-api/public/api/auth/resend',
          data: {'data': jsonEncode(params.toJson())});
      debugPrint("Result Response: ${response.data}");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> verifyOtp(CheckOtpParam param) async {
    try {
      final response = await dio.post(
          'orderemkl-api/public/api/auth/verify_otp',
          data: jsonEncode(param.toJson()));
      debugPrint("Result Response Verify OTP: ${response.data}");
    } on DioError catch (e) {
      if (e.response!.statusCode == 401) {
        throw Exception("Verifikasi Gagal, Kode Salah");
      }
      debugPrint("Error Response: ${e.toString()}");
      throw Exception("Verifikasi Gagal");
    }
  }

  Future<UserRegisterResponse> login(LoginParam param) async {
    try {
      final response = await dio.post('orderemkl-api/public/api/auth/login',
          data: jsonEncode(param.toJson()));
      // debugPrint("Response Status Code : ${response.statusCode}");
      return UserRegisterResponse.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response!.statusCode == 500) {
        throw UserRegisterResponse.fromJson(e.response!.data);
      } else if (e.response!.statusCode == 422) {
        throw UserRegisterResponse.fromJson(e.response!.data);
      }
      throw UserRegisterResponse.fromJson(e.response!.data);
    }
  }

  Future<File> getKtpImage(String ktp) async {
    var rng = Random();
    Directory tempDir = await getApplicationDocumentsDirectory();
    String tempPath = tempDir.path;
    File ktpFile = File('$tempPath${rng.nextInt(100)}.jpg');
    final response =
        await dio.get('orderemkl-api/public/api/user/image/ktp/$ktp',
            options: Options(
              responseType: ResponseType.bytes,
            ));
    await ktpFile.writeAsBytes(response.data);
    return ktpFile;
  }

  Future<File> getnpwpImage(String npwp) async {
    var rng = Random();
    Directory tempDir = await getApplicationDocumentsDirectory();
    String tempPath = tempDir.path;
    File npwpFile = File('$tempPath${rng.nextInt(100)}.jpg');
    final response = await http.get(Uri.parse(
        'https://web.transporindo.com/orderemkl-api/public/api/user/image/npwp/$npwp'));
    await npwpFile.writeAsBytes(response.bodyBytes);
    return npwpFile;
  }
}
