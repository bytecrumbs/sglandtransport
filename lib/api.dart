import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lta_datamall_flutter/models/bus_arrival/bus_arrival_model.dart';
import 'package:lta_datamall_flutter/models/bus_arrival/bus_arrival_service_model.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_list_model.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';

Future<List<BusStopModel>> fetchBusStopList(
  http.Client client,
) async {
  // TODO(sascha): Store this header value somewhere more central and reusable
  final Map<String, String> requestHeaders = <String, String>{
    'AccountKey': 'xNTAqVxgQiOwp9MQa9y0tQ==',
  };

  final List<int> skip = <int>[
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

  List<BusStopModel> result = <BusStopModel>[];

  for (final int currentSkip in skip) {
    final http.Response response = await client.get(
      'http://datamall2.mytransport.sg/ltaodataservice/BusStops?\$skip=$currentSkip',
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      // TODO(sascha): resolve the below excluded linting problem
      final BusStopListModel busStopListModel =
          // ignore: argument_type_not_assignable
          BusStopListModel.fromJson(jsonDecode(response.body));
      result = result + busStopListModel.value;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  return result;
}

Future<BusArrivalModel> fetchBusArrivalList(
  final http.Client client,
  final String busStopCode,
) async {
  // TODO(sascha): Store this header value somewhere more central and reusable
  final Map<String, String> requestHeaders = <String, String>{
    'AccountKey': 'xNTAqVxgQiOwp9MQa9y0tQ==',
  };

  final http.Response response = await client.get(
    'http://datamall2.mytransport.sg/ltaodataservice/BusArrivalv2?BusStopCode=$busStopCode',
    headers: requestHeaders,
  );

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    // TODO(sascha): resolve the below excluded linting problem
    final BusArrivalModel busArrivalModel =
        // ignore: argument_type_not_assignable
        BusArrivalModel.fromJson(jsonDecode(response.body));
    busArrivalModel.services.sort((BusArrivalServiceModel a,
            BusArrivalServiceModel b) =>
        int.parse(a.serviceNo.replaceAll(RegExp('\\D'), ''))
            .compareTo(int.parse(b.serviceNo.replaceAll(RegExp('\\D'), ''))));
    return busArrivalModel;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
