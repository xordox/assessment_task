import 'package:dio/dio.dart';

class DioClient {
  static final Dio _dio = Dio();
  static const String contentType = 'application/json';
  static bool isExpire = false;

  static Dio getInstance() {
    return _dio;
  }
}