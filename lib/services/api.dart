import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:lta_datamall_flutter/app/bus/models/bus_stop_list_model.dart';
import 'package:lta_datamall_flutter/app/bus/models/bus_stop_model.dart';
import 'package:lta_datamall_flutter/environment_config.dart';

final apiProvider = Provider<Api>((ref) => Api());

class Api {
  static const endPoint = 'http://datamall2.mytransport.sg';

  Future<List<BusStopModel>> fetchBusStopList(http.Client client) async {
    final requestHeaders = <String, String>{
      'AccountKey': EnvironmentConfig.ltaDatamallApiKey,
    };

    var result = <BusStopModel>[];

    var fetchURL = '$endPoint/ltaodataservice/BusStops';
    for (var i = 0; i <= 5000; i = i + 1000) {
      var secondSkip = i + 500;
      var parallelFetch = await Future.wait([
        client.get(
          '$fetchURL?\$skip=$i',
          headers: requestHeaders,
        ),
        client.get(
          '$fetchURL?\$skip=$secondSkip',
          headers: requestHeaders,
        ),
      ]);

      parallelFetch.forEach((response) {
        if (response.statusCode == 200) {
          // If the call to the server was successful, parse the JSON.
          final busStopListModel =
              BusStopListModel.fromJson(jsonDecode(response.body));
          result = result + busStopListModel.value;
        } else {
          // If that call was not successful, throw an error.
          throw Exception('Failed to load bus stops');
        }
      });
    }

    return result;
  }
}
