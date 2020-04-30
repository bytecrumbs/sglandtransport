import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lta_datamall_flutter/api.dart';
import 'package:http/io_client.dart' as http;
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusStopsServiceProvider with ChangeNotifier {
  BusStopsServiceProvider() {
    fetchFavoriteBusStops();
  }
  List<BusStopModel> _allBusStopsNearby = <BusStopModel>[];
  List<BusStopModel> _allBusStopsFavorites = <BusStopModel>[];

  List<BusStopModel> _nearbyBusStops = <BusStopModel>[];
  List<BusStopModel> get nearbyBusStops => _nearbyBusStops;

  List<BusStopModel> _favoriteBusStops = <BusStopModel>[];
  List<BusStopModel> get favoriteBusStops => _favoriteBusStops;

  List<String> _favoriteBusStopCodes = <String>[];

  final String favoriteBusStopsKey = 'favoriteBusStopModels';

  Future<void> fetchFavoriteBusStops() async {
    await _fetchAllBusStopsForFavorites();
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    _favoriteBusStopCodes =
        prefs.getStringList(favoriteBusStopsKey) ?? <String>[];

    final List<BusStopModel> tempFavoriteBusStops = _allBusStopsFavorites
        .where(
            (BusStopModel i) => _favoriteBusStopCodes.contains(i.busStopCode))
        .toList();

    _favoriteBusStops = tempFavoriteBusStops.map((BusStopModel item) {
      item.distanceInMeters = null;
      return item;
    }).toList();

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
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<String> favoriteBusStops =
        prefs.getStringList(favoriteBusStopsKey) ?? <String>[];

    favoriteBusStops.add(busStopCode);

    await prefs.setStringList(favoriteBusStopsKey, favoriteBusStops);
    await fetchFavoriteBusStops();
    notifyListeners();
  }

  Future<void> _removeFavoriteBusStop(String busStopCode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<String> favoriteBusStops =
        prefs.getStringList(favoriteBusStopsKey) ?? <String>[];

    favoriteBusStops.remove(busStopCode);

    await prefs.setStringList(favoriteBusStopsKey, favoriteBusStops);

    await fetchFavoriteBusStops();
    notifyListeners();
  }

  Future<void> clearBusStops() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove(favoriteBusStopsKey);
    _favoriteBusStops.clear();
    notifyListeners();
  }

  Future<void> setNearbyBusStop(Position position) async {
    await _fetchAllBusStopsForNearby();
    _nearbyBusStops = <BusStopModel>[];
    for (final BusStopModel busStop in _allBusStopsNearby) {
      final double distanceInMeters = await Geolocator().distanceBetween(
          position.latitude,
          position.longitude,
          busStop.latitude,
          busStop.longitude);
      final bool isNearby = distanceInMeters <= 500;

      if (isNearby) {
        busStop.distanceInMeters = distanceInMeters.round();
        _nearbyBusStops.add(busStop);
      }
    }
    _nearbyBusStops.sort((BusStopModel a, BusStopModel b) =>
        a.distanceInMeters.compareTo(b.distanceInMeters));
    notifyListeners();
  }

  Future<void> _fetchAllBusStopsForNearby() async {
    if (_allBusStopsNearby.isEmpty) {
      _allBusStopsNearby = await fetchBusStopList(http.IOClient());
    }
  }

  Future<void> _fetchAllBusStopsForFavorites() async {
    if (_allBusStopsFavorites.isEmpty) {
      _allBusStopsFavorites = await fetchBusStopList(http.IOClient());
    }
  }
}
