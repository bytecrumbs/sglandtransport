import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';

class SearchBusStopsServiceProvider with ChangeNotifier {
  SearchBusStopsServiceProvider({@required this.allBusStops});

  final List<BusStopModel> allBusStops;
  List<BusStopModel> _busStopSearchList = <BusStopModel>[];
  List<BusStopModel> get busStopSearchList => _busStopSearchList;

  Future<void> findBusStops(
    String searchText,
  ) async {
    _busStopSearchList = <BusStopModel>[];
    if (searchText.isNotEmpty) {
      for (final busStop in allBusStops) {
        final isTextMatching =
            containsSearchText(busStop.busStopCode, searchText) ||
                containsSearchText(busStop.description, searchText) ||
                containsSearchText(busStop.roadName, searchText);

        if (isTextMatching) {
          _busStopSearchList.add(busStop);
        }
      }
    }
    notifyListeners();
  }

  bool containsSearchText(String value, String searchText) {
    value = value.toLowerCase();
    searchText = searchText.toLowerCase();
    return value.contains(searchText);
  }
}
