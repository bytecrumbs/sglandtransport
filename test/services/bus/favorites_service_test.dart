import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:lta_datamall_flutter/services/bus/favorites_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  const String favoriteBusStopsKey = 'favoriteBusStopModels';
  final BusStopModel testBusStopModel1 = BusStopModel(
    '12345',
    'roadName1',
    'description1',
    1.1,
    1.2,
  );
  final String testBusStopModel1String = jsonEncode(testBusStopModel1);
  final BusStopModel testBusStopModel2 = BusStopModel(
    '222333',
    'roadName2',
    'description3',
    1.3,
    1.4,
  );
  final String testBusStopModel2String = jsonEncode(testBusStopModel2);
  final BusStopModel testBusStopModel3 = BusStopModel(
    '111222',
    'roadName3',
    'description3',
    1.5,
    1.6,
  );
  final String testBusStopModel3String = jsonEncode(testBusStopModel3);

  group('Shared Preferences', () {
    test('It returns favorite bus stops', () async {
      final List<String> busStops = <String>[
        testBusStopModel1String,
        testBusStopModel2String
      ];

      SharedPreferences.setMockInitialValues(
          <String, dynamic>{favoriteBusStopsKey: busStops});

      final BusFavoritesService favoritesService = BusFavoritesService();
      final List<BusStopModel> favoriteBusStops =
          await favoritesService.getFavoriteBusStops();

      expect(favoriteBusStops.length, busStops.length);
    });

    test('It tells if a given bus stop is already stored as a Favorite',
        () async {
      final List<String> busStops = <String>[
        testBusStopModel1String,
        testBusStopModel2String
      ];

      SharedPreferences.setMockInitialValues(
          <String, dynamic>{favoriteBusStopsKey: busStops});

      final BusFavoritesService favoritesService = BusFavoritesService();

      bool isFavoriteBusStop =
          await favoritesService.isFavoriteBusStop(testBusStopModel1);
      expect(isFavoriteBusStop, true);

      isFavoriteBusStop =
          await favoritesService.isFavoriteBusStop(testBusStopModel3);
      expect(isFavoriteBusStop, false);
    });

    test('It returns empty list when no favorites are stored', () async {
      SharedPreferences.setMockInitialValues(<String, dynamic>{});

      final BusFavoritesService favoritesService = BusFavoritesService();
      final List<BusStopModel> favoriteBusStops =
          await favoritesService.getFavoriteBusStops();

      expect(favoriteBusStops.length, 0);
    });

    test('It stores a bus stop on an empty list', () async {
      final List<BusStopModel> busStops = <BusStopModel>[
        testBusStopModel1,
        testBusStopModel2,
      ];

      SharedPreferences.setMockInitialValues(<String, dynamic>{});

      final BusFavoritesService favoritesService = BusFavoritesService();
      await favoritesService.addFavoriteBusStop(
        busStops[0],
      );
      await favoritesService.addFavoriteBusStop(
        busStops[1],
      );

      final List<BusStopModel> favoriteBusStops =
          await favoritesService.getFavoriteBusStops();

      expect(favoriteBusStops.length, busStops.length);
    });

    test('It stores a bus stop on an existing list', () async {
      final List<BusStopModel> busStops = <BusStopModel>[
        testBusStopModel1,
        testBusStopModel2,
        testBusStopModel3,
      ];

      SharedPreferences.setMockInitialValues(<String, dynamic>{
        favoriteBusStopsKey: <String>[jsonEncode(busStops[0])],
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
          pref.getStringList(favoriteBusStopsKey);

      expect(favoriteBusStops.length, busStops.length);
    });

    test(
        'It removes a bus stop from an existing list and returns the remaining list',
        () async {
      final List<String> busStops = <String>[
        testBusStopModel1String,
        testBusStopModel2String,
        testBusStopModel3String,
      ];
      final BusStopModel busStopModelToBeRemoved = testBusStopModel2;
      final String busStopStringToBeRemoved = busStops[1];

      SharedPreferences.setMockInitialValues(<String, dynamic>{
        favoriteBusStopsKey: busStops,
      });
      final SharedPreferences pref = await SharedPreferences.getInstance();

      final BusFavoritesService favoritesService = BusFavoritesService();
      final List<BusStopModel> updatedBuStopList =
          await favoritesService.removeFavoriteBusStop(
        busStopModelToBeRemoved,
      );

      busStops.remove(busStopStringToBeRemoved);

      final List<String> favoriteBusStops =
          pref.getStringList(favoriteBusStopsKey);

      // ensure it is removed in Shared Preferences
      expect(favoriteBusStops, busStops);

      // ensure it is removed from the return value of the remove function
      expect(updatedBuStopList.length, busStops.length);
    });

    test(
        'It returns empty list when a bus stop is removed and no more bus stops are stored',
        () async {
      final List<String> busStops = <String>[
        testBusStopModel1String,
      ];
      final String busStopStringToBeRemoved = busStops[0];
      final BusStopModel busStopModelToBeRemoved = testBusStopModel1;

      SharedPreferences.setMockInitialValues(<String, dynamic>{
        'favoriteBusStops': busStops,
      });
      final SharedPreferences pref = await SharedPreferences.getInstance();

      final BusFavoritesService favoritesService = BusFavoritesService();
      final List<BusStopModel> updatedBuStopList =
          await favoritesService.removeFavoriteBusStop(
        busStopModelToBeRemoved,
      );

      busStops.remove(busStopStringToBeRemoved);

      final List<String> favoriteBusStops =
          pref.getStringList('favoriteBusStops');

      // ensure it is removed in Shared Preferences
      expect(favoriteBusStops, busStops);

      // ensure it is removed from the return value of the remove function
      expect(updatedBuStopList.length, 0);
    });
  });
}
