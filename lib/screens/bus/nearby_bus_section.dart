import 'package:flutter/material.dart';

import 'package:lta_datamall_flutter/data/bus_stop_list_repository.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_stops/bus_stop_card_list.dart';

class NearbyBusStops extends StatelessWidget {
  static final BusStopListRepository _repo = BusStopListRepository();

  Future<List<BusStopModel>> _fetchBusStopList() {
    return _repo.getBusStopList();
  }

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
