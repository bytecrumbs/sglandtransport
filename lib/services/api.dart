import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import 'package:lta_datamall_flutter/datamodels/bus/bus_arrival/bus_arrival_service_list_model.dart';
import 'package:lta_datamall_flutter/datamodels/bus/bus_route/bus_route_list_model.dart';
import 'package:lta_datamall_flutter/datamodels/bus/bus_route/bus_route_model.dart';
import 'package:lta_datamall_flutter/datamodels/bus/bus_stop/bus_stop_list_model.dart';
import 'package:lta_datamall_flutter/datamodels/bus/bus_stop/bus_stop_model.dart';

@lazySingleton
class Api {
  static const endPoint = 'http://datamall2.mytransport.sg';

  Future<List<BusStopModel>> fetchBusStopList(http.Client client) async {
    final requestHeaders = <String, String>{
      'AccountKey': DotEnv().env['LTA_DATAMALL_KEY'],
    };

    final skip = [
      0,
      500,
      1000,
      1500,
      2000,
      2500,
      3000,
      3500,
      4000,
      4500,
      5000,
    ];

    var result = <BusStopModel>[];

    for (final currentSkip in skip) {
      final response = await client.get(
        '$endPoint/ltaodataservice/BusStops?\$skip=$currentSkip',
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON.
        final busStopListModel =
            BusStopListModel.fromJson(jsonDecode(response.body));
        result = result + busStopListModel.value;
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load post');
      }
    }

    return result;
  }

  Future<BusArrivalServiceListModel> fetchBusArrivalList(
      final http.Client client, final String busStopCode) async {
    final requestHeaders = {
      'AccountKey': DotEnv().env['LTA_DATAMALL_KEY'],
    };

    final response1 = await client.get(
      '$endPoint/ltaodataservice/BusArrivalv2?BusStopCode=$busStopCode',
      headers: requestHeaders,
    );

    if (response1.statusCode == 200) {
      return BusArrivalServiceListModel.fromJson(jsonDecode(response1.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<List<BusRouteModel>> fetchBusRoutes(http.Client client) async {
    final requestHeaders = <String, String>{
      'AccountKey': DotEnv().env['LTA_DATAMALL_KEY'],
    };

    var result = <BusRouteModel>[];

    for (var i = 0; i <= 26000; i = i + 2000) {
      var secondSkip = i + 500;
      var thirdSkip = i + 1000;
      var fourthSkip = i + 1500;
      var fetchURL = '$endPoint/ltaodataservice/BusRoutes';
      var parallelFetch = await Future.wait([
        client.get(
          '$fetchURL?\$skip=$i',
          headers: requestHeaders,
        ),
        client.get(
          '$fetchURL?\$skip=$secondSkip',
          headers: requestHeaders,
        ),
        client.get(
          '$fetchURL?\$skip=$thirdSkip',
          headers: requestHeaders,
        ),
        client.get(
          '$fetchURL?\$skip=$fourthSkip',
          headers: requestHeaders,
        ),
      ]);

      parallelFetch.forEach((response) {
        if (response.statusCode == 200) {
          // If the call to the server was successful, parse the JSON.
          final busRouteListModel =
              BusRouteListModel.fromJson(jsonDecode(response.body));
          result = result + busRouteListModel.value;
        } else {
          // If that call was not successful, throw an error.
          throw Exception('Failed to load post');
        }
      });
    }

    return result;
  }
}
