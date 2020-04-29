import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusFavoritesServiceProvider with ChangeNotifier {
  BusFavoritesServiceProvider() {
    fetchFavoriteBusStops();
  }

  List<BusStopModel> _favoriteBusStops = <BusStopModel>[];
  List<BusStopModel> get favoriteBusStops => _favoriteBusStops;

  final String favoriteBusStopsKey = 'favoriteBusStopModels';

  Future<void> fetchFavoriteBusStops() async {
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
}
