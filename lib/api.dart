import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lta_datamall_flutter/models/bus_arrival/bus_arrival_model.dart';
import 'package:lta_datamall_flutter/models/bus_arrival/bus_arrival_service_model.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_list_model.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:lta_datamall_flutter/secret_lta_api_key.dart';

Future<List<BusStopModel>> fetchBusStopList(
  http.Client client,
) async {
  final requestHeaders = <String, String>{
    'AccountKey': ltaDatamallKey,
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

  List result = <BusStopModel>[];

  for (final currentSkip in skip) {
    final response = await client.get(
      'http://datamall2.mytransport.sg/ltaodataservice/BusStops?\$skip=$currentSkip',
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

Future<BusArrivalModel> fetchBusArrivalList(
  final http.Client client,
  final String busStopCode,
) async {
  final requestHeaders = {
    'AccountKey': ltaDatamallKey,
  };

  final response = await client.get(
    'http://datamall2.mytransport.sg/ltaodataservice/BusArrivalv2?BusStopCode=$busStopCode',
    headers: requestHeaders,
  );

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    final busArrivalModel = BusArrivalModel.fromJson(jsonDecode(response.body));
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
