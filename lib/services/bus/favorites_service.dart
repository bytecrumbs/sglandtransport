import 'package:shared_preferences/shared_preferences.dart';

class BusFavoritesService {
  factory BusFavoritesService() {
    return _busFavoritesService;
  }

  BusFavoritesService._internal();

  final String favoriteBusStopsString = 'favoriteBusStops';
  static final BusFavoritesService _busFavoritesService =
      BusFavoritesService._internal();

  Future<List<String>> getFavoriteBusStops() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getStringList(favoriteBusStopsString) ?? <String>[];
  }

  Future<void> addFavoriteBusStop(String busStopCode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<String> favoriteBusStops =
        prefs.getStringList(favoriteBusStopsString) ?? <String>[];

    favoriteBusStops.add(busStopCode);

    await prefs.setStringList(favoriteBusStopsString, favoriteBusStops);
  }

  Future<List<String>> removeFavoriteBusStop(String busStopCode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<String> favoriteBusStops = await getFavoriteBusStops();

    favoriteBusStops.remove(busStopCode);

    await prefs.setStringList(favoriteBusStopsString, favoriteBusStops);

    return getFavoriteBusStops();
  }
}
