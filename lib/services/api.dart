import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:lta_datamall_flutter/db/database_provider.dart';
import 'package:lta_datamall_flutter/models/bus_arrival/bus_arrival_model.dart';
import 'package:lta_datamall_flutter/models/bus_arrival/bus_arrival_service_model.dart';
import 'package:lta_datamall_flutter/models/bus_routes/bus_route_list_model.dart';
import 'package:lta_datamall_flutter/models/bus_routes/bus_route_model.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_list_model.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';

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
    final http.Client client, final String busStopCode) async {
  final requestHeaders = {
    'AccountKey': DotEnv().env['LTA_DATAMALL_KEY'],
  };

  var futureResult = await Future.wait([
    client.get(
      'http://datamall2.mytransport.sg/ltaodataservice/BusArrivalv2?BusStopCode=$busStopCode',
      headers: requestHeaders,
    ),
    DatabaseProvider.db.getBusRoutes(busStopCode)
  ]);

  final http.Response response = futureResult[0];
  final List<BusRouteModel> busRouteModelList = futureResult[1];

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    final busArrivalModel = BusArrivalModel.fromJson(jsonDecode(response.body));

    // add bus services that are not currently operating
    if (busArrivalModel.services.length < busRouteModelList.length) {
      print('must add bus services not in operation...');

      final busRouteModelServiceNos =
          busRouteModelList.map((e) => e.serviceNo).toList();
      final busArrivalServiceNoss =
          busArrivalModel.services.map((e) => e.serviceNo).toList();

      final busNoDifferences = busRouteModelServiceNos
          .toSet()
          .difference(busArrivalServiceNoss.toSet())
          .toList();
      busNoDifferences.forEach((element) {
        final missingBusArrivalServiceModel = BusArrivalServiceModel(
          serviceNo: element,
          inService: false,
        );
        busArrivalModel.services.add(missingBusArrivalServiceModel);
      });
    }
    ;

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

Future<List<BusRouteModel>> fetchBusRoutes(http.Client client) async {
  final requestHeaders = <String, String>{
    'AccountKey': DotEnv().env['LTA_DATAMALL_KEY'],
  };

  var result = <BusRouteModel>[];

  for (var i = 0; i <= 26000; i = i + 500) {
    final response = await client.get(
      'http://datamall2.mytransport.sg/ltaodataservice/BusRoutes?\$skip=$i',
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      final busRouteListModel =
          BusRouteListModel.fromJson(jsonDecode(response.body));
      result = result + busRouteListModel.value;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  return result;
}
