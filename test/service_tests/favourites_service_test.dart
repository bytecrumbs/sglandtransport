import 'package:flutter_test/flutter_test.dart';
import 'package:lta_datamall_flutter/services/favourites_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('FavouritesServiceTest', () {
    group('Bus Stops', () {
      test('returns favourite bus stops when list exists', () async {
        var existingList = [
          '010101',
          '020202',
        ];
        SharedPreferences.setMockInitialValues({
          FavouritesService.favouriteBusStopsKey: existingList,
        });
        final service = FavouritesService();
        var result = await service.getFavouriteBusStops();
        expect(result.length, existingList.length);
      });
      test('returns empty list when the key does not exist', () async {
        SharedPreferences.setMockInitialValues({});
        final service = FavouritesService();
        var result = await service.getFavouriteBusStops();
        expect(result.length, 0);
      });
      test('returns empty list when the list for the given key is empty',
          () async {
        SharedPreferences.setMockInitialValues({
          FavouritesService.favouriteBusStopsKey: [],
        });
        final service = FavouritesService();
        var result = await service.getFavouriteBusStops();
        expect(result.length, 0);
      });
      test('tells if a bus stop is an existing favourite', () async {
        final existingBusStopCode = '010101';
        final nonExistingBusStopCode = '030303';
        SharedPreferences.setMockInitialValues({
          FavouritesService.favouriteBusStopsKey: [
            existingBusStopCode,
            '020202',
          ],
        });
        final service = FavouritesService();
        var result = await service.isFavouriteBusStop(existingBusStopCode);
        expect(result, true);
        result = await service.isFavouriteBusStop(nonExistingBusStopCode);
        expect(result, false);
      });
      test('adds to an empty list', () async {
        var existingList = [];
        SharedPreferences.setMockInitialValues({
          FavouritesService.favouriteBusStopsKey: existingList,
        });

        final service = FavouritesService();

        var result = await service.addBusStop('010101');
        expect(result.length, existingList.length + 1);
      });
      test('adds to an existing list', () async {
        var existingList = [
          '010101',
          '020202',
        ];
        SharedPreferences.setMockInitialValues({
          FavouritesService.favouriteBusStopsKey: existingList,
        });
        final service = FavouritesService();
        var result = await service.addBusStop('030303');
        expect(result.length, existingList.length + 1);
      });
      test('removes a bus stop form an existing list', () async {
        final existingBusStopCode = '010101';
        var existingList = [
          existingBusStopCode,
          '020202',
        ];
        SharedPreferences.setMockInitialValues({
          FavouritesService.favouriteBusStopsKey: existingList,
        });
        final service = FavouritesService();
        var result = await service.removeBusStop(existingBusStopCode);
        expect(result.length, existingList.length - 1);
      });
      test('removes the only remaining bus stop form an existing list',
          () async {
        final existingBusStopCode = '010101';
        var existingList = [
          existingBusStopCode,
        ];
        SharedPreferences.setMockInitialValues({
          FavouritesService.favouriteBusStopsKey: existingList,
        });
        final service = FavouritesService();
        var result = await service.removeBusStop(existingBusStopCode);
        expect(result.length, existingList.length - 1);
      });
      test('removes all favourite bus stops', () async {
        final existingBusStopCode = '010101';
        var existingList = [
          existingBusStopCode,
        ];
        SharedPreferences.setMockInitialValues({
          FavouritesService.favouriteBusStopsKey: existingList,
        });
        final service = FavouritesService();
        var result = await service.clearBusStops();
        expect(result.length, 0);
      });
    });
  });
}
