import 'dart:convert';

import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusFavoritesService {
  factory BusFavoritesService() {
    return _busFavoritesService;
  }

  BusFavoritesService._internal();

  final String favoriteBusStopsKey = 'favoriteBusStops';
  static final BusFavoritesService _busFavoritesService =
      BusFavoritesService._internal();

  Future<List<BusStopModel>> getFavoriteBusStops() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<String> favoriteBusStopsValue =
        prefs.getStringList(favoriteBusStopsKey) ?? <String>[];

    final List<BusStopModel> result = favoriteBusStopsValue
        // ignore: argument_type_not_assignable
        .map((String val) => BusStopModel.fromJson(jsonDecode(val)))
        .toList();

    return result ?? <BusStopModel>[];
  }

  Future<bool> isFavoriteBusStop(String busStopCode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<String> currentFavorites =
        prefs.getStringList(favoriteBusStopsKey) ?? <String>[];

    return currentFavorites.contains(busStopCode);
  }

  Future<void> addFavoriteBusStop(String busStopCode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<String> favoriteBusStops =
        prefs.getStringList(favoriteBusStopsKey) ?? <String>[];

    favoriteBusStops.add(busStopCode);

    await prefs.setStringList(favoriteBusStopsKey, favoriteBusStops);
  }

  Future<List<BusStopModel>> removeFavoriteBusStop(String busStopCode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<String> favoriteBusStops =
        prefs.getStringList(favoriteBusStopsKey) ?? <String>[];

    favoriteBusStops.remove(busStopCode);

    await prefs.setStringList(favoriteBusStopsKey, favoriteBusStops);

    return getFavoriteBusStops();
  }
}
