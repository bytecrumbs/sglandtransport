import 'package:flutter_test/flutter_test.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:lta_datamall_flutter/providers/bus/search_bus_stops_provider.dart';

void main() {
  final busStopList = [
    BusStopModel(
      '01013',
      'roadName1',
      'description1',
      1.1,
      1.2,
    ),
    BusStopModel(
      '02049',
      'roadName2',
      'description3',
      1.3,
      1.4,
    ),
    BusStopModel(
      '01019',
      'roadName3',
      'description3',
      1.5,
      1.6,
    ),
    BusStopModel(
      '01020',
      'roadName4',
      'description4',
      1.5,
      1.6,
    )
  ];

  group('Search', () {
    test('Should return list of bus stops if user inputs bus stop code',
        () async {
      final searchBusStopsService =
          SearchBusStopsProvider(allBusStops: busStopList);
      await searchBusStopsService.findBusStops('010');

      expect(searchBusStopsService.busStopSearchList.length, 3);
    });

    test('Should returns list of bus stops if user enters road name', () async {
      final expectedResultList = [busStopList[2]];
      final searchBusStopsService =
          SearchBusStopsProvider(allBusStops: busStopList);
      await searchBusStopsService.findBusStops('roadName3');

      expect(searchBusStopsService.busStopSearchList[0].busStopCode,
          expectedResultList[0].busStopCode);
    });
  });
}
