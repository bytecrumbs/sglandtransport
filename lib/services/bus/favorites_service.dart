import 'dart:convert';

import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusFavoritesService {
  factory BusFavoritesService() {
    return _busFavoritesService;
  }

  BusFavoritesService._internal();

  final String favoriteBusStopsKey = 'favoriteBusStopModels';
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

  Future<bool> isFavoriteBusStop(BusStopModel busStopModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String busStopModelString = jsonEncode(busStopModel);

    final List<String> currentFavorites =
        prefs.getStringList(favoriteBusStopsKey) ?? <String>[];

    return currentFavorites.contains(busStopModelString);
  }

  Future<void> addFavoriteBusStop(BusStopModel busStopModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String busStopModelString = jsonEncode(busStopModel);

    final List<String> favoriteBusStops =
        prefs.getStringList(favoriteBusStopsKey) ?? <String>[];

    favoriteBusStops.add(busStopModelString);

    await prefs.setStringList(favoriteBusStopsKey, favoriteBusStops);
  }

  Future<List<BusStopModel>> removeFavoriteBusStop(
      BusStopModel busStopModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<String> favoriteBusStops =
        prefs.getStringList(favoriteBusStopsKey) ?? <String>[];

    final String busStopModelStringToBeRemoved = jsonEncode(busStopModel);

    favoriteBusStops.remove(busStopModelStringToBeRemoved);

    await prefs.setStringList(favoriteBusStopsKey, favoriteBusStops);

    return getFavoriteBusStops();
  }

  Future<void> clearBusStops() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove(favoriteBusStopsKey);
  }
}
