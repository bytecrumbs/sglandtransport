import 'package:flutter_test/flutter_test.dart';
import 'package:lta_datamall_flutter/ui/views/bus/bus_arrival/bus_arrival_viewmodel.dart';
import 'package:mockito/mockito.dart';

import '../setup/test_data.dart' as test_data;
import '../setup/test_helpers.dart';

void main() {
  group('BusArrivalViewModel -', () {
    setUp(() => registerServices());
    tearDown(() => unregisterServices());
    group('busArrivalList -', () {
      test('When constructed should be an empty list', () {
        var model = BusArrivalViewModel();
        expect(model.busArrivalList.isEmpty, true);
      });
    });
    group('Initialise -', () {
      test('When called should get bus arrival times from bus service',
          () async {
        var busService = getAndRegisterBusServiceMock();
        var model = BusArrivalViewModel();
        var busStopCode = '01019';
        await model.initialise(busStopCode);
        verify(busService.getBusArrivalServices(busStopCode));
      });
      test('When called should update the bus arrival list', () async {
        var busStopCode = '11111';
        getAndRegisterBusServiceMock(busStopForBusArrival: busStopCode);
        var model = BusArrivalViewModel();
        await model.initialise(busStopCode);
        var expectedLength = test_data.busArrivalServiceModelList.length;
        expect(model.busArrivalList.length, expectedLength);
      });
    });
  });
}
