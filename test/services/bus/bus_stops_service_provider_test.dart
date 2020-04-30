import 'package:flutter_test/flutter_test.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:lta_datamall_flutter/services/bus/bus_stops_service_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  const String favoriteBusStopsKey = 'favoriteBusStopModels';
  final BusStopModel testBusStopModel1 = BusStopModel(
    '01013',
    'roadName1',
    'description1',
    1.1,
    1.2,
  );
  final String testBusStopModel1String = testBusStopModel1.busStopCode;
  final BusStopModel testBusStopModel2 = BusStopModel(
    '02049',
    'roadName2',
    'description3',
    1.3,
    1.4,
  );
  final String testBusStopModel2String = testBusStopModel2.busStopCode;
  final BusStopModel testBusStopModel3 = BusStopModel(
    '01019',
    'roadName3',
    'description3',
    1.5,
    1.6,
  );
  final String testBusStopModel3String = testBusStopModel3.busStopCode;

  group('Shared Preferences', () {
    test('It returns favorite bus stops', () async {
      final List<String> busStops = <String>[
        testBusStopModel1String,
        testBusStopModel2String
      ];

      SharedPreferences.setMockInitialValues(
          <String, dynamic>{favoriteBusStopsKey: busStops});

      final BusStopsServiceProvider favoritesService =
          BusStopsServiceProvider();

      await favoritesService.fetchFavoriteBusStops();

      expect(favoritesService.favoriteBusStops.length, busStops.length);
    });

    test('It tells if a given bus stop is already stored as a Favorite',
        () async {
      final List<String> busStops = <String>[
        testBusStopModel1String,
        testBusStopModel2String
      ];

      SharedPreferences.setMockInitialValues(
          <String, dynamic>{favoriteBusStopsKey: busStops});

      final BusStopsServiceProvider favoritesService =
          BusStopsServiceProvider();

      await favoritesService.fetchFavoriteBusStops();

      expect(favoritesService.isFavoriteBusStop(testBusStopModel1.busStopCode),
          true);

      expect(favoritesService.isFavoriteBusStop(testBusStopModel3.busStopCode),
          false);
    });

    test('It returns empty list when no favorites are stored', () async {
      SharedPreferences.setMockInitialValues(<String, dynamic>{});

      final BusStopsServiceProvider favoritesService =
          BusStopsServiceProvider();
      await favoritesService.fetchFavoriteBusStops();

      expect(favoritesService.favoriteBusStops.length, 0);
    });

    test('It stores a bus stop on an empty list', () async {
      final List<String> busStops = <String>[
        testBusStopModel1String,
        testBusStopModel2String,
      ];

      SharedPreferences.setMockInitialValues(<String, dynamic>{});
      final SharedPreferences pref = await SharedPreferences.getInstance();

      final BusStopsServiceProvider favoritesService =
          BusStopsServiceProvider();
      await favoritesService.toggleFavoriteBusStop(
        busStops[0],
        false,
      );
      await favoritesService.toggleFavoriteBusStop(
        busStops[1],
        false,
      );

      final List<String> favoriteBusStops =
          pref.getStringList(favoriteBusStopsKey);

      expect(favoriteBusStops.length, busStops.length);

      await favoritesService.fetchFavoriteBusStops();

      expect(favoritesService.favoriteBusStops.length, busStops.length);
    });

    test('It stores a bus stop on an existing list', () async {
      final List<String> busStops = <String>[
        testBusStopModel1String,
        testBusStopModel2String,
        testBusStopModel3String,
      ];

      SharedPreferences.setMockInitialValues(<String, dynamic>{
        favoriteBusStopsKey: <String>[busStops[0]],
      });
      final SharedPreferences pref = await SharedPreferences.getInstance();

      final BusStopsServiceProvider favoritesService =
          BusStopsServiceProvider();
      await favoritesService.toggleFavoriteBusStop(
        busStops[1],
        false,
      );
      await favoritesService.toggleFavoriteBusStop(
        busStops[2],
        false,
      );

      final List<String> favoriteBusStops =
          pref.getStringList(favoriteBusStopsKey);

      expect(favoriteBusStops.length, busStops.length);

      await favoritesService.fetchFavoriteBusStops();

      expect(favoritesService.favoriteBusStops.length, busStops.length);
    });

    test('It removes a bus stop from an existing list', () async {
      final List<String> busStops = <String>[
        testBusStopModel1String,
        testBusStopModel2String,
        testBusStopModel3String,
      ];
      final String busStopStringToBeRemoved = busStops[1];

      SharedPreferences.setMockInitialValues(<String, dynamic>{
        favoriteBusStopsKey: busStops,
      });
      final SharedPreferences pref = await SharedPreferences.getInstance();

      final BusStopsServiceProvider favoritesService =
          BusStopsServiceProvider();
      await favoritesService.toggleFavoriteBusStop(
        busStopStringToBeRemoved,
        true,
      );

      busStops.remove(busStopStringToBeRemoved);

      // ensure it is removed in Shared Preferences
      final List<String> favoriteBusStops =
          pref.getStringList(favoriteBusStopsKey);
      expect(favoriteBusStops, busStops);

      // ensure it is removed from the provider list
      expect(favoritesService.favoriteBusStops.length, busStops.length);
    });

    test(
        'It returns empty list when a bus stop is removed and no more bus stops are stored',
        () async {
      final List<String> busStops = <String>[
        testBusStopModel1String,
      ];
      final String busStopStringToBeRemoved = busStops[0];

      SharedPreferences.setMockInitialValues(<String, dynamic>{
        favoriteBusStopsKey: busStops,
      });
      final SharedPreferences pref = await SharedPreferences.getInstance();

      final BusStopsServiceProvider favoritesService =
          BusStopsServiceProvider();
      await favoritesService.toggleFavoriteBusStop(
        busStopStringToBeRemoved,
        true,
      );

      busStops.remove(busStopStringToBeRemoved);

      final List<String> favoriteBusStops =
          pref.getStringList(favoriteBusStopsKey);

      // ensure it is removed in Shared Preferences
      expect(favoriteBusStops.length, 0);

      // ensure it is removed from the return value of the remove function
      expect(favoritesService.favoriteBusStops.length, busStops.length);
    });

    test('It clears the bus stop favorites', () async {
      SharedPreferences.setMockInitialValues(<String, dynamic>{
        favoriteBusStopsKey: <String>[
          testBusStopModel1String,
          testBusStopModel2String,
        ],
      });
      final SharedPreferences pref = await SharedPreferences.getInstance();

      final BusStopsServiceProvider favoritesService =
          BusStopsServiceProvider();

      await favoritesService.clearBusStops();

      final List<String> favoriteBusStops =
          pref.getStringList(favoriteBusStopsKey);

      expect(favoriteBusStops, null);
      expect(favoritesService.favoriteBusStops.length, 0);
    });
  });
}
