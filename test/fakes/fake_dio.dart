import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lta_datamall_flutter/src/shared/constants.dart';

part 'fake_dio.g.dart';

@JsonLiteral('get_bus_arrival.json')
final _getBusArrival = _$_getBusArrivalJsonLiteral;

class FakeDio implements Dio {
  @override
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    switch (path) {
      case '$ltaDatamallApi/BusArrivalv2':
        return FakeResponseMap(200, _getBusArrival) as Response<T>;

      default:
    }
    throw UnimplementedError();
  }

  @override
  void noSuchMethod(Invocation invocation) {
    throw UnimplementedError();
  }
}

class FakeResponseMap implements Response<Map<String, Object?>> {
  FakeResponseMap(this.statusCode, this.data, [this.statusMessage]);

  @override
  final Map<String, Object?>? data;

  @override
  final int statusCode;

  @override
  final String? statusMessage;

  @override
  void noSuchMethod(Invocation invocation) {
    throw UnimplementedError();
  }
}
