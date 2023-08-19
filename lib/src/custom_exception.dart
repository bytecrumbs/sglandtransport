import 'package:dio/dio.dart';

class CustomException implements Exception {
  CustomException.fromDioError(DioException dioException) {
    statusCode = dioException.response?.statusCode;
    switch (dioException.type) {
      case DioExceptionType.unknown:
        message =
            message = dioException.response?.statusMessage ?? 'Unknown Error';
      case DioExceptionType.connectionError:
        message = 'No Internet connectivity';
      case DioExceptionType.badCertificate:
        message = 'Invalid certificate provided';
      case DioExceptionType.cancel:
        message = 'Request to API server was cancelled';
      case DioExceptionType.connectionTimeout:
        message = 'Connection timeout with API server';
      case DioExceptionType.receiveTimeout:
        message = 'Received timeout in connection with API server';
      case DioExceptionType.badResponse:
        message = _handleError(dioException.response?.statusCode);
      case DioExceptionType.sendTimeout:
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
