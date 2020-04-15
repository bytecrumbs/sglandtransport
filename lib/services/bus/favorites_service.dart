import 'package:shared_preferences/shared_preferences.dart';

class BusFavoritesService {
  factory BusFavoritesService() {
    return _busFavoritesService;
  }

  BusFavoritesService._internal();

  static final BusFavoritesService _busFavoritesService =
      BusFavoritesService._internal();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<List<String>> getFavoriteBusStops() async {
    final SharedPreferences prefs = await _prefs;

    return prefs.getStringList('favoriteBusStops');
  }
}
