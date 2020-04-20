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
  Future<List<BusStopModel>> getBusStopListBySearchText(String searchText,
      {bool forceRefresh = false}) async {
    if (_busStops.isEmpty || forceRefresh) {
      await refreshAllData();
    }

    final List<BusStopModel> searchResult = <BusStopModel>[];
    if (searchText.isNotEmpty) {
      for (final BusStopModel busStop in _busStops) {
        if (busStop.busStopCode.startsWith(searchText) == true)
          searchResult.add(busStop);
      }
    }

    return searchResult;
  }

  Future<void> refreshAllData() async {
    _busStops = await fetchBusStopList(http.IOClient());
  }
}
