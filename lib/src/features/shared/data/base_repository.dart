import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../environment_config.dart';
import '../../../custom_exception.dart';
import '../../../third_party_providers/third_party_providers.dart';

class BaseRepository {
  BaseRepository(this.refBase);

  final Ref refBase;

  Future<Response<T>> fetch<T>(
    String path, {
    Map<String, Object>? queryParameters,
  }) async {
    final dio = refBase.read(dioProvider);
    refBase
        .read(loggerProvider)
        .d('GET $path with $queryParameters as query parameters');

    try {
      return await dio.get<T>(
        path,
        options: Options(
          headers: <String, String>{
            'AccountKey': EnvironmentConfig.ltaDatamallApiKey,
          },
        ),
        queryParameters: queryParameters,
      );
    } on DioError catch (e) {
      refBase
          .read(loggerProvider)
          .e('message: ${e.message}; response: ${e.response}');
      await FirebaseCrashlytics.instance
          .log('Catching DIO error. Message: ${e.message}');
      throw CustomException.fromDioError(e);
    }
  }
}
