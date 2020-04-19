import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/api.dart';
import 'package:http/io_client.dart' as http;
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_stops/bus_stop_card_list.dart';

Future<List<BusStopModel>> _fetchBusStopList() {
  return fetchBusStopList(http.IOClient());
}

class NearbyBusStops extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BusStopModel>>(
      future: _fetchBusStopList(),
      builder:
          (BuildContext context, AsyncSnapshot<List<BusStopModel>> snapshot) {
        if (snapshot.hasData) {
          return BusStopCardList(
            busStopList: snapshot.data,
          );
        } else if (snapshot.hasError) {
          // TODO(anyone): Do something here...
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
