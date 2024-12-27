import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart' hide Headers;

class ServerError implements Exception {
  final int _errorCode = 0;
  static String _errorMessage = "something went wrong";

  ServerError.withError({required DioException error}) {
    handleError(error);
  }

  int get errorCode {
    return _errorCode;
  }

  Future<String> get errorMessage async {
    var isConnected = await checkConnection();
    if (!isConnected) {
      _errorMessage = "No internet connection";
    }
    return _errorMessage;
  }

  static Future<bool> checkConnection() async {
    List<ConnectivityResult> connectivityResults =
        await (Connectivity().checkConnectivity());
    if (connectivityResults.contains(ConnectivityResult.mobile) ||
        connectivityResults.contains(ConnectivityResult.wifi) ||
        connectivityResults.contains(ConnectivityResult.ethernet)) {
      return true;
    } else {
      return false;
    }
  }

  static Future<String> handleError(DioException error) async {
    final value = await checkConnection();
    if (!value) {
      return "No internet connection";
    } else {
      _errorMessage = "something went wrong";
    }

    switch (error.type) {
      case DioExceptionType.cancel:
        _errorMessage = "Connection time out";
        break;
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.connectionError:
        _errorMessage = "Connection time out";
        break;
      case DioExceptionType.unknown:
        if (error.response != null) {
          _errorMessage = error.response?.statusMessage ?? '';
        }
        break;
      case DioExceptionType.receiveTimeout:
        _errorMessage = "Connection time out";
        break;
      case DioExceptionType.badResponse:
        if (error.response != null) {
          String msg;
          if (error.response?.statusCode == 404) {
            msg = error.response?.statusMessage ?? "Something went wrong";
          } else {
            msg = "null";
            
          }

          _errorMessage = msg;
        }
        break;
      case DioExceptionType.sendTimeout:
        _errorMessage = "Connection time out";
        break;
      case DioExceptionType.badCertificate:
        if (error.response != null) {
          _errorMessage = error.response?.statusMessage ?? '';
        }
        break;
    }

    if (_errorMessage.isEmpty) {
      _errorMessage = "something went wrong";
    }
    return _errorMessage;
  }

}