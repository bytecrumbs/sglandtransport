import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../environment_config.dart';
import '../../../custom_exception.dart';
import '../../../third_party_providers/third_party_providers.dart';

mixin BaseRepository {
  Future<Response<T>> fetch<T>(
    String path, {
    Map<String, Object>? queryParameters,
    required Ref ref,
  }) async {
    final dio = ref.read(dioProvider);
    ref
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
      ref
          .read(loggerProvider)
          .e('message: ${e.message}; response: ${e.response}');
      await FirebaseCrashlytics.instance
          .log('Catching DIO error. Message: ${e.message}');
      throw CustomException.fromDioError(e);
    }
  }
}
