import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';

import '../app/bus/models/bus_stop_list_model.dart';
import '../app/bus/models/bus_stop_model.dart';
import '../environment_config.dart';

final dioProvider = Provider<Dio>((ref) => Dio());

final apiProvider = Provider<Api>((ref) => Api(ref.read));

class Api {
  Api(this.read);

  final Reader read;

  static final _log = Logger('Api');

  static const endPoint = 'http://datamall2.mytransport.sg';

  Future<List<BusStopModel>> fetchBusStopList() async {
    var result = <BusStopModel>[];
    final fetchURL = '$endPoint/ltaodataservice/BusStops';

    // final response = await _get(fetchURL);

    // return BusStopListModel.fromJson(response.data).value;

    for (var i = 0; i <= 5000; i = i + 1000) {
      var secondSkip = i + 500;

      var parallelFetch = await Future.wait([
        _get('$fetchURL?\$skip=$i'),
        _get('$fetchURL?\$skip=$secondSkip'),
      ]);

      for (var response in parallelFetch) {
        // If the call to the server was successful, parse the JSON.
        final busStopListModel = BusStopListModel.fromJson(response.data);
        result = result + busStopListModel.value;
      }
    }

    return result;
  }

  Future<Response<dynamic>> _get(
    String path, {
    Map<String, Object> queryParameters,
  }) async {
    final dio = read(dioProvider);
    _log.info('Fetching data for path $path and params $queryParameters');

    try {
      return await dio.get(path,
          options: Options(
            headers: {
              'AccountKey': EnvironmentConfig.ltaDatamallApiKey,
            },
          ),
          queryParameters: queryParameters);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      // TODO: proper error handling...
      if (e.response != null) {
        _log.severe(e.response.data);
        _log.severe(e.response.headers);
        _log.severe(e.response.request);
      } else {
        // Something happened in setting up or sending the request that
        // triggered an Error
        _log.severe(e.request);
        _log.severe(e.message);
      }
      rethrow;
    }
  }
}
