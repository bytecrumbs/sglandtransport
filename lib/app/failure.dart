import 'package:dio/dio.dart';

/// The global exception class
class Failure implements Exception {
  /// Constructor for errors from Dio
  Failure.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.CANCEL:
        message = 'Request to API server was cancelled';
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        message = 'Connection timeout with API server';
        break;
      case DioErrorType.DEFAULT:
        message = 'Connection to API server failed due to internet connection';
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        message = 'Received timeout in connection with API server';
        break;
      case DioErrorType.RESPONSE:
        message = _handleError(dioError.response.statusCode);
        break;
      case DioErrorType.SEND_TIMEOUT:
        message = 'Send timeout in connection with API server';
        break;
      default:
        message = 'Something went wrong';
        break;
    }
  }

  /// The error message that should be shown
  String message;

  String _handleError(int statusCode) {
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
