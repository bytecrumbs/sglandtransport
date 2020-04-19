import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:http/io_client.dart' as http;

import '../api.dart';
import 'repository.dart';

class BusStopListRepository extends Repository {
  List<BusStopModel> _busStops = <BusStopModel>[];
  final List<BusStopModel> _searchResult = <BusStopModel>[];

  Future<void> refreshAllData() async {
    _busStops = await fetchBusStopList(http.IOClient());
  }

  @override
  Future<List<BusStopModel>> getBusStopListBySearchText(
      String searchText) async {
    if (_busStops.isEmpty) {
      await refreshAllData();
    }

    if (searchText.isEmpty) {
      return _searchResult;
    }

    _searchResult.clear();

    for (final BusStopModel busStop in _busStops) {
      if (busStop.busStopCode.contains(searchText) == true)
        _searchResult.add(busStop);
    }

    return _searchResult;
  }
}
