import 'package:dio/dio.dart';

class CustomException implements Exception {
  CustomException.fromDioError(DioError dioError) {
    statusCode = dioError.response?.statusCode;
    switch (dioError.type) {
      case DioErrorType.unknown:
        message = message = dioError.response?.statusMessage ?? 'Unknown Error';
      case DioErrorType.connectionError:
        message = 'No Internet connectivity';
      case DioErrorType.badCertificate:
        message = 'Invalid certificate provided';
      case DioErrorType.cancel:
        message = 'Request to API server was cancelled';
      case DioErrorType.connectionTimeout:
        message = 'Connection timeout with API server';
      case DioErrorType.receiveTimeout:
        message = 'Received timeout in connection with API server';
      case DioErrorType.badResponse:
        message = _handleError(dioError.response?.statusCode);
      case DioErrorType.sendTimeout:
        message = 'Send timeout in connection with API server';
    }
  }

  String message = '';
  int? statusCode;

  String _handleError(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 404:
        return 'The requested resource was not found';
      case 500:
        return 'Internal server error';
      default:
        return 'Oops something went wrong';
    }
  }
}
