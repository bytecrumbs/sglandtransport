import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:http/io_client.dart' as http;
import '../api.dart';
import 'repository.dart';

class BusStopListRepository extends Repository {
  BusStopListRepository() {
    _busStops = <BusStopModel>[];
  }

  List<BusStopModel> _busStops;

  @override
  Future<List<BusStopModel>> getBusStopListBySearchText(
      String searchText) async {
    if (_busStops.isEmpty) {
      await refreshAllData();
    }
    if (searchText.isEmpty) {
      return <BusStopModel>[];
    }

    final List<BusStopModel> searchResult = <BusStopModel>[];

    for (final BusStopModel busStop in _busStops) {
      if (busStop.busStopCode.contains(searchText) == true)
        searchResult.add(busStop);
    }

    return searchResult;
  }

  Future<void> refreshAllData() async {
    _busStops = await fetchBusStopList(http.IOClient());
  }
}
