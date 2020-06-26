import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class FavouritesService {
  static final _log = Logger('FavouritesService');
  static const favouriteBusStopsKey = 'favouriteBusStopsKey';

  Future<bool> isFavouriteBusStop(String busStopCode) async {
    _log.info('checking if $busStopCode is marked as favourite bus stop');
    final prefs = await SharedPreferences.getInstance();

    final favouriteBusStops =
        prefs.getStringList(favouriteBusStopsKey) ?? <String>[];
    return favouriteBusStops.contains(busStopCode);
  }

  Future<List<String>> addBusStop(String busStopCode) async {
    _log.info('adding bus $busStopCode to favourites');
    final prefs = await SharedPreferences.getInstance();

    final favouriteBusStops =
        prefs.getStringList(favouriteBusStopsKey) ?? <String>[];

    favouriteBusStops.add(busStopCode);

    await prefs.setStringList(favouriteBusStopsKey, favouriteBusStops);

    return await prefs.getStringList(favouriteBusStopsKey);
  }

  Future<List<String>> removeBusStop(String busStopCode) async {
    _log.info('removing bus $busStopCode from favourites');
    final prefs = await SharedPreferences.getInstance();

    final favouriteBusStops =
        prefs.getStringList(favouriteBusStopsKey) ?? <String>[];

    favouriteBusStops.remove(busStopCode);

    await prefs.setStringList(favouriteBusStopsKey, favouriteBusStops);

    return await prefs.getStringList(favouriteBusStopsKey);
  }

  Future<List<String>> getFavouriteBusStops() async {
    _log.info('getting all favourite bus stops');
    final prefs = await SharedPreferences.getInstance();

    return prefs.getStringList(favouriteBusStopsKey) ?? <String>[];
  }

  Future<List<String>> clearBusStops() async {
    _log.info('clearing all favourite bus stops');
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(favouriteBusStopsKey);
    return prefs.getStringList(favouriteBusStopsKey) ?? <String>[];
  }
}
