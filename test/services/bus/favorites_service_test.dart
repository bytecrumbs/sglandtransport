import 'package:flutter_test/flutter_test.dart';
import 'package:lta_datamall_flutter/services/bus/favorites_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('It returns favorite bus stops', () async {
    final List<String> busStops = <String>['123456', '222333'];

    SharedPreferences.setMockInitialValues(
        <String, dynamic>{'favoriteBusStops': busStops});

    final BusFavoritesService favoritesService = BusFavoritesService();
    final List<String> favoriteBusStops =
        await favoritesService.getFavoriteBusStops();

    expect(favoriteBusStops, busStops);
  });
}
