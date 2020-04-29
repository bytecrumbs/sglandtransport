import 'dart:convert';

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
  List<BusStopModel> _allBusStops = <BusStopModel>[];

  List<BusStopModel> _nearbyBusStops = <BusStopModel>[];
  List<BusStopModel> get nearbyBusStops => _nearbyBusStops;

  List<BusStopModel> _favoriteBusStops = <BusStopModel>[];
  List<BusStopModel> get favoriteBusStops => _favoriteBusStops;

  final String favoriteBusStopsKey = 'favoriteBusStopModels';

  Future<void> fetchFavoriteBusStops() async {
    await _fetchAllBusStops();
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<String> favoriteBusStopsValue =
        prefs.getStringList(favoriteBusStopsKey) ?? <String>[];

    _favoriteBusStops = favoriteBusStopsValue
        // ignore: argument_type_not_assignable
        .map((String val) => BusStopModel.fromJson(jsonDecode(val)))
        .toList();

    notifyListeners();
  }

  Future<bool> isFavoriteBusStop(BusStopModel busStopModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String busStopModelString = jsonEncode(busStopModel);

    final List<String> currentFavorites =
        prefs.getStringList(favoriteBusStopsKey) ?? <String>[];

    return currentFavorites.contains(busStopModelString);
  }

  Future<void> toggleFavoriteBusStop(BusStopModel busStopModel) async {
    if (await isFavoriteBusStop(busStopModel)) {
      await _removeFavoriteBusStop(busStopModel);
    } else {
      await _addFavoriteBusStop(busStopModel);
    }
  }

  Future<void> _addFavoriteBusStop(BusStopModel busStopModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String busStopModelString = jsonEncode(busStopModel);

    final List<String> favoriteBusStops =
        prefs.getStringList(favoriteBusStopsKey) ?? <String>[];

    favoriteBusStops.add(busStopModelString);

    await prefs.setStringList(favoriteBusStopsKey, favoriteBusStops);
    await fetchFavoriteBusStops();
    notifyListeners();
  }

  Future<void> _removeFavoriteBusStop(BusStopModel busStopModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<String> favoriteBusStops =
        prefs.getStringList(favoriteBusStopsKey) ?? <String>[];

    final String busStopModelStringToBeRemoved = jsonEncode(busStopModel);

    favoriteBusStops.remove(busStopModelStringToBeRemoved);

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
    await _fetchAllBusStops();
    final List<BusStopModel> searchResult = <BusStopModel>[];
    for (final BusStopModel busStop in _allBusStops) {
      final double distanceInMeters = await Geolocator().distanceBetween(
          position.latitude,
          position.longitude,
          busStop.latitude,
          busStop.longitude);
      final bool isNearby = distanceInMeters <= 500;

      if (isNearby) {
        busStop.distanceInMeters = distanceInMeters.round();
        searchResult.add(busStop);
      }
    }
    _nearbyBusStops = searchResult;
    _nearbyBusStops.sort((BusStopModel a, BusStopModel b) =>
        a.distanceInMeters.compareTo(b.distanceInMeters));
    notifyListeners();
  }

  Future<void> _fetchAllBusStops() async {
    if (_allBusStops.isEmpty) {
      _allBusStops = await fetchBusStopList(http.IOClient());
    }
  }
}
