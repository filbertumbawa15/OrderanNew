import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tasorderan/core/api_client.dart';
import 'package:tasorderan/core/session_manager.dart';
import 'package:tasorderan/params/register_user_params.dart';
import 'package:tasorderan/response/user_response.dart';

class AuthRepository extends ApiClient {
  final sessionManager = SesssionManager();

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

  Future<void> resend(String email) async {
    try {
      print(jsonEncode(email));
      final response = await dio.post('/api-orderemkl/public/api/auth/resend',
          data: jsonEncode(email));
      debugPrint("Result Response: ${response.data}");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
