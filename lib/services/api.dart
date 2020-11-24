import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';

import '../app/bus/models/bus_arrival_service_list_model.dart';
import '../app/bus/models/bus_arrival_service_model.dart';
import '../app/bus/models/bus_route_list_model.dart';
import '../app/bus/models/bus_route_model.dart';
import '../app/bus/models/bus_stop_list_model.dart';
import '../app/bus/models/bus_stop_model.dart';
import '../app/failure.dart';
import '../environment_config.dart';

/// Provides the DIO library
final dioProvider = Provider<Dio>((ref) => Dio());

/// Provides the Api
final apiProvider = Provider<Api>((ref) => Api(ref.read));

/// The main Api service class, which handles all the connections to the LTA
/// Datamart API
class Api {
  /// The main constructor of the class
  Api(this.read);

  /// A reader that enables reading other providers
  final Reader read;

  static final _log = Logger('Api');

  /// The LTA Datamart API endpoint
  static const endPoint = 'http://datamall2.mytransport.sg';

  /// Fetches all the available bus stops (unfiltered).
  Future<List<BusStopModel>> fetchBusStopList() async {
    var result = <BusStopModel>[];
    final fetchURL = '$endPoint/ltaodataservice/BusStops';

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

  /// Fetches all the available bus routes (unfiltered).
  Future<List<BusRouteModel>> fetchBusRouteList() async {
    var result = <BusRouteModel>[];
    final fetchURL = '$endPoint/ltaodataservice/BusRoutes';

    for (var i = 0; i <= 26000; i = i + 3000) {
      var secondSkip = i + 500;
      var thirdSkip = i + 1000;
      var fourthSkip = i + 1500;
      var fifthSkip = i + 2000;
      var sixthSkip = i + 2500;

      var parallelFetch = await Future.wait([
        _get('$fetchURL?\$skip=$i'),
        _get('$fetchURL?\$skip=$secondSkip'),
        _get('$fetchURL?\$skip=$thirdSkip'),
        _get('$fetchURL?\$skip=$fourthSkip'),
        _get('$fetchURL?\$skip=$fifthSkip'),
        _get('$fetchURL?\$skip=$sixthSkip'),
      ]);

      for (var response in parallelFetch) {
        // If the call to the server was successful, parse the JSON.
        final busRouteListModel = BusRouteListModel.fromJson(response.data);
        result = result + busRouteListModel.value;
      }
    }

    return result;
  }

  /// Fetches the bus arrival details for a given bus stop
  Future<List<BusArrivalServiceModel>> fetchBusArrivalList(
      String busStopCode) async {
    final fetchUrl = '$endPoint/ltaodataservice/BusArrivalv2';

    final response = await _get(
      fetchUrl,
      queryParameters: {
        'BusStopCode': busStopCode,
      },
    );

    return BusArrivalServiceListModel.fromJson(response.data).services;
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
    } on DioError catch (dioError) {
      throw Failure.fromDioError(dioError);
    }
  }
}
