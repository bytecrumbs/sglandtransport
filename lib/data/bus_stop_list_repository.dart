import 'package:geolocator/geolocator.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:http/io_client.dart' as http;
import '../api.dart';
import 'repository.dart';

class BusStopListRepository extends Repository {
  BusStopListRepository() {
    _busStops = <BusStopModel>[];
    _cacheValidDuration = const Duration(hours: 1);
    _lastFetchTime = DateTime.fromMillisecondsSinceEpoch(0);
  }

  Duration _cacheValidDuration;
  DateTime _lastFetchTime;
  List<BusStopModel> _busStops;

  @override
  Future<List<BusStopModel>> getBusStopListBySearchText(String searchText,
      {bool forceRefresh = false}) async {
    if (shouldRefresh(forceRefresh)) {
      await refreshAllData();
    }

    final List<BusStopModel> searchResult = <BusStopModel>[];
    if (searchText.isNotEmpty) {
      for (final BusStopModel busStop in _busStops) {
        final bool isTextMatching =
            containsSearchText(busStop.busStopCode, searchText) ||
                containsSearchText(busStop.description, searchText) ||
                containsSearchText(busStop.roadName, searchText);

        if (isTextMatching) {
          searchResult.add(busStop);
        }
      }
    }

    return searchResult;
  }

  @override
  Future<List<BusStopModel>> getBusStopListByPosition(Position position,
      {bool forceRefresh = false}) async {
    if (shouldRefresh(forceRefresh)) {
      await refreshAllData();
    }

    final List<BusStopModel> searchResult = <BusStopModel>[];
    for (final BusStopModel busStop in _busStops) {
      final bool isNearby = await Geolocator().distanceBetween(
              position.latitude,
              position.longitude,
              busStop.latitude,
              busStop.longitude) <=
          100;

      if (isNearby) {
        searchResult.add(busStop);
      }
    }

    return searchResult;
  }

  @override
  Future<List<BusStopModel>> getBusStopList({bool forceRefresh = false}) async {
    if (shouldRefresh(forceRefresh)) {
      await refreshAllData();
    }
    return _busStops;
  }

  bool containsSearchText(String value, String searchText) {
    value = value.toLowerCase();
    searchText = searchText.toLowerCase();
    return value.contains(searchText);
  }

  bool shouldRefresh(bool forceRefresh) {
    return _busStops.isEmpty ||
        _lastFetchTime.isBefore(DateTime.now().subtract(_cacheValidDuration)) ||
        forceRefresh;
  }

  Future<void> refreshAllData() async {
    _lastFetchTime = DateTime.now();
    _busStops = await fetchBusStopList(http.IOClient());
  }
}
