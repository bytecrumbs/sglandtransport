import 'package:flutter_test/flutter_test.dart';

import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:lta_datamall_flutter/models/user_location.dart';
import 'package:lta_datamall_flutter/services/bus/nearby_bus_stops_service_provider.dart';

void main() {
  final busStopList = [
    BusStopModel(
      '01013',
      'roadName1',
      'description1',
      1.29785,
      103.853,
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

  group('Nearby Bus Stops', () {
    test('Should return Nearby Bus Stops', () async {
      final nearbyBusStopsService =
          NearbyBusStopsServiceProvider(allBusStops: busStopList);

      final userLocation = UserLocation(
        latitude: 1.29785,
        longitude: 103.853,
      );

      final nearbyBusStops =
          nearbyBusStopsService.getNearbyBusStops(userLocation);

      expect(nearbyBusStops.length, 1);
      expect(nearbyBusStops[0].busStopCode, busStopList[0].busStopCode);
    });
  });
}
