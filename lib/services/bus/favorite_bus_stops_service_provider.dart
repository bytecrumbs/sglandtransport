import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteBusStopsServiceProvider with ChangeNotifier {
  FavoriteBusStopsServiceProvider({@required this.allBusStops}) {
    fetchFavoriteBusStops();
  }
  final List<BusStopModel> allBusStops;

  List<BusStopModel> _favoriteBusStops = <BusStopModel>[];
  List<BusStopModel> get favoriteBusStops => _favoriteBusStops;

  List<String> _favoriteBusStopCodes = <String>[];

  final String favoriteBusStopsKey = 'favoriteBusStopModels';

  Future<void> fetchFavoriteBusStops() async {
    final prefs = await SharedPreferences.getInstance();

    _favoriteBusStopCodes =
        prefs.getStringList(favoriteBusStopsKey) ?? <String>[];

    _favoriteBusStops = allBusStops
        .where(
            (BusStopModel i) => _favoriteBusStopCodes.contains(i.busStopCode))
        .toList();

    notifyListeners();
  }

  bool isFavoriteBusStop(String busStopCode) {
    return _favoriteBusStopCodes.contains(busStopCode);
  }

  Future<void> toggleFavoriteBusStop(
      String busStopCode, bool isFavoriteBusStop) async {
    if (isFavoriteBusStop) {
      await _removeFavoriteBusStop(busStopCode);
    } else {
      await _addFavoriteBusStop(busStopCode);
    }
  }

  Future<void> _addFavoriteBusStop(String busStopCode) async {
    final prefs = await SharedPreferences.getInstance();

    final favoriteBusStops =
        prefs.getStringList(favoriteBusStopsKey) ?? <String>[];

    favoriteBusStops.add(busStopCode);

    await prefs.setStringList(favoriteBusStopsKey, favoriteBusStops);
    await fetchFavoriteBusStops();
    notifyListeners();
  }

  Future<void> _removeFavoriteBusStop(String busStopCode) async {
    final prefs = await SharedPreferences.getInstance();

    final favoriteBusStops =
        prefs.getStringList(favoriteBusStopsKey) ?? <String>[];

    favoriteBusStops.remove(busStopCode);

    await prefs.setStringList(favoriteBusStopsKey, favoriteBusStops);

    await fetchFavoriteBusStops();
    notifyListeners();
  }

  Future<void> clearBusStops() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(favoriteBusStopsKey);
    _favoriteBusStops.clear();
    notifyListeners();
  }
}
