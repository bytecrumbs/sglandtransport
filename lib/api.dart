import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lta_datamall_flutter/models/bus_stop_list_model.dart';

Future<BusStopListModel> fetchBusStopList(
  http.Client client,
) async {
  // TODO(sascha): Store this header value somewhere more central and reusable
  final Map<String, String> requestHeaders = <String, String>{
    'AccountKey': 'xNTAqVxgQiOwp9MQa9y0tQ==',
  };

  final http.Response response = await client.get(
    'http://datamall2.mytransport.sg/ltaodataservice/BusStops',
    headers: requestHeaders,
  );

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    // TODO(sascha): resolve the below excluded linting problem
    // ignore: argument_type_not_assignable
    return BusStopListModel.fromJson(jsonDecode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
