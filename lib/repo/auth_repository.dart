import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tasorderan/core/api_client.dart';
import 'package:tasorderan/core/session_manager.dart';
import 'package:tasorderan/params/register_user_params.dart';
import 'package:tasorderan/response/home_response.dart';
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
    final response = await dio.get(
        'https://web.transporindo.com/orderemkl-api/public/api/user/image/npwp/$npwp',
        options: Options(
          responseType: ResponseType.bytes,
        ));
    await npwpFile.writeAsBytes(response.data);
    return npwpFile;
  }

  Future<File> initializeFile(List<dynamic> imageBytes) async {
    try {
      debugPrint("Baca Image:  $imageBytes");
      Directory root = await getApplicationDocumentsDirectory();
      String directoryPath = root.path;
      File file =
          await File('$directoryPath/${DateTime.now().millisecondsSinceEpoch}')
              .create();
      file.writeAsBytesSync(imageBytes.cast<int>());
      return File(file.path);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> verifikasiUser(VerifikasiUserParam param) async {
    try {
      String? ktpPath = param.ktp!.path.split('/').last;
      String? npwpPath = param.npwp!.path.split('/').last;
      FormData data = FormData.fromMap(
        {
          "foto_ktp":
              await MultipartFile.fromFile(param.ktp!.path, filename: ktpPath),
          "nik": param.nik,
          "name": param.name,
          "alamatdetail": param.alamatdetail,
          "tgl_lahir": param.tgl_lahir,
          "foto_npwp": await MultipartFile.fromFile(param.npwp!.path,
              filename: npwpPath),
          "no_npwp": param.no_npwp,
          "user_id": param.user_id,
        },
      );
      final response = await dio.post(
        'orderemkl-api/public/api/user/upload_gambar',
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${sessionManager.getActiveToken()}',
          },
        ),
      );
      return response.data['statusverifikasi'];
    } on DioError catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> cekVerification(int id) async {
    try {
      final response = await dio.get(
        'orderemkl-api/public/api/user/getdataverifikasi',
        queryParameters: {
          'id': id,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${sessionManager.getActiveToken()}',
          },
        ),
      );
      return response.data["data"];
    } on DioError catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<NotificationsResponse> listNotification() async {
    try {
      final response = await dio.get(
        'orderemkl-api/public/api/notifications',
        queryParameters: {
          'userid': sessionManager.getActiveId() ?? 0,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${sessionManager.getActiveToken()}',
          },
        ),
      );
      return NotificationsResponse.fromJson(response.data['data']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ForgotPasswordResponse> forgotPassword(
      ForgotPasswordParam param) async {
    try {
      final response = await dio.post(
          'orderemkl-api/public/api/forgot-password',
          data: jsonEncode(param.toJson()));
      // debugPrint("Response Status Code : ${response.statusCode}");
      return ForgotPasswordResponse.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
