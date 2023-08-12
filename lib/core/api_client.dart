import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio = Dio();

  ApiClient() {
    _dio.options.baseUrl = 'https://web.transporindo.com/';
    _dio.options.headers['content-type'] = 'application/json';
    _dio.options.headers['accept'] = 'application/json';
  }
  Dio get dio => _dio;
}
