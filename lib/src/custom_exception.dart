import 'package:dio/dio.dart';

class CustomException implements Exception {
  CustomException.fromDioError(DioError dioError) {
    statusCode = dioError.response?.statusCode;
    switch (dioError.type) {
      case DioErrorType.unknown:
        message = message = dioError.response?.statusMessage ?? 'Unknown Error';
        break;
      case DioErrorType.connectionError:
        message = 'No Internet connectivity';
        break;
      case DioErrorType.badCertificate:
        message = 'Invalid certificate provided';
        break;
      case DioErrorType.cancel:
        message = 'Request to API server was cancelled';
        break;
      case DioErrorType.connectionTimeout:
        message = 'Connection timeout with API server';
        break;
      case DioErrorType.receiveTimeout:
        message = 'Received timeout in connection with API server';
        break;
      case DioErrorType.badResponse:
        message = _handleError(dioError.response?.statusCode);
        break;
      case DioErrorType.sendTimeout:
        message = 'Send timeout in connection with API server';
        break;
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
