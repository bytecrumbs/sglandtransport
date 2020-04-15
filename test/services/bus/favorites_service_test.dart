import 'package:flutter_test/flutter_test.dart';
import 'package:lta_datamall_flutter/services/bus/favorites_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Shared Preferences', () {
    test('It returns favorite bus stops', () async {
      final List<String> busStops = <String>['123456', '222333'];

      SharedPreferences.setMockInitialValues(
          <String, dynamic>{'favoriteBusStops': busStops});

      final BusFavoritesService favoritesService = BusFavoritesService();
      final List<String> favoriteBusStops =
          await favoritesService.getFavoriteBusStops();

      expect(favoriteBusStops, busStops);
    });

    test('It stores a bus stop on an empty list', () async {
      final List<String> busStops = <String>['123456', '222333'];

      SharedPreferences.setMockInitialValues(<String, dynamic>{});
      final SharedPreferences pref = await SharedPreferences.getInstance();

      final BusFavoritesService favoritesService = BusFavoritesService();
      await favoritesService.addFavoriteBusStop(
        busStops[0],
      );
      await favoritesService.addFavoriteBusStop(
        busStops[1],
      );

      final List<String> favoriteBusStops =
          pref.getStringList('favoriteBusStops');

      expect(favoriteBusStops, busStops);
    });

    test('It stores a bus stop on an existing list', () async {
      final List<String> busStops = <String>['111111', '123456', '222333'];

      SharedPreferences.setMockInitialValues(<String, dynamic>{
        'favoriteBusStops': <String>[busStops[0]],
      });
      final SharedPreferences pref = await SharedPreferences.getInstance();

      final BusFavoritesService favoritesService = BusFavoritesService();
      await favoritesService.addFavoriteBusStop(
        busStops[1],
      );
      await favoritesService.addFavoriteBusStop(
        busStops[2],
      );

      final List<String> favoriteBusStops =
          pref.getStringList('favoriteBusStops');

      expect(favoriteBusStops, busStops);
    });
  });
}
