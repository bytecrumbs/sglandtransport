import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class FavouritesService {
  static const favouriteBusStopsKey = 'favouriteBusStopsKey';

  Future<bool> isFavouriteBusStop(String busStopCode) async {
    final prefs = await SharedPreferences.getInstance();

    final favouriteBusStops =
        prefs.getStringList(favouriteBusStopsKey) ?? <String>[];
    return favouriteBusStops.contains(busStopCode);
  }

  Future<List<String>> addBusStop(String busStopCode) async {
    final prefs = await SharedPreferences.getInstance();

    final favouriteBusStops =
        prefs.getStringList(favouriteBusStopsKey) ?? <String>[];

    favouriteBusStops.add(busStopCode);

    await prefs.setStringList(favouriteBusStopsKey, favouriteBusStops);

    return await prefs.getStringList(favouriteBusStopsKey);
  }

  Future<List<String>> removeBusStop(String busStopCode) async {
    final prefs = await SharedPreferences.getInstance();

    final favouriteBusStops =
        prefs.getStringList(favouriteBusStopsKey) ?? <String>[];

    favouriteBusStops.remove(busStopCode);

    await prefs.setStringList(favouriteBusStopsKey, favouriteBusStops);

    return await prefs.getStringList(favouriteBusStopsKey);
  }

  Future<List<String>> getFavouriteBusStops() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getStringList(favouriteBusStopsKey) ?? <String>[];
  }

  Future<List<String>> clearBusStops() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(favouriteBusStopsKey);
    return prefs.getStringList(favouriteBusStopsKey) ?? <String>[];
  }
}
